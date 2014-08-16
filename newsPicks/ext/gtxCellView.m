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
        UIView *LineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
        LineView.backgroundColor = [UIColor grayColor];
        
        [self addSubview:LineView];
        
        avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 20, 20)];
        [self addSubview: avatarImageView];
        
        
        
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(avatarImageView.frame.size.width + 3, 5, 40, 40)];
        self.label.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
        self.label.textColor = [UIColor whiteColor];
        [self addSubview:self.label];
        UIView *colorVIew = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 30)];
        colorVIew.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:colorVIew];
        [colorVIew addSubview:self.label];
    }
    return self;
}
-(void)setTitle:(NSString *)title
{
    _label.text = title;
    
}
-(void)setImageUrl:(NSString *)imageUrl
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^ {
        NSURL *portraitUrl = [NSURL URLWithString:imageUrl];
        UIImage *protraitImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:portraitUrl]];
        dispatch_sync(dispatch_get_main_queue(), ^{
            avatarImageView.image = protraitImg;
        });
    });


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
