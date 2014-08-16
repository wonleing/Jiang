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
+ (void)getTimeOnLineData:(NSString *)cid page:(int)page usingSuccessBlock:(void (^)(BOOL isSuccess,NSArray *result))successBlock;
+ (void)getTopData:(int)page usingSuccessBlock:(void (^)(BOOL isSuccess,NSArray *result,NPlistPopularUsers *popularUser))successBlock;
+ (void)getTimeOnLineDetail:(NSString *)cid usingSuccessBlock:(void (^)(BOOL isSuccess,NSArray *followings,NSArray *others,NSArray *replyHeadImageList))successBlock;
+ (void)getTopDetail:(NSString *)cid usingSuccessBlock:(void (^)(BOOL isSuccess,NSArray *TrendingComment,NSArray *followings,NSArray *others,NSArray *replyHeadImageList))successBlock;

+ (void)getUserInfo:(NSString *)uid usingSuccessBlock:(void (^)(BOOL isSuccess,NPUserDetaiInfolModel *result))successBlock;
+ (void)getUserInfoFollowing:(BOOL)isFollowing uid:(NSString *)uid page:(int)page usingSuccessBlock:(void (^)(BOOL isSuccess,NSArray *result))successBlock;
+ (void)getLoginUser:(NSString *)uname type:(NSString *)type usingSuccessBlock:(void (^)(BOOL isSuccess,NSDictionary *result))successBlock;
+(void)sendAddThread:(NSString *)uid title:(NSString*)title type:(NSString *)type content:(NSString*)content link:(NSString*)url usingSuccessBlock:(void (^)(BOOL, NSDictionary *))successBlock;
+(void)getFollowThread:(NSString *)uid thread:(NSString *)tid usingSuccessBlock:(void (^)(BOOL, NSDictionary *))successBlock;
+ (void)getRecommandUser:(NSString *)uid page:(int)page usingSuccessBlock:(void (^)(BOOL isSuccess,NSArray *result))successBlock;
@end
