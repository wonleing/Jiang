//
//  NPNewListDetailCell.m
//  newsPicks
//
//  Created by yunqi on 14-7-23.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "NPNewListDetailCell.h"
#import  "NPlistReplyModel.h"
#import "TTTAttributedLabel.h"
@interface NPNewListDetailCell()<TTTAttributedLabelDelegate>
@end
@implementation NPNewListDetailCell
@synthesize delegate=_delegate;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)restCell:(NPlistReplyModel *)reply
{
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
//    if (reply.content.length) {
        UIImageView *headImageView=[[UIImageView alloc]init];
        headImageView.frame=CGRectMake(NPNewListDetailCell_topPlace, NPNewListDetailCell_topPlace, NPNewListDetailCell_Content_headImageHight, NPNewListDetailCell_Content_headImageHight);
        headImageView.contentMode=UIViewContentModeScaleAspectFill;
        [headImageView setImageWithURL:[NSURL URLWithString:reply.headImageUrl] placeholderImage:[UIImage imageNamed:NP_IMG_TIME_ONLINE_DEFAULT]];
        [self.contentView addSubview:headImageView];
        
        UILabel *nameLabel=[[UILabel alloc] init];
        nameLabel.frame=CGRectMake(NPNewListDetailCell_topPlace+headImageView.frame.size.width+headImageView.frame.origin.x+10, headImageView.frame.origin.y, [UIScreen mainScreen].bounds.size.width-NPNewListDetailCell_RightPlace-headImageView.frame.size.width-headImageView.frame.origin.x-NPNewListDetailCell_topPlace, headImageView.frame.size.height/3);
        nameLabel.backgroundColor=[UIColor clearColor];
        nameLabel.textColor=[UIColor lightGrayColor];
        nameLabel.font=[UIFont systemFontOfSize:10];
        nameLabel.text = @"Leon";
//        nameLabel.text=reply.name;
        [self.contentView addSubview:nameLabel];
        
        UILabel *postionLabel=[[UILabel alloc]init];
        postionLabel.font=nameLabel.font;
        postionLabel.textColor=nameLabel.textColor;
        postionLabel.backgroundColor=[UIColor clearColor];
        postionLabel.frame=CGRectMake(nameLabel.frame.origin.x, nameLabel.frame.size.height+nameLabel.frame.origin.y, nameLabel.frame.size.width, nameLabel.frame.size.height);
//        postionLabel.text=reply.position;
        postionLabel.text = @"nice newsPicked!";
        [self.contentView addSubview:postionLabel];
        
        UILabel *timeLabel=[[UILabel alloc]init];
        timeLabel.frame=CGRectMake(nameLabel.frame.origin.x, postionLabel.frame.size.height+postionLabel.frame.origin.y, postionLabel.frame.size.width, postionLabel.frame.size.height);
        timeLabel.font=postionLabel.font;
        timeLabel.textColor=postionLabel.textColor;
        timeLabel.backgroundColor=[UIColor clearColor];
        timeLabel.text = @"2014-08-31 22:33";
//        timeLabel.text=reply.time;
        [self.contentView addSubview:timeLabel];
        
        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(0, 0, timeLabel.frame.size.width+timeLabel.frame.origin.y, NPNewListDetailCell_topPlace+NPNewListDetailCell_Content_headImageHight);
        btn.backgroundColor=[UIColor clearColor];
        [btn addTarget:self action:@selector(clickHead:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        
        
        TTTAttributedLabel *contentLabel=[[TTTAttributedLabel alloc]init];
        contentLabel.frame=CGRectMake(NPNewListDetailCell_topPlace, headImageView.frame.size.height+headImageView.frame.origin.y+NPNewListDetailCell_headImage_Content_place, [UIScreen mainScreen].bounds.size.width-NPNewListDetailCell_topPlace-NPNewListDetailCell_RightPlace, 0);
        contentLabel.lineBreakMode=NSLineBreakByCharWrapping;
        contentLabel.textColor=[UIColor blackColor];
        contentLabel.font=[UIFont systemFontOfSize:NPNewListDetailCell_content_fontSize];
        contentLabel.backgroundColor=[UIColor clearColor];
        contentLabel.numberOfLines=0;
        contentLabel.delegate=self;
        NSMutableDictionary *mutableLinkAttributes=[NSMutableDictionary dictionary];
        [mutableLinkAttributes setObject:[UIColor blueColor] forKey:(NSString *)kCTForegroundColorAttributeName];
        contentLabel.linkAttributes=mutableLinkAttributes;
//        contentLabel.attributedText=[NSMutableAttributedString attributedStringWith:contentLabel.font lineSpace:NPNewListDetailCell_lineSpace textColor:contentLabel.textColor content:reply.content];
       contentLabel.attributedText=[NSMutableAttributedString attributedStringWith:contentLabel.font lineSpace:NPNewListDetailCell_lineSpace textColor:contentLabel.textColor content:@"it is a good newspicked"];
        CGSize size=[NSMutableAttributedString  adjustSizeWithAttributedString:contentLabel.attributedText MaxWidth:contentLabel.frame.size.width];
        contentLabel.frame=CGRectMake(contentLabel.frame.origin.x, contentLabel.frame.origin.y, size.width, size.height);
        [NPCustomMethod matchesInStringUrl:contentLabel];
        [self.contentView addSubview:contentLabel];
    
        
        UIButton *btnPraise=[UIButton buttonWithType:UIButtonTypeCustom];
        btnPraise.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-NPNewListDetailCell_RightPlace, postionLabel.frame.origin.y-5, 36, 35);
//        btnPraise.backgroundColor=[UIColor orangeColor];
    [btnPraise setBackgroundImage:[UIImage imageNamed:@"img_pick_navy"] forState:UIControlStateNormal];
        [self.contentView addSubview:btnPraise];
        UIView *line=[[UIView alloc]init];
        line.frame=CGRectMake(0, contentLabel.frame.size.height+contentLabel.frame.origin.y+NPNewListDetailCell_buttomPlace-0.5, [UIScreen mainScreen].bounds.size.width, 0.5);
        line.backgroundColor=[UIColor lightGrayColor];
        [self.contentView addSubview:line];

//    }else
//    {
//        UIButton *headImage=[UIButton buttonWithType:UIButtonTypeCustom];
//        [headImage addTarget:self action:@selector(clickHead:) forControlEvents:UIControlEventTouchUpInside];
//        headImage.frame=CGRectMake(NPNewListDetailCell_topPlace, NPNewListDetailCell_topPlace, NPNewListDetailCell_noContent_headImageHight, NPNewListDetailCell_noContent_headImageHight);
//        headImage.contentMode=UIViewContentModeScaleAspectFill;
//        [headImage  setImageWithURL:[NSURL URLWithString:reply.headImageUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:NP_IMG_TIME_ONLINE_DEFAULT]];
//        [self.contentView addSubview:headImage];
//        UIView *line=[[UIView alloc]init];
//        line.frame=CGRectMake(0, headImage.frame.size.height+headImage.frame.origin.y+NPNewListDetailCell_topPlace-0.5, [UIScreen mainScreen].bounds.size.width, 0.5);
//        line.backgroundColor=[UIColor lightGrayColor];
//        [self.contentView addSubview:line];
//        
//
//    }
}

-(void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url
{
    if (_delegate&&[_delegate respondsToSelector:@selector(NPNewListDetailCellClickContentUrl:)]) {
        [_delegate NPNewListDetailCellClickContentUrl:url];
    }
}
-(void)attributedLabelSelectBlankSpace:(TTTAttributedLabel *)label
{
    if (_delegate&&[_delegate respondsToSelector:@selector(NPNewListDetailCellClickContentText:)]) {
        [_delegate NPNewListDetailCellClickContentText:self];
    }
}
-(void)clickHead:(UIButton *)btn
{
    if (_delegate&&[_delegate respondsToSelector:@selector(NPNewListDetailCellClickContentHeadImage:)]) {
        [_delegate NPNewListDetailCellClickContentHeadImage:self];
    }
}
+(float)cellHigth:(NPlistReplyModel *)reply
{
    float height=0;
    if (reply.content.length) {
        height=NPNewListDetailCell_topPlace+NPNewListDetailCell_Content_headImageHight+NPNewListDetailCell_headImage_Content_place;
        NSMutableAttributedString *attributed=[NSMutableAttributedString attributedStringWith:[UIFont systemFontOfSize:NPNewListDetailCell_content_fontSize] lineSpace:NPNewListDetailCell_lineSpace textColor:[UIColor blackColor] content:reply.content];
        CGSize size=[NSMutableAttributedString  adjustSizeWithAttributedString:attributed MaxWidth:[UIScreen mainScreen].bounds.size.width-NPNewListDetailCell_topPlace-NPNewListDetailCell_RightPlace];
        height+=size.height;
        height+=NPNewListDetailCell_buttomPlace;
    }else
    {
        height=NPNewListDetailCell_topPlace*2+NPNewListDetailCell_noContent_headImageHight;
    }
    return height;;
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

@end
