//
//  NPTimeOnlineCell.h
//  newsPicks
//
//  Created by yunqi on 14-7-21.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NPCellDelegate.h"
@class NPListModel;
@class NPlistPopularUsers;
#define NPTimeOnlineCell_topPlace 10
#define NPTimeOnlineCell_leftPlace 10
#define NPTimeOnlineCell_content_imagHight  70
#define NPTimeOnlineCell_content_imagWidth 100
#define NPTimeOnlineCell_content_timeHigth 10
#define NPTimeOnlineCell_content_subtitle_time 0
#define NPTimeOnlineCell_content_LeftPlace 9
#define NPTimeOnlineCell_content_time_replayImg 15
#define NPTimeOnlineCell_content_replyImg_higth 40
#define NPTimeOnlineCell_content_replyHigth 60
#define NPTimeOnlineCell_buttomPlace 10


#define NPTimeOnlineCell_PopularUser_Higth 80
@interface NPTimeOnlineCell : UITableViewCell
@property(nonatomic,weak)id<NPTimeOnlineCellDelegate>delegate;
-(void)restCell:(NPListModel *)model;
-(void)restPopularUsers:(NPlistPopularUsers *)popularUsers;
+(float)cellHigth:(NPListModel *)model;
@end
