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
@synthesize uid=_uid;
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
            ,@"uid",@"uid"
            ,nil];
}
-(void)dealloc
{
    RELEASE_SAFELY(_headImageUrl);
    RELEASE_SAFELY(_name);
    RELEASE_SAFELY(_replyID);
    RELEASE_SAFELY(_position);
    RELEASE_SAFELY(_time);
    RELEASE_SAFELY(_praiseNum);
    RELEASE_SAFELY(_content);
    RELEASE_SAFELY(_uid);
    [super dealloc];
}
@end
