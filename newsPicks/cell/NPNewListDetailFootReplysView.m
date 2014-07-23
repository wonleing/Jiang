//
//  NPNewListDetailFootReplysView.m
//  newsPicks
//
//  Created by yunqi on 14-7-23.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "NPNewListDetailFootReplysView.h"
#import "NPlistReplyModel.h"
#define NPNewListDetailFootReplysView_topPlace 7
#define NPNewListDetailFootReplysView_leftPlace 7
#define NPNewListDetailFootReplysView_imageWidth 33

@implementation NPNewListDetailFootReplysView
@synthesize delegate=_delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)restSubView:(NSArray *)list count:(NSString *)count;
{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    if (!replyList) {
        replyList=[[NSMutableArray alloc]initWithCapacity:0];
    }
    [replyList removeAllObjects];
    [replyList addObjectsFromArray:list];
    [self setSubView:count];
}
-(void)setSubView:(NSString *)count
{
    float x=NPNewListDetailFootReplysView_leftPlace;
    float y=NPNewListDetailFootReplysView_topPlace;
    for (int i=0; i<10; i++) {
        if (replyList.count>i) {
            NPlistReplyModel *model=[replyList objectAtIndex:i];
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake(x, y, NPNewListDetailFootReplysView_imageWidth, NPNewListDetailFootReplysView_imageWidth);
            [btn setImageWithURL:[NSURL URLWithString:model.headImageUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:NP_IMG_TIME_ONLINE_DEFAULT]];
            [btn addTarget:self action:@selector(clickHead:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            btn.tag=100+i;
            x=btn.frame.size.width+btn.frame.origin.x+NPNewListDetailFootReplysView_leftPlace;
            
            if (replyList.count==i+1) {
                UILabel *label=[[UILabel alloc] init];
                label.font=[UIFont systemFontOfSize:12];
                label.textColor=[UIColor blackColor];
                label.frame=CGRectMake(x, y, NPNewListDetailFootReplysView_imageWidth, NPNewListDetailFootReplysView_imageWidth);
                label.text=[NSString stringWithFormat:@"+%@",count];
                [self addSubview:label];
                
                self.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, y+NPNewListDetailFootReplysView_topPlace+NPNewListDetailFootReplysView_imageWidth);
            }
            
            if (i==6) {
                x=NPNewListDetailFootReplysView_leftPlace;
                y=NPNewListDetailFootReplysView_topPlace*2+NPNewListDetailFootReplysView_imageWidth;
            }
            
        }
    }
}
-(void)clickHead:(UIButton *)btn
{
    if (_delegate&&[_delegate respondsToSelector:@selector(NPNewListDetailFootReplysViewClickUser:)]) {
        [_delegate NPNewListDetailFootReplysViewClickUser:[replyList objectAtIndex:btn.tag-100]];
    }
}
-(void)setFrame:(CGRect)frame
{
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
