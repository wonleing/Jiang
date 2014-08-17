//
//  NPTimeOnlineCell.m
//  newsPicks
//
//  Created by yunqi on 14-7-21.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "NPTimeOnlineCell.h"
#import "NPListModel.h"
#import  "NPlistPopularUsers.h"
#import "NPPopularUserView.h"
@implementation NPTimeOnlineCell
@synthesize delegate=_delegate;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}
-(void)restCell:(NPListModel *)model
{
    self.model=model;
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
        contentLable.frame=CGRectMake(NPTimeOnlineCell_content_LeftPlace, contLableTop, contentView.frame.size.width-contentImageView.frame.size.width-NPTimeOnlineCell_content_LeftPlace*2, NPTimeOnlineCell_content_imagHight);
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
        contentLable.frame=CGRectMake(NPTimeOnlineCell_content_LeftPlace, contLableTop, contentView.frame.size.width-NPTimeOnlineCell_content_LeftPlace*2, NPTimeOnlineCell_content_imagHight);
        contentLable.numberOfLines=3;
        contentLable.textAlignment=NSTextAlignmentLeft;
        contentLable.font=[UIFont boldSystemFontOfSize:13];
        contentLable.backgroundColor=[UIColor clearColor];
        contentLable.textColor=[UIColor blackColor];
        contentLable.text=model.title;
        [contentView addSubview:contentLable];
        
    }
    
    UILabel *userNameLabel = [[UILabel alloc] init];
    userNameLabel.frame = CGRectMake(NPTimeOnlineCell_content_LeftPlace, NPTimeOnlineCell_content_imagHight-2, contentView.frame.size.width-NPTimeOnlineCell_content_LeftPlace*2, 10);
    userNameLabel.font = [UIFont systemFontOfSize:10];
    userNameLabel.backgroundColor = [UIColor clearColor];
    userNameLabel.textColor = [UIColor lightGrayColor];
    userNameLabel.textAlignment = NSTextAlignmentLeft;
    userNameLabel.text = model.loginname;
    [contentView addSubview:userNameLabel];
    
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
    [contentButton setBackgroundImage:[UIImage imageNamed:@"img_pick_navy"] forState:UIControlStateNormal];
    [contentButton addTarget:self action:@selector(OnClickRepley:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:contentButton];
    
    if (model.replyModel.content.length) {
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
        replyLabel.text=model.replyModel.content;
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
-(void)restPopularUsers:(NPlistPopularUsers *)popularUsers
{
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    UIView *contentView=[[UIView alloc] init];
    contentView.frame=CGRectMake(NPTimeOnlineCell_leftPlace, NPTimeOnlineCell_topPlace, [UIScreen mainScreen].bounds.size.width-NPTimeOnlineCell_leftPlace*2, NPTimeOnlineCell_PopularUser_Higth);
    contentView.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:contentView];
    
    float x=NPTimeOnlineCell_leftPlace;
    for (int i=0; i<popularUsers.popularUsers.count; i++) {
        NPlistPopularUser *user= [popularUsers.popularUsers objectAtIndex:i];
        NPPopularUserView *popularView=[[NPPopularUserView alloc]init];
        popularView.frame=CGRectMake(x, NPTimeOnlineCell_leftPlace, NPTimeOnlineCell_PopularUser_Higth-2*NPTimeOnlineCell_leftPlace, NPTimeOnlineCell_PopularUser_Higth-2*NPTimeOnlineCell_leftPlace);
        [popularView setImageWithURL:[NSURL URLWithString:user.headImageUrl] placeholderImage:[UIImage imageNamed:NP_IMG_TIME_ONLINE_DEFAULT]];
        popularView.leveImageView.image=[UIImage imageNamed:NP_IMG_TIME_ONLINE_DEFAULT];
        [contentView addSubview:popularView];
        x=popularView.frame.size.width+popularView.frame.origin.x+NPTimeOnlineCell_leftPlace;
        
    }
    UILabel *time=[[UILabel alloc] init];
    time.frame=CGRectMake(x, NPTimeOnlineCell_leftPlace, contentView.frame.size.width-x, 10);
    time.backgroundColor=[UIColor clearColor];
    time.font=[UIFont systemFontOfSize:10];
    time.text=popularUsers.time;
    [contentView addSubview:time];
    
    UILabel *pop=[[UILabel alloc] init];
    pop.font=[UIFont boldSystemFontOfSize:13];
    pop.frame=CGRectMake(time.frame.origin.x, time.frame.size.height+time.frame.origin.y+10, time.frame.size.width, 40);
    pop.numberOfLines=2;
    pop.backgroundColor=[UIColor clearColor];
    pop.textColor=[UIColor blackColor];
    pop.text=[NSString stringWithFormat:@"Popular\nUsers"];
    [contentView addSubview:pop];
}
-(void)OnClickRepley:(UIButton *)btn
{
    if (_delegate&&[_delegate respondsToSelector:@selector(NPTimeOnlineCellDelegateClickReply:)]) {
        [_delegate NPTimeOnlineCellDelegateClickReply:self];
    }
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
    if (model.replyModel.content.length) {
        heigth+=(NPTimeOnlineCell_content_replyImg_higth+NPTimeOnlineCell_content_replyHigth);
    }else
    {
        heigth+=(NPTimeOnlineCell_content_replyImg_higth-15);
    }
    heigth+=(NPTimeOnlineCell_buttomPlace+NPTimeOnlineCell_topPlace);
    return heigth;
}
@end
