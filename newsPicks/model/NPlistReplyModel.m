//
//  NPlistReplyModel.m
//  newsPicks
//
//  Created by yunqi on 14-7-22.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "NPlistReplyModel.h"

@implementation NPlistReplyModel
@synthesize headImageUrl=_headImageUrl;
@synthesize name=_name;
@synthesize replyID=_replyID;
@synthesize position=_position;
@synthesize time=_time;
@synthesize praiseNum=_praiseNum;
@synthesize content=_content;
- (NSDictionary*)attributeMapDictionary
{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            @"headImageUrl",@"headImageUrl"
            ,@"name",@"name"
            ,@"replyID",@"replyID"
            ,@"position",@"position"
            ,@"time",@"time"
            ,@"replyID",@"replyID"
            ,@"praiseNum",@"praiseNum"
            ,@"content",@"content"
            ,nil];
}
@end
