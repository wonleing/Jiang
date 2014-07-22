//
//  NPPopularUserView.m
//  newsPicks
//
//  Created by yunqi on 14-7-22.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "NPPopularUserView.h"

@implementation NPPopularUserView
@synthesize leveImageView=_leveImageView;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)init
{
    self=[super init];
    if (self) {
        _leveImageView=[[UIImageView alloc] init];
        _leveImageView.frame=CGRectMake(0, 0, 20, 10);
        _leveImageView.contentMode=UIViewContentModeScaleAspectFill;
        _leveImageView.clipsToBounds=YES;
        [self addSubview:_leveImageView];
        self.clipsToBounds=NO;
    }
    return self;
}
-(void)setFrame:(CGRect)frame
{
    _leveImageView.frame=CGRectMake(-_leveImageView.frame.size.width/2, -_leveImageView.frame.size.height/2, _leveImageView.frame.size.width, _leveImageView.frame.size.height);
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
