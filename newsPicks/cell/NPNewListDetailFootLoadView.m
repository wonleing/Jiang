//
//  NPNewListDetailFootLoadView.m
//  newsPicks
//
//  Created by yunqi on 14-7-23.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "NPNewListDetailFootLoadView.h"
@interface NPNewListDetailFootLoadView()
{
    
}
@end
@implementation NPNewListDetailFootLoadView
@synthesize activityIndicatorView=_activityIndicatorView;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubView];
        // Initialization code
    }
    return self;
}
-(id)init
{
    if (self=[super init]) {
        [self initSubView];
    }
    return self;
}
-(void)initSubView
{
    _activityIndicatorView=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityIndicatorView.frame=CGRectMake(0, 0, 10, 10);
    [self addSubview:_activityIndicatorView];
}
-(void)setFrame:(CGRect)frame
{
    _activityIndicatorView.center=CGPointMake(frame.size.width/2, frame.size.height/2);
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
