//
//  NPCheckFollowingAndFollowersController.h
//  newsPicks
//
//  Created by yunqi on 14-7-25.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "NPBaseViewController.h"
typedef enum
{
    NPCheckFollow_following,
    NPCheckFollow_followers
}NPCheckFollow_type;
@interface NPCheckFollowingAndFollowersController : NPBaseViewController
@property(nonatomic,retain)NSString *uid;
@property(nonatomic,assign)NPCheckFollow_type type;
@end
