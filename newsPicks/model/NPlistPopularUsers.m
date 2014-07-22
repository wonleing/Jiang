//
//  NPlistPopularUsers.m
//  newsPicks
//
//  Created by yunqi on 14-7-22.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "NPlistPopularUsers.h"

@implementation NPlistPopularUsers
@synthesize time=_time;
@synthesize popularUsers=_popularUsers;
- (NSDictionary*)attributeMapDictionary
{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            @"time",@"time"
            ,@"popularUsers",@"popularUsers"
            ,nil];
}
-(void)dealloc
{
    RELEASE_SAFELY(_time);
    RELEASE_SAFELY(_popularUsers);
    [super dealloc];
}
@end
