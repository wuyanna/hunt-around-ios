//
//  MapOverlay.m
//  HuntAround
//
//  Created by Hou yutao on 9/12/12.
//
//

#import "MapOverlay.h"

@implementation MapOverlay
@synthesize title;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (IBAction)dismiss:(id)sender
{
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc {
    [title release];
    [super dealloc];
}
@end
