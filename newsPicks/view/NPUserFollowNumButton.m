//
//  NPUserFollowNumButton.m
//  newsPicks
//
//  Created by yunqi on 14-7-24.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "NPUserFollowNumButton.h"

@implementation NPUserFollowNumButton
@synthesize descriptionLabel=_descriptionLabel;;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _descriptionLabel=[[UILabel alloc]init];
        _descriptionLabel.backgroundColor=[UIColor clearColor];
        _descriptionLabel.textColor=[UIColor whiteColor];
        _descriptionLabel.textAlignment=NSTextAlignmentCenter;
        _descriptionLabel.font=[UIFont systemFontOfSize:9];
        [self addSubview:_descriptionLabel];
    }
    return self;
}
-(void)setFrame:(CGRect)frame
{
    _descriptionLabel.frame=CGRectMake(0, frame.size.height-14, frame.size.width, 10);
    self.titleEdgeInsets=UIEdgeInsetsMake(0, 0, 14, 0);
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
