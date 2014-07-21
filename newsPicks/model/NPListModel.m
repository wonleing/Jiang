//
//  NPListModel.m
//  newsPicks
//
//  Created by yunqi on 14-7-21.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "NPListModel.h"

@implementation NPListModel
@synthesize listID=_listID;
@synthesize content=_content;
@synthesize contentImage=_contentImage;
@synthesize userImageList=_userImageList;
@synthesize replyContent=_replyContent;
@synthesize replyID=_replyID;
@synthesize praiseNum=_praiseNum;
@synthesize subContent=_subContent;
@synthesize time=_time;
@synthesize type=_type;
@synthesize replyCount=_replyCount;
- (NSDictionary*)attributeMapDictionary
{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            @"listID",@"listID"
            ,@"content",@"content"
            ,@"contentImage",@"contentImage"
            ,@"userImageList",@"userImageList"
            ,@"replyContent",@"replyContent"
            ,@"replyID",@"replyID"
            ,@"praiseNum",@"praiseNum"
            ,@"subContent",@"subContent"
            ,@"time",@"time"
            ,@"type",@"type"
            ,@"replyCount",@"replyCount"
            ,nil];
}
-(void)dealloc
{
    RELEASE_SAFELY(_listID);
    RELEASE_SAFELY(_content);
    RELEASE_SAFELY(_contentImage);
    RELEASE_SAFELY(_userImageList);
    RELEASE_SAFELY(_replyContent);
    RELEASE_SAFELY(_replyID);
    RELEASE_SAFELY(_praiseNum);
    RELEASE_SAFELY(_subContent);
    RELEASE_SAFELY(_time);
    RELEASE_SAFELY(_replyCount);
    [super dealloc];
}
@end
