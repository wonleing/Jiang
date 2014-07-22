//
//  NPlistPopularUsers.m
//  newsPicks
//
//  Created by yunqi on 14-7-22.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "NPlistPopularUser.h"

@implementation NPlistPopularUser
@synthesize headImageUrl=_headImageUrl;
@synthesize leve=_leve;
- (NSDictionary*)attributeMapDictionary
{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            @"headImageUrl",@"headImageUrl"
            ,@"leve",@"leve"
            ,nil];
}
-(void)dealloc
{
    RELEASE_SAFELY(_headImageUrl);
    RELEASE_SAFELY(_leve);
    [super dealloc];
}
@end
