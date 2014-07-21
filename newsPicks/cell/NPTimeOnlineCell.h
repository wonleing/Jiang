//
//  NPTimeOnlineCell.h
//  newsPicks
//
//  Created by yunqi on 14-7-21.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import <UIKit/UIKit.h>
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
@class NPListModel;
@interface NPTimeOnlineCell : UITableViewCell
-(void)restCell:(NPListModel *)model;
+(float)cellHigth:(NPListModel *)model;
@end
