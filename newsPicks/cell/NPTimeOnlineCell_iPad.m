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
        UIButton *backBtn =[self valueForKey:[NSString stringWithFormat:@"backBtn%d",i+1]];
        [backBtn setBackgroundImageWithURL:[NSURL URLWithString:model.contentImage] forState:UIControlStateNormal];
    }
}



@end
