//
//  NPUserDetaiInfolModel.m
//  newsPicks
//
//  Created by yunqi on 14-7-24.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//
#import "NPUserDetaiInfolModel.h"

@implementation NPUserDetaiInfolModel
@synthesize uid=_uid;
@synthesize name=_name;
@synthesize typeName=_typeName;
@synthesize description=_description;
@synthesize likeNum=_likeNum;
@synthesize followers_num=_followers_num;
@synthesize following_num=_following_num;
@synthesize is_following=_is_following;
@synthesize avatar=_avatar;
@synthesize isPremium=_isPremium;
- (NSDictionary*)attributeMapDictionary
{
    self.likeNum=@"0";
    self.followers_num=@"0";
    self.following_num=@"0";
    return [NSDictionary dictionaryWithObjectsAndKeys:
            @"userid",@"uid"
            ,@"loginname",@"name"
            ,@"type",@"typeName"
            ,@"description",@"description"
            ,@"likeNum",@"likeNum"
            ,@"followers_num",@"followers_num"
            ,@"following_num",@"following_num"
            ,@"is_following",@"is_following"
            ,@"userimage",@"avatar"
            ,@"isPremium",@"isPremium"
            ,nil];
}
-(void)dealloc
{
    RELEASE_SAFELY(_uid);
    RELEASE_SAFELY(_name);
    RELEASE_SAFELY(_typeName);
    RELEASE_SAFELY(_description);
    RELEASE_SAFELY(_likeNum);
    RELEASE_SAFELY(_followers_num);
    RELEASE_SAFELY(_following_num);
    RELEASE_SAFELY(_is_following);
    RELEASE_SAFELY(_avatar);
    RELEASE_SAFELY(_isPremium);
    [super dealloc];
}
@end
