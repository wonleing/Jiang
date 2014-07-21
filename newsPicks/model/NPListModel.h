//
//  NPListModel.h
//  newsPicks
//
//  Created by yunqi on 14-7-21.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "ITTBaseModelObject.h"

@interface NPListModel : ITTBaseModelObject
@property(nonatomic,retain)NSString *listID;
@property(nonatomic,retain)NSString *content;
@property(nonatomic,retain)NSString *contentImage;
@property(nonatomic,retain)NSArray *userImageList;
@property(nonatomic,retain)NSString *replyContent;
@property(nonatomic,retain)NSString *replyID;
@property(nonatomic,retain)NSString *praiseNum;
@end
