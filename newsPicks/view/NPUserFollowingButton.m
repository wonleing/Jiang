//
//  NPUserFollowingButton.m
//  newsPicks
//
//  Created by yunqi on 14-7-24.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "NPUserFollowingButton.h"
@interface NPUserFollowingButton()
{
    UIActivityIndicatorView *activityView;
}
@end
@implementation NPUserFollowingButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        activityView=[[UIActivityIndicatorView alloc]init];
        activityView.frame=CGRectMake(0, 0, 10, 10);
        activityView.activityIndicatorViewStyle=UIActivityIndicatorViewStyleGray ;
        [self addSubview:activityView];
        // Initialization code
    }
    return self;
}
-(void)setHighlighted:(BOOL)highlighted
{
    if (highlighted) {
        [activityView startAnimating];
    }else
    {
        [activityView stopAnimating];
    }
    [super setHighlighted:highlighted];
}
-(void)setFrame:(CGRect)frame
{
    activityView.center=CGPointMake(frame.size.width/2, frame.size.height/2);
    [super setFrame:frame];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
