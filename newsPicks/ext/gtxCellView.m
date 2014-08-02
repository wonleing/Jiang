//
//  gtxCellView.m
//  Animation
//
//  Created by dengqixiang on 14-7-24.
//  Copyright (c) 2014年 gtx. All rights reserved.
//

#import "gtxCellView.h"

@implementation gtxCellView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.layer.cornerRadius = 0.0;
        self.contentView.layer.borderWidth = 1.0f;
        self.contentView.layer.borderColor = [UIColor redColor].CGColor;
        self.contentView.backgroundColor = [UIColor underPageBackgroundColor];
        
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        self.label.text = @"adad";
        self.label.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
        self.label.textColor = [UIColor redColor];
        
        UIView *colorVIew = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 30)];
        colorVIew.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:colorVIew];
        [colorVIew addSubview:self.label];
    }
    return self;
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
