//
//  NPTimeOnlineCell.m
//  newsPicks
//
//  Created by yunqi on 14-7-21.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "NPTimeOnlineCell.h"
#import "NPListModel.h"
@implementation NPTimeOnlineCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}
-(void)restCell:(NPListModel *)model
{
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    UIView *contentView=[[UIView  alloc]init];
    contentView.frame=CGRectMake(NPTimeOnlineCell_leftPlace, NPTimeOnlineCell_topPlace, [UIScreen mainScreen].bounds.size.width-NPTimeOnlineCell_leftPlace*2, 0);
    contentView.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:contentView];
    
    float contLableTop=5;
    if (model.contentImage.length) {
        UIImageView *contentImageView=[[UIImageView alloc]init];
        contentImageView.frame=CGRectMake(contentView.frame.size.width-NPTimeOnlineCell_content_imagWidth, 0,NPTimeOnlineCell_content_imagWidth, NPTimeOnlineCell_content_imagHight);
        contentImageView.backgroundColor=[UIColor clearColor];
        contentImageView.clipsToBounds=YES;
        contentImageView.contentMode=UIViewContentModeScaleAspectFill;
        [contentView addSubview:contentImageView];
        
        [contentImageView setImageWithURL:[NSURL URLWithString:model.contentImage] placeholderImage:[UIImage imageNamed:NP_IMG_TIME_ONLINE_DEFAULT]];
        
        
        UILabel *contentLable=[[UILabel alloc]init];
        contentLable.frame=CGRectMake(NPTimeOnlineCell_content_LeftPlace, contLableTop, contentView.frame.size.width-contentImageView.frame.size.width-NPTimeOnlineCell_content_LeftPlace*2, NPTimeOnlineCell_content_imagHight-2*contLableTop);
        contentLable.numberOfLines=3;
        contentLable.textAlignment=NSTextAlignmentLeft;
        contentLable.font=[UIFont boldSystemFontOfSize:13];
        contentLable.backgroundColor=[UIColor clearColor];
        contentLable.textColor=[UIColor blackColor];
        contentLable.text=model.content;
        [contentView addSubview:contentLable];
        
    }else
    {
        UILabel *contentLable=[[UILabel alloc]init];
        contentLable.frame=CGRectMake(NPTimeOnlineCell_content_LeftPlace, contLableTop, contentView.frame.size.width-NPTimeOnlineCell_content_LeftPlace*2, NPTimeOnlineCell_content_imagHight-2*contLableTop);
        contentLable.numberOfLines=3;
        contentLable.textAlignment=NSTextAlignmentLeft;
        contentLable.font=[UIFont boldSystemFontOfSize:13];
        contentLable.backgroundColor=[UIColor clearColor];
        contentLable.textColor=[UIColor blackColor];
        contentLable.text=model.content;
        [contentView addSubview:contentLable];
    }
    UILabel *contLableSubTitle=[[UILabel alloc]init];
    contLableSubTitle.font=[UIFont systemFontOfSize:10];
    contLableSubTitle.frame=CGRectMake(NPTimeOnlineCell_content_LeftPlace, NPTimeOnlineCell_content_imagHight, contentView.frame.size.width-NPTimeOnlineCell_content_imagWidth-NPTimeOnlineCell_content_LeftPlace*2, NPTimeOnlineCell_content_timeHigth);
    contLableSubTitle.backgroundColor=[UIColor clearColor];
    contLableSubTitle.textColor=[UIColor lightGrayColor];
    contLableSubTitle.textAlignment=NSTextAlignmentLeft;
    contLableSubTitle.text=model.subContent;
    [contentView addSubview:contLableSubTitle];
    
    UILabel *contentTime=[[UILabel alloc] init];
    contentTime.frame=CGRectMake(contLableSubTitle.frame.origin.x, contLableSubTitle.frame.size.height+contLableSubTitle.frame.origin.y+NPTimeOnlineCell_content_subtitle_time, contLableSubTitle.frame.size.width, contLableSubTitle.frame.size.height);
    contentTime.backgroundColor=[UIColor clearColor];
    contentTime.textColor=contLableSubTitle.textColor;
    contentTime.font=contLableSubTitle.font;
    contentTime.text=model.time;
    [contentView addSubview:contentTime];
    
    UIButton *contentButton=[UIButton buttonWithType:UIButtonTypeCustom];
    contentButton.frame=CGRectMake(contentView.frame.size.width-NPTimeOnlineCell_leftPlace-8-NPTimeOnlineCell_content_replyImg_higth, contentTime.frame.origin.y, NPTimeOnlineCell_content_replyImg_higth, NPTimeOnlineCell_content_replyImg_higth);
    contentButton.backgroundColor=[UIColor blueColor];
    [contentButton addTarget:self action:@selector(OnClickRepley:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:contentButton];
    
    if (model.replyContent.length) {
        float x=NPTimeOnlineCell_content_LeftPlace;
        for (int i=0; i<6; i++) {
            if (!(model.userImageList.count>i)) {
                break;
            }
            UIImageView *contentFollowView=[[UIImageView alloc]init];
            if (i==0) {
                contentFollowView.frame=CGRectMake(x, contentTime.frame.size.height+contentTime.frame.origin.y+NPTimeOnlineCell_content_time_replayImg, NPTimeOnlineCell_content_replyImg_higth, NPTimeOnlineCell_content_replyImg_higth);
            }else
            {
                 contentFollowView.frame=CGRectMake(x, contentTime.frame.size.height+contentTime.frame.origin.y+NPTimeOnlineCell_content_time_replayImg+15, NPTimeOnlineCell_content_replyImg_higth-15, NPTimeOnlineCell_content_replyImg_higth-15);
            }
            contentFollowView.contentMode=UIViewContentModeScaleAspectFill;
            contentFollowView.backgroundColor=[UIColor clearColor];
            contentFollowView.clipsToBounds=YES;
            [contentFollowView setImageWithURL:[NSURL URLWithString:[model.userImageList objectAtIndex:i]] placeholderImage:[UIImage imageNamed:NP_IMG_TIME_ONLINE_DEFAULT]];
            if (contentFollowView.frame.origin.x+contentFollowView.frame.size.width>contentView.frame.size.width-NPTimeOnlineCell_content_LeftPlace) {
                break;
            }
            [contentView addSubview:contentFollowView];
            x=contentFollowView.frame.size.width+contentFollowView.frame.origin.x;
        }
        if (model.userImageList.count>6) {
            UILabel *replyCount=[[UILabel alloc] init];
            replyCount.frame=CGRectMake(NPTimeOnlineCell_content_LeftPlace+NPTimeOnlineCell_content_replyImg_higth+(NPTimeOnlineCell_content_replyImg_higth-15)*5, contentTime.frame.size.height+contentTime.frame.origin.y+NPTimeOnlineCell_content_time_replayImg+15, 100, NPTimeOnlineCell_content_replyImg_higth-15);
            replyCount.font=[UIFont systemFontOfSize:10];
            replyCount.text=[NSString stringWithFormat:@"+%@",model.replyCount];
            replyCount.backgroundColor=[UIColor clearColor];
            [contentView addSubview:replyCount];
            
        }
        UIView *replyContent=[[UIView alloc]init];
        replyContent.frame=CGRectMake(NPTimeOnlineCell_content_LeftPlace,contentTime.frame.origin.y+contentTime.frame.size.height+ NPTimeOnlineCell_content_time_replayImg+NPTimeOnlineCell_content_replyImg_higth, contentView.frame.size.width-NPTimeOnlineCell_content_LeftPlace*2, NPTimeOnlineCell_content_replyHigth);
        replyContent.backgroundColor=[UIColor lightGrayColor];
        [contentView addSubview:replyContent];
        UILabel *replyLabel=[[UILabel alloc]init];
        replyLabel.frame=CGRectMake(5, 0, replyContent.frame.size.width-10-50, replyContent.frame.size.height);
        replyLabel.backgroundColor=[UIColor clearColor];
        replyLabel.font=[UIFont systemFontOfSize:11.5];
        replyLabel.numberOfLines=3;
        replyLabel.textColor=[UIColor blackColor];
        replyLabel.text=model.replyContent;
        [replyContent addSubview:replyLabel];
         contentView.frame=CGRectMake(contentView.frame.origin.x, contentView.frame.origin.y, contentView.frame.size.width, replyContent.frame.size.height+replyContent.frame.origin.y+NPTimeOnlineCell_buttomPlace);
        
    }else
    {
        UIImageView *contentFollowView=[[UIImageView alloc]init];
        contentFollowView.frame=CGRectMake(NPTimeOnlineCell_content_LeftPlace, contentTime.frame.size.height+contentTime.frame.origin.y+NPTimeOnlineCell_content_time_replayImg, NPTimeOnlineCell_content_replyImg_higth-15, NPTimeOnlineCell_content_replyImg_higth-15);
        contentFollowView.contentMode=UIViewContentModeScaleAspectFill;
        [contentFollowView setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:NP_IMG_TIME_ONLINE_DEFAULT]];
        [contentView addSubview:contentFollowView];
        contentView.frame=CGRectMake(contentView.frame.origin.x, contentView.frame.origin.y, contentView.frame.size.width, contentFollowView.frame.size.height+contentFollowView.frame.origin.y+NPTimeOnlineCell_buttomPlace);
    }
    
}
-(void)OnClickRepley:(UIButton *)btn
{
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
+(float)cellHigth:(NPListModel *)model
{
    float heigth=NPTimeOnlineCell_topPlace;
    heigth+=(NPTimeOnlineCell_content_timeHigth*2+NPTimeOnlineCell_content_subtitle_time+NPTimeOnlineCell_content_imagHight);
    heigth+=NPTimeOnlineCell_content_time_replayImg;
    if (model.replyContent.length) {
        heigth+=(NPTimeOnlineCell_content_replyImg_higth+NPTimeOnlineCell_content_replyHigth);
    }else
    {
        heigth+=(NPTimeOnlineCell_content_replyImg_higth-15);
    }
    heigth+=(NPTimeOnlineCell_buttomPlace+NPTimeOnlineCell_topPlace);
    return heigth;
}
@end
