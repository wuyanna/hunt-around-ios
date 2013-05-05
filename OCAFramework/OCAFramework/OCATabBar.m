//
//  OCATabBar.m
//  OCAFramework
//
//  Created by Wu Yanna on 12-2-28.
//  Copyright (c) 2012年 DP. All rights reserved.
//

#import "OCATabBar.h"

@interface OCATabBar (Private)

- (UIImage*)itemImage:(UIImage*)originImage size:(CGSize)targetSize backgroundImage:(UIImage*)bgImage;
- (CGSize)sizeForBarItem;
- (CGSize)sizeForItemImage;
- (UIImage*)imageForSelection;
- (UIImage*)imageMaskCreate:(UIImage*)maskImage;
- (UIImage*)imageForBG;
- (UIImage*)imageForItemBgWithImage:(UIImage*)bgImage;
- (UIButton*)renderItem:(UITabBarItem*)item;
@end

@implementation OCATabBar

@synthesize items               = _items;
@synthesize selectedItem        = _selectedItem;
@synthesize delegate            = _delegate;
@synthesize selectedImage       = _selectedImage;
@synthesize highlightedImage    = _highlightedImage;
@synthesize backgroundImage     = _backgroundImage;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _selectedImage = [UIImage imageNamed:@"TabBarSelection.png"];
        _highlightedImage = [UIImage imageNamed:@"TabBarHighlightItem.png"];
        _backgroundImage = [UIImage imageNamed:@"TabBarGradient.png"];
        _backgroundImageView = [[[UIImageView alloc] initWithImage:[self imageForBG]] autorelease];
        _backgroundImageView.frame = CGRectMake(0.0, 0.0, frame.size.width, frame.size.height);
        [self addSubview:_backgroundImageView];
    }
    return self;
}
//设置tab bar items，并添加到界面上
//如果要设置selectedImage和Highlightedimage必须在调用此方法之前设置
- (void)setItems:(NSArray *)items {
    if (items != _items) {
        [_itmButtons release];
        [_items release];
        _items = [items retain];
        _itmButtons = [[NSMutableArray alloc] initWithCapacity:[items count]];
        CGFloat horizontalOffset = 0;
        for (UITabBarItem* tbi in _items) {
            UIButton* itm_btn = [self renderItem:tbi];
            [itm_btn addTarget:self action:@selector(btnDidSelect:) forControlEvents:UIControlEventAllTouchEvents];
            itm_btn.frame = CGRectMake(horizontalOffset, 0.0, [self sizeForBarItem].width, [self sizeForBarItem].height);
            [self addSubview:itm_btn];
            [_itmButtons addObject:itm_btn];
            horizontalOffset += [self sizeForBarItem].width;
        }
    }
    
}

- (UIButton*)renderItem:(UITabBarItem*)item {    
    
    UIImage* originImage = item.image;
    UIImage* unselectedImage = [self itemImage:originImage size:[self sizeForItemImage] backgroundImage:nil];
    UIImage* selectedImage = [self itemImage:originImage size:[self sizeForItemImage] backgroundImage:self.highlightedImage];
    
    UIButton* btn = [[[UIButton alloc] init] autorelease];
    //为TabBarItem的不同选中状态设置图片
    [btn setImageEdgeInsets:UIEdgeInsetsMake(5.0, [self sizeForBarItem].width/2-[self sizeForItemImage].width/2, [self sizeForBarItem].height/4, [self sizeForBarItem].width/2-[self sizeForItemImage].width/2)];
    [btn setImage:unselectedImage forState:UIControlStateNormal];
    [btn setImage:selectedImage forState:UIControlStateHighlighted];
    [btn setImage:selectedImage forState:UIControlStateSelected];
    
    [btn setBackgroundImage:[self imageForSelection] forState:UIControlStateSelected];
    [btn setBackgroundImage:[self imageForSelection] forState:UIControlStateHighlighted];
    
    [btn setTitle:item.title forState:UIControlStateNormal];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake([self sizeForBarItem].height*3/4, -[self sizeForBarItem].width/2, 0.0, 5.0)];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:11];
    btn.adjustsImageWhenHighlighted = NO;
    return btn;
}

- (void)setBackgroundImage:(UIImage *)backgroundImage {
    if (backgroundImage != _backgroundImage) {
        [_backgroundImage release];
        _backgroundImage = [backgroundImage retain];
        _backgroundImageView.image = _backgroundImage;
    }
}

- (void)setSelectedItem:(UITabBarItem *)selectedItem {
    if (selectedItem != _selectedItem) {
        //_selectedItem.selected = NO;
        [_selectedItem release];
        _selectedItem = [selectedItem retain];
        
        //为了避免两个按钮同时选种的情况
        for (int i = 0; i < [_items count]; i++) {
            UIButton* btn = [_itmButtons objectAtIndex:i];
            if ([_items objectAtIndex:i] == selectedItem) {
                btn.selected = YES;
                btn.highlighted = btn.selected ? NO : YES;
            }else{
                btn.selected = NO;
                btn.highlighted = NO;
            }
        }
        // ---------------- Which one is more efficient? ---------------
        //        for (UITabBarItem* i in _items) {
        //            UIButton* btn = [_itmButtons objectAtIndex:[_items indexOfObject:i]];
        //            if (i == selectedItem) {
        //                btn.selected = YES;
        //                btn.highlighted = btn.selected ? NO : YES;
        //            }else{
        //                btn.selected = NO;
        //                btn.highlighted = NO;
        //            }
        //        }
    }
}

