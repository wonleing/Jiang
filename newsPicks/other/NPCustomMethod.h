//
//  NPCustomMethod.h
//  newsPicks
//
//  Created by yunqi on 14-7-23.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kNPNewListTitleKey_Followings @"Following Users"
#define kNPNewListTitleKey_Others @"Other Users"
#define kNPNewListTitleKey_Srending_comment @"Trending Comment"
@class TTTAttributedLabel;
@interface NPCustomMethod : NSObject
+(NSArray *)matchesInString:(NSString *)reges string:(NSString *)content;
+(void)matchesInStringUrl:(TTTAttributedLabel *)label;
+(NSArray*)sortNewsListKey:(NSDictionary*)dic;
@end
