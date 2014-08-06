//
//  NPUserDetailView.m
//  newsPicks
//
//  Created by yunqi on 14-7-24.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "NPUserDetailView.h"
#import "NPUserDetaiInfolModel.h"
@interface NPUserDetailView()
{
    UIImageView *imageView;
    UILabel *nameLabel;
    UILabel *typeLabel;
    UILabel *likeLabel;
    
    UIButton *btnPremium;
    
    UIImageView *loackImageView;
}
@end
@implementation NPUserDetailView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)init
{
    if (self=[super init]) {
        imageView=[[UIImageView alloc]init];
        imageView.contentMode=UIViewContentModeScaleAspectFill;
        imageView.frame=CGRectMake(0, 0, 55, 55);
        imageView.image=[UIImage imageNamed:NP_IMG_TIME_ONLINE_DEFAULT];
        [self addSubview:imageView];
        
        nameLabel=[[UILabel alloc]init];
        nameLabel.frame=CGRectMake(imageView.frame.size.width+imageView.frame.origin.x+8, imageView.frame.origin.y, 200, 20);
        nameLabel.backgroundColor=[UIColor clearColor];
        nameLabel.font=[UIFont boldSystemFontOfSize:15.5];
        nameLabel.textColor=[UIColor blackColor];
        [self addSubview:nameLabel];
        typeLabel=[[UILabel alloc]init];
        typeLabel.frame=CGRectMake(nameLabel.frame.origin.x, nameLabel.frame.origin.y+nameLabel.frame.size.height+8, nameLabel.frame.size.width, 15);
        typeLabel.backgroundColor=[UIColor clearColor];
        typeLabel.font=[UIFont systemFontOfSize:11.5];
        typeLabel.textColor=[UIColor grayColor];
        [self addSubview:typeLabel];
        
        likeLabel=[[UILabel alloc]init];
        likeLabel.frame=CGRectMake(imageView.frame.origin.x+2, imageView.frame.origin.y+imageView.frame.size.height+2, 200, 13);
        likeLabel.backgroundColor=[UIColor clearColor];
        likeLabel.font=[UIFont systemFontOfSize:11];
        likeLabel.textColor=[UIColor blackColor];
        [self addSubview:likeLabel];
        
        btnPremium=[UIButton buttonWithType:UIButtonTypeCustom];
        btnPremium.frame=CGRectMake(nameLabel.frame.origin.x, imageView.frame.origin.y+imageView.frame.size.height-30, [UIScreen mainScreen].bounds.size.width-nameLabel.frame.origin.x-20, 30);
        btnPremium.backgroundColor=[UIColor blueColor];
        [self addSubview:btnPremium];
        btnPremium.hidden=YES;
        
        loackImageView=[[UIImageView alloc]init];
        loackImageView.frame=CGRectMake(nameLabel.frame.origin.x, nameLabel.frame.origin.y, 20, 20);
        loackImageView.backgroundColor=[UIColor blueColor];
        [self addSubview:loackImageView];
        loackImageView.hidden=YES;
    }
    return self;
}
-(void)setFrame:(CGRect)frame
{
    nameLabel.frame=CGRectMake(nameLabel.frame.origin.x, nameLabel.frame.origin.y, frame.size.width-nameLabel.frame.origin.x, nameLabel.frame.size.height);
    typeLabel.frame=CGRectMake(typeLabel.frame.origin.x, typeLabel.frame.origin.y, nameLabel.frame.size.width, typeLabel.frame.size.height);
    [super setFrame:frame];
}
-(void)restValue:(NPUserDetaiInfolModel *)infoModel
{
    if (infoModel.avatar==nil || [infoModel.avatar isEqualToString:@""]) {
        //[imageView setImage:[UIImage imageNamed:NP_IMG_TIME_ONLINE_DEFAULT]];
    }else
        [imageView setImageWithURL:[NSURL URLWithString:infoModel.avatar] placeholderImage:[UIImage imageNamed:NP_IMG_TIME_ONLINE_DEFAULT]];
    if (infoModel.isPremium.boolValue) {
        loackImageView.hidden=NO;
        btnPremium.hidden=NO;
        nameLabel.frame=CGRectMake(loackImageView.frame.size.width+loackImageView.frame.origin.x+3, nameLabel.frame.origin.y, nameLabel.frame.size.width, nameLabel.frame.size.height);
        
        likeLabel.hidden=YES;
        typeLabel.hidden=YES;
    }else
    {
        
        loackImageView.hidden=YES;
        btnPremium.hidden=YES;
        likeLabel.hidden=NO;
        typeLabel.hidden=NO;
        nameLabel.frame=CGRectMake(loackImageView.frame.origin.x, nameLabel.frame.origin.y, nameLabel.frame.size.width, nameLabel.frame.size.height);
    nameLabel.text=infoModel.name;
    typeLabel.text=infoModel.typeName;
    likeLabel.text=[NSString stringWithFormat:@"Like: %@",infoModel.likeNum];
    }
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