- (CGSize)sizeForBarItem {
    return CGSizeMake(self.frame.size.width/[_items count], self.frame.size.height);
}

- (CGSize)sizeForItemImage {
    return CGSizeMake(self.frame.size.height*3/4, self.frame.size.height*3/4);
}

- (UIImage*)imageForSelection {
    UIGraphicsBeginImageContextWithOptions([self sizeForBarItem],NO,0);
    UIImage* stretchedSEL = [self.selectedImage stretchableImageWithLeftCapWidth:4.0 topCapHeight:0];
    [stretchedSEL drawInRect:CGRectMake(0.0, 4.0, [self sizeForBarItem].width, [self sizeForBarItem].height-8.0)];
    UIImage* selectedItemImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return selectedItemImage;
}

- (UIImage*)imageForBG {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.frame.size.width, self.frame.size.height), NO, 0.0);
    UIImage* stretchedBg = [self.backgroundImage stretchableImageWithLeftCapWidth:0 topCapHeight:0];
    [stretchedBg drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    UIImage* bgImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return bgImage;
}

// The background is either the passed in background image (for the blue selected state) or gray (for the non-selected state)
- (UIImage*)imageForItemBgWithImage:(UIImage*)bgImage{
    UIGraphicsBeginImageContextWithOptions([self sizeForItemImage], NO, 0);
    if (bgImage){
        [bgImage drawInRect:CGRectMake(([self sizeForItemImage].width-CGImageGetWidth(bgImage.CGImage))/2, ([self sizeForItemImage].height-CGImageGetHeight(bgImage.CGImage))/2, CGImageGetWidth(bgImage.CGImage), CGImageGetHeight(bgImage.CGImage))];
    }else{
        [[UIColor lightGrayColor] set];
        UIRectFill(CGRectMake(0, 0, [self sizeForItemImage].width, [self sizeForItemImage].height));
    }
    
    UIImage* itemBgImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return itemBgImage;
}

- (void)btnDidSelect:(UIButton*)btn{
    _selectedIndex = [_itmButtons indexOfObject:btn];
    //点击已选中按钮
    if (_selectedIndex == [_items indexOfObject:self.selectedItem]) {
        //为了防止系统在点击事件时自动设置selected和highlighted值
        btn.selected = YES;
        btn.highlighted = NO;
        return;
    }
    if ([_delegate respondsToSelector:@selector(tabBar:didSelectItem:)]) {
        UITabBarItem* item = [_items objectAtIndex:_selectedIndex];
        [self setSelectedItem:item];
        [_delegate tabBar:self didSelectItem:item];
    }
}

- (UIImage*)itemImage:(UIImage*)originImage size:(CGSize)targetSize backgroundImage:(UIImage*)bgImage{
    UIImage* itemBgImage = [self imageForItemBgWithImage:bgImage];
    UIImage* maskImage = [self imageMaskCreate:originImage];
    
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskImage.CGImage), 
                                        CGImageGetHeight(maskImage.CGImage), 
                                        CGImageGetBitsPerComponent(maskImage.CGImage),
                                        CGImageGetBitsPerPixel(maskImage.CGImage),
                                        CGImageGetBytesPerRow(maskImage.CGImage), 
                                        CGImageGetDataProvider(maskImage.CGImage), NULL, YES);
    //Using mask to create image
    CGImageRef itemImageRef = CGImageCreateWithMask(itemBgImage.CGImage, mask);
    UIImage* itemImage = [UIImage imageWithCGImage:itemImageRef scale:originImage.scale orientation:originImage.imageOrientation];
    
    CGImageRelease(mask);
    CGImageRelease(itemImageRef);
    
    UIGraphicsBeginImageContextWithOptions(targetSize, NO, 0.0);
    [itemImage drawInRect:CGRectMake(targetSize.width/2.0-originImage.size.width/2.0, targetSize.height/2.0-originImage.size.height/2.0, originImage.size.width, originImage.size.height)];
    
    UIImage* resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

//创建mask：将背景设为白色，图像设为黑色
- (UIImage*)imageMaskCreate:(UIImage*)maskImage{
    CGRect imageRect = CGRectMake(0.0, 0.0, CGImageGetWidth(maskImage.CGImage), CGImageGetHeight(maskImage.CGImage));
    CGContextRef context = CGBitmapContextCreate(NULL, CGImageGetWidth(maskImage.CGImage), CGImageGetHeight(maskImage.CGImage), 8, 0, CGImageGetColorSpace(maskImage.CGImage), kCGImageAlphaPremultipliedLast);
    CGContextSetRGBFillColor(context, 1, 1, 1, 1);
    CGContextFillRect(context, imageRect);
    
    CGContextClipToMask(context, imageRect, maskImage.CGImage);
    CGContextSetRGBFillColor(context, 0, 0, 0, 1);
    CGContextFillRect(context, imageRect);
    
    CGImageRef newMaskCG = CGBitmapContextCreateImage(context);
    UIImage* newMaskImage = [UIImage imageWithCGImage:newMaskCG scale:maskImage.scale orientation:maskImage.imageOrientation];
    
    CGContextRelease(context);
    CGImageRelease(newMaskCG);
    
    return newMaskImage;
}

- (NSUInteger)indexForItem:(UITabBarItem*)item {
    return [self.items indexOfObject:item];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

- (void)dealloc
{
    release(_items);
    release(_itmButtons);
    release(_selectedItem);
    //self.selectedImage = nil;
    release(_selectedImage);
    release(_highlightedImage);
    release(_backgroundImage);
    [super dealloc];
    
}
@end
