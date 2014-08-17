//
//  NPListModel.h
//  newsPicks
//
//  Created by yunqi on 14-7-21.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "ITTBaseModelObject.h"
#import "NPlistReplyModel.h"
typedef  enum
{
    NPListType_online=0,
    NPListType_top,
    NPListType_premium
}NPListType;
@interface NPListModel : ITTBaseModelObject
@property(nonatomic,retain)NSString *listID;
@property(nonatomic,retain)NSString *content;
@property(nonatomic,retain)NSString *title;
@property(nonatomic,retain)NSString *contentImage;
@property(nonatomic,retain)NSArray *userImageList;
@property(nonatomic,retain)NSString *replyCount;
@property(nonatomic,retain)NPlistReplyModel *replyModel;
@property(nonatomic,retain)NSString *time;
@property(nonatomic,retain)NSString *subContent;
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,retain)NSString *link;
@property(nonatomic,retain)NSString *userimage;
@property(nonatomic,retain)NSString *loginname;
@end
