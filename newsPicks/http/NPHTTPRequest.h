//
//  NPHTTPRequest.h
//  newsPicks
//
//  Created by yunqi on 14-7-21.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NPlistPopularUsers;
@class NPUserDetaiInfolModel;
@interface NPHTTPRequest : NSObject
+ (void)getTimeOnLineData:(NSString *)cid usingSuccessBlock:(void (^)(BOOL isSuccess,NSArray *result))successBlock;
+ (void)getTopData:(NSString *)cid usingSuccessBlock:(void (^)(BOOL isSuccess,NSArray *result,NPlistPopularUsers *popularUser))successBlock;
+ (void)getTimeOnLineDetail:(NSString *)cid usingSuccessBlock:(void (^)(BOOL isSuccess,NSArray *followings,NSArray *others,NSArray *replyHeadImageList))successBlock;
+ (void)getTopDetail:(NSString *)cid usingSuccessBlock:(void (^)(BOOL isSuccess,NSArray *TrendingComment,NSArray *followings,NSArray *others,NSArray *replyHeadImageList))successBlock;

+ (void)getUserInfo:(NSString *)uid usingSuccessBlock:(void (^)(BOOL isSuccess,NPUserDetaiInfolModel *result))successBlock;
+ (void)getUserInfoFollowing:(NSString *)uid usingSuccessBlock:(void (^)(BOOL isSuccess,NSArray *result))successBlock;
@end
