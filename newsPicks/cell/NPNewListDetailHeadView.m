//
//  NPNewListDetailHeadView.m
//  newsPicks
//
//  Created by yunqi on 14-7-23.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "NPNewListDetailHeadView.h"
#import "NPListModel.h"
#import "TTTAttributedLabel.h"
#define NPNewListDetailHeadView_topPlace 10
#define NPNewListDetailHeadView_leftPlace 10
#define NPNewListDetailHeadView_title_type_place 5
#define NPNewListDetailHeadView_time_content_place 6
@implementation NPNewListDetailHeadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)restSubView:(NPListModel *)model
{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    self.frame=CGRectZero;
    TTTAttributedLabel *title=[[TTTAttributedLabel alloc]init];
    title.frame=CGRectMake(NPNewListDetailHeadView_leftPlace, NPNewListDetailHeadView_topPlace, [UIScreen mainScreen].bounds.size.width-NPNewListDetailHeadView_leftPlace*2, 0);
    title.numberOfLines=0;
    title.textColor=[UIColor blackColor];
    title.font=[UIFont boldSystemFontOfSize:15];
    title.text=model.title;
    CGSize size=[title sizeThatFits:CGSizeMake(title.frame.size.width, MAXFLOAT)];
    title.frame=CGRectMake(title.frame.origin.x, title.frame.origin.y, size.width, size.height);
    [self addSubview:title];
    
    
    UILabel *contentType=[[UILabel alloc] init];
    contentType.frame=CGRectMake(NPNewListDetailHeadView_leftPlace, NPNewListDetailHeadView_title_type_place+title.frame.size.height+title.frame.origin.y,[UIScreen mainScreen].bounds.size.width-NPNewListDetailHeadView_leftPlace*2 , 15);
    contentType.font=[UIFont systemFontOfSize:12];
    contentType.textColor=[UIColor lightGrayColor];
    contentType.backgroundColor=[UIColor clearColor];
    contentType.textAlignment=NSTextAlignmentRight;
    contentType.text=model.subContent;
    [self addSubview:contentType];
    
    UILabel *time=[[UILabel alloc] init];
    time.font=contentType.font;
    time.textColor=contentType.textColor;
    time.backgroundColor=[UIColor clearColor];
    time.frame=CGRectMake(contentType.frame.origin.x, contentType.frame.size.height+contentType.frame.origin.y, contentType.frame.size.width, contentType.frame.size.height);
    time.textAlignment=NSTextAlignmentRight;
    time.text=model.time;
    [self addSubview:time];
    
    TTTAttributedLabel *content=[[TTTAttributedLabel alloc] init];
    content.frame=CGRectMake(title.frame.origin.x, time.frame.origin.y+time.frame.size.height+NPNewListDetailHeadView_time_content_place, [UIScreen mainScreen].bounds.size.width-NPNewListDetailHeadView_leftPlace*2, 0);
    content.textColor=[UIColor lightGrayColor];
    content.backgroundColor=[UIColor clearColor];
    content.font=[UIFont systemFontOfSize:14];
    content.numberOfLines=0;
    content.text=model.content;
    CGSize contentSize=[content sizeThatFits:CGSizeMake(content.frame.size.width, MAXFLOAT)];
    content.frame=CGRectMake(content.frame.origin.x, content.frame.origin.y, contentSize.width, contentSize.height);
    [self addSubview:content];
    
    
    TTTAttributedLabel *readMore=[[TTTAttributedLabel alloc] init];
    readMore.frame=CGRectMake(0, content.frame.size.height+content.frame.origin.y+15, [UIScreen mainScreen].bounds.size.width, 20);
    readMore.font=[UIFont systemFontOfSize:15];
    readMore.textColor=[UIColor blackColor];
    readMore.textAlignment=NSTextAlignmentCenter;
    readMore.text=@"read more";
    [self addSubview:readMore];
    
    self.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, readMore.frame.size.height+15+readMore.frame.origin.y);
    
    
    
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
