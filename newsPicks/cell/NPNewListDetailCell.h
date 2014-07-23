//
//  NPNewListDetailCell.h
//  newsPicks
//
//  Created by yunqi on 14-7-23.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#define NPNewListDetailCell_topPlace 5
#define NPNewListDetailCell_noContent_headImageHight 30
#define NPNewListDetailCell_Content_headImageHight  40
#define NPNewListDetailCell_RightPlace  50
#define NPNewListDetailCell_headImage_Content_place 10
#define NPNewListDetailCell_content_fontSize 13
#define NPNewListDetailCell_buttomPlace 10
#define NPNewListDetailCell_lineSpace 4
@class NPNewListDetailCell;
@protocol NPNewListDetailCellDelegate<NSObject>
@optional
-(void)NPNewListDetailCellClickContentHeadImage:(NPNewListDetailCell *)cell;
-(void)NPNewListDetailCellClickContentUrl:(NSURL*)url;
-(void)NPNewListDetailCellClickContentText:(NPNewListDetailCell *)cell;
@end
@class NPlistReplyModel;
@interface NPNewListDetailCell : UITableViewCell
@property(nonatomic,assign)id<NPNewListDetailCellDelegate>delegate;
-(void)restCell:(NPlistReplyModel *)reply;
+(float)cellHigth:(NPlistReplyModel *)reply;

@end
