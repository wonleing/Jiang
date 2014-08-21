//
//  NPFollowCell.h
//  newsPicks
//
//  Created by yunqi on 14-7-25.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NPFollowCell;
@protocol NPFollowCellDelegate<NSObject>
@optional
-(void)NPFollowCellClickFollowing:( NPFollowCell*)cell;
@end
@class NPUserDetaiInfolModel;
@interface NPFollowCell : UITableViewCell
@property(nonatomic,assign)id<NPFollowCellDelegate>delegate;
-(void)restSubView:(NPUserDetaiInfolModel *)infoModel;
+(float)cellHight;
- (id)initWithStyle2:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
