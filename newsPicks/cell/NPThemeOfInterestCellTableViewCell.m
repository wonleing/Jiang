//
//  NPThemeOfInterestCellTableViewCell.m
//  newsPicks
//
//  Created by kangxv on 14-8-16.
//  Copyright (c) 2014年 kangxv. All rights reserved.
//

#import "NPThemeOfInterestCellTableViewCell.h"

@implementation NPThemeOfInterestCellTableViewCell
{
    UIImageView *select_tag;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self creatContentView];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)creatContentView
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 5.0f, 10.0f, self.frame.size.height-10.0f)];
    label.backgroundColor = [UIColor colorWithRed:arc4random()%100*0.01 green:0 blue:0 alpha:1];
    self.conte_text = [[UILabel alloc] initWithFrame:CGRectMake(30.09f, 5.0f, 100.0f, self.frame.size.height - 10.0f)];
    self.conte_text.textColor = [UIColor blackColor];
    [self.contentView addSubview:label];
    [self.contentView addSubview:self.conte_text];
    
    select_tag = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-30.0f, 5.0f, 20.0f, 20.0f)];
    [self.contentView addSubview:select_tag];
}

- (void)selected_cell:(BOOL )isSelect
{
    if(isSelect)
    {
        select_tag.image = [UIImage imageNamed:@"success-black.png"];
        self.conte_text.textColor = [UIColor blackColor];
    }else
    {
        select_tag.image = [UIImage imageNamed:@"registerPhoto_1"];
        self.conte_text.textColor = [UIColor darkGrayColor];
    }
}

@end
