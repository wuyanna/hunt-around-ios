//
//  OCAHPickerView.h
//  OCAFramework
//
//  Created by Wu Yanna on 12-5-22.
//  Copyright (c) 2012年 DP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCAHTableView.h"
@protocol OCAHPickerViewDataSource,OCAHPickerViewDelegate;
@interface OCAHPickerView : UIView<OCAHTableViewDataSource,OCAHTableViewDelegate> {
    NSMutableArray            *_tables;
    UIView                    *_topFrame;
    NSMutableArray            *_dividers;
    NSMutableArray            *_selectionBars;
    id<OCAHPickerViewDataSource> _dataSource;
    id<OCAHPickerViewDelegate>   _delegate;
    UIView                    *_backgroundView;
    NSInteger                  _numberOfComponents;
    UIView                    *_pickerContentView;
    UIView                    *_selectionBar;
}

@property(nonatomic,assign) id<OCAHPickerViewDataSource> dataSource;                // default is nil. weak reference
@property(nonatomic,assign) id<OCAHPickerViewDelegate>   delegate;                  // default is nil. weak reference
@property(nonatomic)        BOOL                       showsSelectionIndicator;   // default is NO
@property(nonatomic,readonly)   UIView  *backgroundView;
@property(nonatomic,readonly)   UIView  *topFrame;
// info that was fetched and cached from the data source and delegate
@property(nonatomic,readonly) NSInteger numberOfComponents;
- (NSInteger)numberOfColumnsInComponent:(NSInteger)component;
- (CGSize)columnSizeForComponent:(NSInteger)component;

// returns the view provided by the delegate via pickerView:viewForRow:forComponent:reusingView:
// or nil if the row/component is not visible or the delegate does not implement 
// pickerView:viewForRow:forComponent:reusingView:
- (UIView *)viewForColumn:(NSInteger)column forComponent:(NSInteger)component;

// Reloading whole view or single component
- (void)reloadAllComponents;
- (void)reloadComponent:(NSInteger)component;

// selection. in this case, it means showing the appropriate row in the middle
- (void)selectColumn:(NSInteger)column inComponent:(NSInteger)component animated:(BOOL)animated;  // scrolls the specified row to center.

- (NSInteger)selectedColumnInComponent:(NSInteger)component;                                   // returns selected row. -1 if nothing selected

@end

@protocol OCAHPickerViewDataSource<NSObject>
@required

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(OCAHPickerView *)pickerView;

// returns the # of rows in each component..
- (NSInteger)pickerView:(OCAHPickerView *)pickerView numberOfColumnsInComponent:(NSInteger)component;
@end


@protocol OCAHPickerViewDelegate<NSObject>
@optional

// returns width of column and height of row for each component. 
- (CGFloat)pickerView:(OCAHPickerView *)pickerView heightForComponent:(NSInteger)component;
- (CGFloat)pickerView:(OCAHPickerView *)pickerView columnWidthForComponent:(NSInteger)component;

// these methods return either a plain UIString, or a view (e.g UILabel) to display the row for the component.
// for the view versions, we cache any hidden and thus unused views and pass them back for reuse. 
// If you return back a different object, the old one will be released. the view will be centered in the row rect  
- (NSString *)pickerView:(OCAHPickerView *)pickerView titleForColumn:(NSInteger)column forComponent:(NSInteger)component;
- (UIView *)pickerView:(OCAHPickerView *)pickerView viewForColumn:(NSInteger)column forComponent:(NSInteger)component reusingView:(UIView *)view;

- (void)pickerView:(OCAHPickerView *)pickerView didSelectColumn:(NSInteger)column inComponent:(NSInteger)component;

@end
