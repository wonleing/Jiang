//
//  NPCellDelegate.h
//  newsPicks
//
//  Created by yunqi on 14-7-22.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NPTimeOnlineCell;
@protocol NPTimeOnlineCellDelegate<NSObject>
@optional
-(void)NPTimeOnlineCellDelegateClickReply:(NPTimeOnlineCell *)cell;
@end
