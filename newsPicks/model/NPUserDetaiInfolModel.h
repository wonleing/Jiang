//
//  NPUserDetaiInfolModel.h
//  newsPicks
//
//  Created by yunqi on 14-7-24.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "ITTBaseModelObject.h"

@interface NPUserDetaiInfolModel : ITTBaseModelObject
@property(nonatomic,retain)NSString *uid;
@property(nonatomic,retain)NSString *name;
@property(nonatomic,retain)NSString *typeName;
@property(nonatomic,retain)NSString *description;
@property(nonatomic,retain)NSString *likeNum;
@property(nonatomic,retain)NSString *following_num;
@property(nonatomic,retain)NSString *followers_num;
@property(nonatomic,retain)NSString *is_following;
@property(nonatomic,retain)NSString *avatar;
@property(nonatomic,retain)NSString *isPremium;
@end
