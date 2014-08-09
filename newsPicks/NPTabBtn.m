//
//  NPTabBtn.m
//  newsPicks
//
//  Created by ZhangCheng on 14-8-8.
//  Copyright (c) 2014年 ZhangCheng. All rights reserved.
//

#import "NPTabBtn.h"

@implementation NPTabBtn

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    self.backgroundColor=selected?[UIColor lightGrayColor]:[UIColor clearColor];
    self.mTitleLabel.textColor=selected?[UIColor purpleColor]:[UIColor whiteColor];
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
