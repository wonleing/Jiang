//
//  NPlistReplyModel.h
//  newsPicks
//
//  Created by yunqi on 14-7-22.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "ITTBaseModelObject.h"

@interface NPlistReplyModel : ITTBaseModelObject
@property(nonatomic,retain)NSString *uid;
@property(nonatomic,retain)NSString *headImageUrl;
@property(nonatomic,retain)NSString *name;
@property(nonatomic,retain)NSString *replyID;
@property(nonatomic,retain)NSString *position;
@property(nonatomic,retain)NSString *time;
@property(nonatomic,retain)NSString *praiseNum;
@property(nonatomic,retain)NSString *content;
@end
