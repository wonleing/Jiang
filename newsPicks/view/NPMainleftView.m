//
//  NPMainleftView.m
//  newsPicks
//
//  Created by yunqi on 14-7-28.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "NPMainleftView.h"

@implementation NPMainleftView
@synthesize delegate=_delegate;
+(NPMainleftView *)mainLeftView
{
    return [[NPMainleftView alloc]initWithFrame:CGRectMake(0, IOS7_OR_LATER?20:0, 40, 40*3)];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self restSubView];
        // Initialization code
    }
    return self;
}
-(void)restSubView
{
    UIButton *btn1=[UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame=CGRectMake(0, 0, 40, 40);
    btn1.tag=100;
    [btn1 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn1];
    [btn1 setBackgroundImage:[UIImage imageNamed:NP_IMG_TIME_ONLINE_DEFAULT] forState:UIControlStateNormal];
    
    UIButton *btn2=[UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame=CGRectMake(0, btn1.frame.size.height+btn1.frame.origin.y, 40, 40);
    btn2.tag=101;
    btn2.highlighted=YES;
    [btn2 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn2];
    [btn2 setBackgroundImage:[UIImage imageNamed:NP_IMG_TIME_ONLINE_DEFAULT] forState:UIControlStateNormal];
    
    UIButton *btn3=[UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame=CGRectMake(0, btn2.frame.size.height+btn2.frame.origin.y, 40, 40);
    btn3.tag=102;
    [btn3 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn3];
    [btn3 setBackgroundImage:[UIImage imageNamed:NP_IMG_TIME_ONLINE_DEFAULT] forState:UIControlStateNormal];
    
}
-(void)click:(UIButton*)btn
{
    if (btn.tag==100) {
        if ([_delegate respondsToSelector:@selector(NPMainleftViewClickOne)]) {
            [_delegate NPMainleftViewClickOne];
        }
    }
    if (btn.tag==101) {
        if ([_delegate respondsToSelector:@selector(NPMainleftViewClickTwo)]) {
            [_delegate NPMainleftViewClickTwo];
        }
    }
    if (btn.tag==102) {
        if ([_delegate respondsToSelector:@selector(NPMainleftViewClickThree )]) {
            [_delegate NPMainleftViewClickThree];
        }
    }
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
