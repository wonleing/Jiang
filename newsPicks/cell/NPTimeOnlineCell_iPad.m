//
//  NPTimeOnlineCell_iPad.m
//  newsPicks
//
//  Created by ZhangCheng on 14-8-6.
//  Copyright (c) 2014年 ZhangCheng. All rights reserved.
//

#import "NPTimeOnlineCell_iPad.h"
#import "NPListModel.h"
#import "UIButton+WebCache.h"
@implementation NPTimeOnlineCell_iPad

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    for (int i=0; i<5; i++) {
        UIButton *backBtn = [self valueForKey:[NSString stringWithFormat:@"backBtn%d",i+1]];
        backBtn.backgroundColor = [UIColor clearColor];
        [backBtn addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        UIButton *pickBtn = [self valueForKey:[NSString stringWithFormat:@"pickBtn%d",i+1]];
        [pickBtn addTarget:self action:@selector(pickBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
}

-(void)backBtnAction:(UIButton *)btn{
    for (int i=0; i<5; i++) {
        UIButton *backBtn = [self valueForKey:[NSString stringWithFormat:@"backBtn%d",i+1]];
        if (btn == backBtn) {
            if ([self.delegate respondsToSelector:@selector(NPTimeOnLineCellClickAction:)]) {
                [self.delegate NPTimeOnLineCellClickAction:[self.modelArray objectAtIndex:i]];            }
            break;
        }
    }
}

-(void)pickBtnAction:(UIButton*)btn{
    for (int i=0; i<5; i++) {
        UIButton *backBtn = [self valueForKey:[NSString stringWithFormat:@"pickBtn%d",i+1]];
        if (btn == backBtn) {
            if ([self.delegate respondsToSelector:@selector(NPTimeOnLineCellPickAction:)]) {
                [self.delegate NPTimeOnLineCellPickAction:[self.modelArray objectAtIndex:i]];            }
            break;
        }
    }
}

-(void)restCell:(NSArray *)array{
    self.modelArray=array;
    for (int i=0; i<5; i++) {
        NPListModel *model = [array objectAtIndex:i];
        UILabel *label = [self valueForKey:[NSString stringWithFormat:@"titleLabel%d",i+1]];
        label.text=model.content;
        UILabel *timelabel = [self valueForKey:[NSString stringWithFormat:@"time%d",i]];
        timelabel.text = model.time;
        UILabel *titleLabel = [self valueForKey:[NSString stringWithFormat:@"title%d",i]];
        titleLabel.text = model.title;
        UIView *avatarView = [self valueForKey:[NSString stringWithFormat:@"avatarview%d",i]];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 44, 46)];
        [imageView setImageWithURL:[NSURL URLWithString:model.userimage]];
        [avatarView addSubview:imageView];
        
        
        UIButton *backBtn =[self valueForKey:[NSString stringWithFormat:@"backBtn%d",i+1]];
//        [backBtn setBackgroundImageWithURL:[NSURL URLWithString:model.contentImage] forState:UIControlStateNormal];
        UIImageView *iView = (UIImageView*)[self viewWithTag:1212+i];
        if (!iView) {
            UIImageView *imageview = [[UIImageView alloc] initWithFrame:backBtn.frame];
            imageview.layer.masksToBounds =YES;
            imageview.clipsToBounds = YES;
            imageview.tag=1212+i;
            imageview.contentMode = UIViewContentModeScaleAspectFill;
            
            [self.mContentView addSubview:imageview];
            imageview.userInteractionEnabled = NO;
            [self.mContentView sendSubviewToBack:imageview];
            
            iView=imageview;
        }
        [iView setImageWithURL:[NSURL URLWithString:model.contentImage]];
        
    }
}



@end
