//
//  NPUserInfoDetailHeadView.h
//  newsPicks
//
//  Created by yunqi on 14-7-24.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NPUserDetailView.h"
#import "AKOMultiPageTextView.h"
#import "NPUserDetaiInfolModel.h"
#import "NPUserFollowingButton.h"
@class NPUserFollowNumButton;
@protocol NPUserInfoDetailHeadViewDelegate <NSObject>
@optional
-(void)NPUserInfoDetailHeadViewClickFollow;
-(void)NPUserInfoDetailHeadViewCheckFollowing;
-(void)NPUserInfoDetailHeadViewCheckFollowers;
@end

@interface NPUserInfoDetailHeadView : UIView
@property(nonatomic,strong)AKOMultiPageTextView *multiPageView;
@property(nonatomic,strong)NPUserDetailView *detailView;
@property(nonatomic,strong)NPUserFollowNumButton *followingNumBtn;
@property(nonatomic,strong)NPUserFollowNumButton *followersNumBtn;
@property(nonatomic,strong)NPUserFollowingButton *followingBtn;
@property(nonatomic,assign)id<NPUserInfoDetailHeadViewDelegate>delegate;
+(NPUserInfoDetailHeadView *)userInfoDetailHeadView;
-(void)restValue:(NPUserDetaiInfolModel *)infoModel;
-(void)changeFollowStatus:(BOOL)follow;
@end
