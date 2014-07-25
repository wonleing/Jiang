//
//  NPFollowCell.m
//  newsPicks
//
//  Created by yunqi on 14-7-25.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "NPFollowCell.h"
#import "NPUserFollowingButton.h"
#import "NPUserDetaiInfolModel.h"
#define NPFollowCell_hight 10+60
@interface NPFollowCell()
{
    UIImageView *headView;
    UILabel *name;
    UILabel *typeContent;
    UILabel *likeNum;
    NPUserFollowingButton *followBtn;
}
@end
@implementation NPFollowCell
@synthesize delegate=_delegate;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSub];
        // Initialization code
    }
    return self;
}
-(void)initSub
{
    headView=[[UIImageView alloc]init];
    headView.frame=CGRectMake(5, 5, 60, 60);
    [self.contentView addSubview:headView];
    
    name=[[UILabel alloc] init];
    name.frame=CGRectMake(headView.frame.size.width+headView.frame.origin.x+5, headView.frame.origin.y, [UIScreen mainScreen].bounds.size.width-headView.frame.origin.x-headView.frame.origin.y-10, 20);
    name.font=[UIFont boldSystemFontOfSize:17];
    name.textColor=[UIColor blackColor];
    name.backgroundColor=[UIColor clearColor];
    [self.contentView addSubview:name];
    followBtn=[NPUserFollowingButton buttonWithType:UIButtonTypeCustom];
    followBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    followBtn.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-75, 0, 70, 30);
    [followBtn addTarget:self action:@selector(clickFollow:) forControlEvents:UIControlEventTouchUpInside];
    followBtn.center=CGPointMake(followBtn.center.x, headView.center.y);
    [self.contentView addSubview:followBtn];
    
    typeContent=[[UILabel alloc] init];
    typeContent.frame=CGRectMake(name.frame.origin.x, 0, followBtn.frame.origin.x-name.frame.origin.x-5, 15);
    typeContent.font=[UIFont systemFontOfSize:14];
    typeContent.textColor=[UIColor blackColor];
    typeContent.backgroundColor=[UIColor clearColor];
    typeContent.center=CGPointMake(typeContent.center.x, headView.center.y+4);
    [self.contentView addSubview:typeContent];
    
    likeNum=[[UILabel alloc]init];
    likeNum.frame=CGRectMake(typeContent.frame.origin.x, headView.frame.origin.y+headView.frame.size.height-typeContent.frame.size.height, name.frame.size.width, typeContent.frame.size.height);
    likeNum.backgroundColor=[UIColor clearColor];
    likeNum.font=typeContent.font;
    likeNum.textColor=typeContent.textColor;
    [self.contentView addSubview:likeNum];
}
-(void)clickFollow:(id)sender
{
    if (_delegate&&[_delegate respondsToSelector:@selector(NPFollowCellClickFollowing:)]) {
        [_delegate NPFollowCellClickFollowing:self];
    }
}
-(void)changeFollowStatus:(BOOL)follow
{
    followBtn.hidden=NO;
    if (!follow) {
        [followBtn setTitle:@"follow" forState:UIControlStateNormal];
        [followBtn setBackgroundImage:[NPCustomMethod createImageWithColor:NP_MAIN_BACKGROUND_COLOR size:followBtn.frame.size] forState:UIControlStateNormal];
        followBtn.layer.masksToBounds=YES;
        followBtn.layer.cornerRadius=5;
        followBtn.layer.borderColor=[[UIColor whiteColor]CGColor];
        followBtn.layer.borderWidth=1;
        
    }else
    {
        followBtn.layer.borderColor=[[UIColor clearColor]CGColor];
        followBtn.layer.borderWidth=0;
        [followBtn setTitle:@"following" forState:UIControlStateNormal];
        [followBtn setBackgroundImage:[NPCustomMethod createImageWithColor:[UIColor colorWithRed:62.0f/255.0f green:69.0f/255.0f blue:113.0f/255.0f alpha:1] size:followBtn.frame.size] forState:UIControlStateNormal];
        
    }
}
-(void)restSubView:(NPUserDetaiInfolModel *)infoModel
{
    [headView  setImageWithURL:[NSURL URLWithString:infoModel.avatar] placeholderImage:[UIImage imageNamed:NP_IMG_TIME_ONLINE_DEFAULT]];
    name.text=infoModel.name;
    typeContent.text=infoModel.typeName;
    likeNum.text=[NSString stringWithFormat:@"Like: %@ Followers:%@",infoModel.likeNum,infoModel.followers_num];
    [self changeFollowStatus:infoModel.is_following.boolValue];
}
- (void)awakeFromNib
{
    // Initialization code
}
+(float)cellHight
{
    return NPFollowCell_hight;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
