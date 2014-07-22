//
//  NPlistPopularUsers.h
//  newsPicks
//
//  Created by yunqi on 14-7-22.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "ITTBaseModelObject.h"
#import "NPlistPopularUser.h"
@interface NPlistPopularUsers : ITTBaseModelObject
@property(nonatomic,retain)NSString *time;
@property(nonatomic,retain)NSArray *popularUsers;//content is NPListPopularUser
@end
