//
//  NPHTTPRequest.m
//  newsPicks
//
//  Created by yunqi on 14-7-21.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "NPHTTPRequest.h"
#import "AFNetworking.h"
#import "NPListModel.h"
#import "NPlistPopularUsers.h"
#import "NPlistReplyModel.h"
#import "NPUserDetaiInfolModel.h"
#import "SVProgressHUD.h"
#import "NPUserInfoModel.h"
#import "NPRecommandThreadModel.h"

@implementation NPHTTPRequest
//post上传
+(void)postValue:(NSString *)strUrl dic:(NSDictionary *)dic fileDic:(NSDictionary *)fileDic usingSuccessBlock:(void (^)(NSDictionary *resultDictionary))successBlock andFailureBlock:(void (^)(NSError *resultError))failureBlock
{
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:strUrl]];
    NSMutableURLRequest *request = [httpClient multipartFormRequestWithMethod:@"POST" path:nil parameters:nil constructingBodyWithBlock: ^(id <AFMultipartFormData>formData)  {
        for (NSString *key in [dic allKeys]) {
            if ([[dic objectForKey:key] isKindOfClass:[NSString class]]) {
                [formData appendPartWithFormData:[[dic objectForKey:key] dataUsingEncoding:NSUTF8StringEncoding]  name:key];
                
            }
        }
    }];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
    }];
    [httpClient enqueueHTTPRequestOperation:operation];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        id value = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableContainers error:nil];
         successBlock(value);
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.description);
        failureBlock(error);
    }];
}
//获取Dictionary数据
+ (void)getDictionaryWithStringURL:(NSString *)stringURL usingSuccessBlock:(void (^)(NSDictionary *resultDictionary))successBlock andFailureBlock:(void (^)(NSError *resultError))failureBlock
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[stringURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    __weak AFHTTPRequestOperation*weakOperation = operation;
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //if ([NSJSONSerialization isValidJSONObject:weakOperation.responseString]) {
        if (weakOperation.responseData) {
            NSString *str = [weakOperation.responseString stringByReplacingOccurrencesOfString:@"\\\\" withString:@"\\"];
            NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
            NSError *error;
            NSDictionary *value=[NSJSONSerialization JSONObjectWithData:data  options:NSJSONReadingMutableContainers error:&error];
            
            if (error) {
                [SVProgressHUD showErrorWithStatus:@"返回数据格式有误"];

                failureBlock(error);

            }else
                NSLog(@"%@",value);
                successBlock(value);
        }else
        {
            [SVProgressHUD showErrorWithStatus:@"返回空数据"];
            failureBlock(nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络错误"];

        failureBlock(error);
    }];
    [operation start];

}
+ (void)getTimeOnLineData:(NSString *)cid page:(int)page usingSuccessBlock:(void (^)(BOOL isSuccess,NSArray *result))successBlock
{
    
//    //测试数据
//    NSMutableArray *list=[NSMutableArray array];
//    for (int i=0;i<20;i++) {
//        NPListModel *model=[[NPListModel alloc]initWithDataDic:[NSDictionary dictionary]];
//        NPlistReplyModel *replyModel=[[NPlistReplyModel alloc] init];
//        replyModel.praiseNum=@"100";
//        replyModel.name=@"额城市";
//        replyModel.time=@"2014/00/00";
//        replyModel.position=@"大学教授";
//        model.type=NPListType_online;
//        model.content=@"测试内容测试内内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试容测试内";
//         model.title=@"测试标题测试标题测试标题测试标题测试标题测试标题测试标题测试标题测试标题测试标题测试标题测试标题测试标题测试标题测试标题";
//         model.subContent=@"subContent";
//        model.replyCount=@"250";
//        model.time=@"2014/00/00";
//        model.contentImage=@"";
//        if (i%2==0) {
//            model.contentImage=@"imag.imag";
//        }
//        
//        if (i%3) {
//            model.userImageList=[NSArray arrayWithObjects:@"dd",@"ddd",@"cccc", nil];
//            replyModel.content=@"测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容";
//        }
//        model.replyModel=replyModel;
//        [list addObject:model];
//    }
//    successBlock(YES,list);
//
//    return;
    NSString *stringUrl=[NSString stringWithFormat:@"%@%@/%@/%@/%d",BaseUrl,GetFeedStingUrl,cid,ItemNumPerPage,page];
    NSLog(@"%@",stringUrl);
    [NPHTTPRequest getDictionaryWithStringURL:stringUrl usingSuccessBlock:^(NSDictionary *resultDictionary) {
        
        if (1 == [resultDictionary [@"status"] integerValue]) {
            NSMutableArray *list=[NSMutableArray array];
            for (NSDictionary *dic in resultDictionary[@"data"]) {
                NPListModel *model=[[NPListModel alloc]initWithDataDic:dic];
                
                [list addObject:model];
            }
            successBlock(YES,list);
        }else{
            
            [SVProgressHUD showErrorWithStatus:resultDictionary[@"message"]];
            
            successBlock(NO,nil);
//            [[DMCAlertCenter defaultCenter] postAlertWithMessage:resultDictionary [@"message"]];
        }
        
    } andFailureBlock:^(NSError *resultError) {
        successBlock(NO,nil);
//        [[DMCAlertCenter defaultCenter] postAlertWithMessage:ConnectFailMessage];
    }];

    
}
+ (void)getTopData:(int)page usingSuccessBlock:(void (^)(BOOL isSuccess,NSArray *result,NPlistPopularUsers *popularUser))successBlock;
{
//    //测试数据
//    NSMutableArray *list=[NSMutableArray array];
//    for (int i=0;i<20;i++) {
//        NPListModel *model=[[NPListModel alloc]initWithDataDic:[NSDictionary dictionary]];
//        NPlistReplyModel *replyModel=[[NPlistReplyModel alloc] init];
//        replyModel.praiseNum=@"100";
//        replyModel.name=@"额城市";
//        replyModel.time=@"2014/00/00";
//        replyModel.position=@"大学教授";
//        model.type=NPListType_top;
//        model.content=@"测试内容测试内内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试容测试内";
//        model.title=@"测试标题测试标题测试标题测试标题测试标题测试标题测试标题测试标题测试标题测试标题测试标题测试标题测试标题测试标题测试标题";
//        model.subContent=@"subContent";
//        model.replyCount=@"250";
//        model.time=@"2014/00/00";
//        model.contentImage=@"";
//        if (i%2==0) {
//            model.contentImage=@"imag.imag";
//        }
//        
//        if (i%3) {
//            model.userImageList=[NSArray arrayWithObjects:@"dd",@"ddd",@"cccc",@"dd",@"ddd",@"cccc",@"dd",@"ddd",@"cccc",@"dd",@"ddd",@"cccc", nil];
//            replyModel.content=@"测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容";
//        }
//        model.replyModel=replyModel;
//        [list addObject:model];
//    }
//    NPlistPopularUsers *popularUser=[[NPlistPopularUsers alloc] init];
//    popularUser.time=@"2014/07/22";
//    NSMutableArray *users=[NSMutableArray array];
//    for (int i=0; i<3; i++) {
//        NPlistPopularUser *popuser=[[NPlistPopularUser alloc]init];
//        popuser.headImageUrl=@"1111";
//        popuser.leve=[NSString stringWithFormat:@"%d",i+1];
//        [users addObject:popuser];
//    }
//    popularUser.popularUsers=users;
//    successBlock(YES,list,popularUser);
//    
//    return;
    NSString *stringUrl=[NSString stringWithFormat:@"%@%@/%@/%d",BaseUrl,GetRecommandThread,ItemNumPerPage,page];
    NSLog(@"%@",stringUrl);
    [NPHTTPRequest getDictionaryWithStringURL:stringUrl usingSuccessBlock:^(NSDictionary *resultDictionary) {
        
        if (1 == [resultDictionary [@"status"] integerValue]) {
            NSMutableArray *list=[NSMutableArray array];
            for (NSDictionary *dic in resultDictionary[@"data"]) {
                NPListModel *model=[[NPListModel alloc]initWithDataDic:dic];
                
                [list addObject:model];
            }
            successBlock(YES,list,nil);
        }else{
            [SVProgressHUD showErrorWithStatus:resultDictionary[@"message"]];

            successBlock(NO,nil,nil);
        }
        
    } andFailureBlock:^(NSError *resultError) {
        successBlock(NO,nil,nil);
    }];
}
+ (void)getTimeOnLineDetail:(NSString *)cid usingSuccessBlock:(void (^)(BOOL isSuccess,NSArray *followings,NSArray *others,NSArray *replyHeadImageList))successBlock
{
//    
//    
//    NSMutableArray *follows=[NSMutableArray array];
//    for (int i=0; i<5; i++) {
//        NPlistReplyModel *replyModel=[[NPlistReplyModel alloc] init];
//        replyModel.praiseNum=@"100";
//        replyModel.name=@"额城市";
//        replyModel.time=@"2014/00/00";
//        replyModel.position=@"大学教授";
//        replyModel.content=@"测试数据测试数据测试出测试数据测www.baidu.com试数据测试出测试数据测试数据测试出测试数据测试数据测试出测试数据测试数据测试出测试数据测试数据测试出";
//        [follows addObject:replyModel];
//    }
//    
//    NSMutableArray *others=[NSMutableArray array];
//    for (int i=0; i<5; i++) {
//        NPlistReplyModel *replyModel=[[NPlistReplyModel alloc] init];
//        replyModel.praiseNum=@"10";
//        replyModel.name=@"额城市";
//        replyModel.time=@"2014/00/00";
//        replyModel.position=@"大学教授";
//        replyModel.content=@"测试数据测试数据测试出测试数据测www.baidu.com试数据测试出测试数据测试数据测试出测试数据测试数据测试出测试数据测试数据测试出测试数据测试数据测试出测试数据测www.baidu.com试数据测试出测试数据测试数据测试出测试数据测试数据测试出测试数据测试数据测试出测试数据测试数据测试出试数据测试出测试数据测www.baidu.com试数据测试出测试数据测试数据测试出测试数据测试数据测试出测试数据测试数据测试出测试数据测试数据测试出试数据测试出";
//        [others addObject:replyModel];
//    }
//    
//    NSMutableArray *images=[NSMutableArray array];
//    for (int i=0; i<8; i++) {
//        NPlistReplyModel *replyModel=[[NPlistReplyModel alloc]init];
//        replyModel.headImageUrl=@"ddd";
//        replyModel.name=[NSString stringWithFormat:@"title%d",i+1];
//        [images addObject:replyModel];
//    }
//    successBlock(YES,follows,others,images);
//    
//    return;
    NSString *stringUrl=[NSString stringWithFormat:@"%@%@/%@",BaseUrl,GetThreadInfo,cid];
    [NPHTTPRequest getDictionaryWithStringURL:stringUrl usingSuccessBlock:^(NSDictionary *resultDictionary) {
        
        if (1 == [resultDictionary [@"status"] integerValue]) {
            NSMutableArray *list=[NSMutableArray array];
            for (NSDictionary *dic in resultDictionary[@"data"]) {
                
                NPListModel *model=[[NPListModel alloc]initWithDataDic:dic];
                
                [list addObject:model];
            }
            successBlock(YES,nil,nil,nil);
        }else{
            [SVProgressHUD showErrorWithStatus:resultDictionary[@"message"]];

            successBlock(NO,nil,nil,nil);
        }
        
    } andFailureBlock:^(NSError *resultError) {
        successBlock(NO,nil,nil,nil);
    }];

}
+ (void)getTopDetail:(NSString *)cid usingSuccessBlock:(void (^)(BOOL isSuccess,NSArray *TrendingComment,NSArray *followings,NSArray *others,NSArray *replyHeadImageList))successBlock
{
    
//    NSMutableArray *follows=[NSMutableArray array];
//    for (int i=0; i<5; i++) {
//        NPlistReplyModel *replyModel=[[NPlistReplyModel alloc] init];
//        replyModel.praiseNum=@"100";
//        replyModel.name=@"额城市";
//        replyModel.time=@"2014/00/00";
//        replyModel.position=@"大学教授";
//        replyModel.content=@"测试数据测试数据测试出测试数据测www.baidu.com试数据测试出测试数据测试数据测试出测试数据测试数据测试出测试数据测试数据测试出测试数据测试数据测试出";
//        [follows addObject:replyModel];
//    }
//    
//    NSMutableArray *others=[NSMutableArray array];
//    for (int i=0; i<5; i++) {
//        NPlistReplyModel *replyModel=[[NPlistReplyModel alloc] init];
//        replyModel.praiseNum=@"10";
//        replyModel.name=@"额城市";
//        replyModel.time=@"2014/00/00";
//        replyModel.position=@"大学教授";
//        replyModel.content=@"测试数据测试数据测试出测试数据测www.baidu.com试数据测试出测试数据测试数据测试出测试数据测试数据测试出测试数据测试数据测试出测试数据测试数据测试出测试数据测www.baidu.com试数据测试出测试数据测试数据测试出测试数据测试数据测试出测试数据测试数据测试出测试数据测试数据测试出试数据测试出测试数据测www.baidu.com试数据测试出测试数据测试数据测试出测试数据测试数据测试出测试数据测试数据测试出测试数据测试数据测试出试数据测试出";
//        [others addObject:replyModel];
//    }
//    
//    NSMutableArray *images=[NSMutableArray array];
//    for (int i=0; i<8; i++) {
//        NPlistReplyModel *replyModel=[[NPlistReplyModel alloc]init];
//        replyModel.headImageUrl=@"ddd";
//        replyModel.name=[NSString stringWithFormat:@"title%d",i+1];
//        [images addObject:replyModel];
//    }
//    successBlock(YES,follows,follows,others,images);
//    
//    return;
    NSString *stringUrl=[NSString stringWithFormat:@"%@%@/%@",BaseUrl,GetThreadInfo,cid];
    [NPHTTPRequest getDictionaryWithStringURL:stringUrl usingSuccessBlock:^(NSDictionary *resultDictionary) {
        if (1 == [resultDictionary [@"status"] integerValue]) {
            NSMutableArray *list=[NSMutableArray array];
            for (NSDictionary *dic in resultDictionary[@"data"]) {
                NPListModel *model=[[NPListModel alloc]initWithDataDic:dic];
                
                [list addObject:model];
            }
            successBlock(YES,nil,nil,nil,nil);
        }else{
            [SVProgressHUD showErrorWithStatus:resultDictionary[@"message"]];

            successBlock(NO,nil,nil,nil,nil);
        }
        
    } andFailureBlock:^(NSError *resultError) {
        successBlock(NO,nil,nil,nil,nil);
    }];
}
+ (void)getUserInfo:(NSString *)uid usingSuccessBlock:(void (^)(BOOL isSuccess,NPUserDetaiInfolModel *result))successBlock
{
    
//    NPUserDetaiInfolModel *infoModel=[[NPUserDetaiInfolModel alloc]init];
//    infoModel.name=@"测试姓名";
//    infoModel.typeName=@"人民教室";
//    infoModel.likeNum=@"2048";
//    infoModel.description=@"描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,";
//    infoModel.followers_num=@"10900";
//    infoModel.following_num=@"102";
//    infoModel.is_following=@"0";
//    infoModel.isPremium=@"0";
//    successBlock(YES,infoModel);
//    return;
    NSString *stringUrl=[NSString stringWithFormat:@"%@%@/%@",BaseUrl,GetUserProfile,uid];
    NSLog(@"%@",stringUrl);
    [NPHTTPRequest getDictionaryWithStringURL:stringUrl usingSuccessBlock:^(NSDictionary *resultDictionary) {
        if (1 == [resultDictionary [@"status"] integerValue]) {
            NPUserDetaiInfolModel *model=[[NPUserDetaiInfolModel alloc]initWithDataDic:resultDictionary[@"data"]];
            
            successBlock(YES,model);
        }else{
            successBlock(NO,nil);
        }
        
    } andFailureBlock:^(NSError *resultError) {
        successBlock(YES,nil);
    }];

}
+ (void)getUserInfoFollowing:(BOOL)isFollowing uid:(NSString *)uid page:(int)page usingSuccessBlock:(void (^)(BOOL isSuccess,NSArray *result))successBlock
{
//    NSMutableArray *list=[[NSMutableArray alloc]init];
//    for (int i=0; i<20; i++) {
//        NPUserDetaiInfolModel *infoModel=[[NPUserDetaiInfolModel alloc]init];
//        infoModel.name=@"测试姓名";
//        infoModel.typeName=@"人民教室";
//        infoModel.likeNum=@"28";
//        infoModel.description=@"描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,描述内容,";
//        infoModel.followers_num=@"100";
//        infoModel.following_num=@"12";
//        infoModel.is_following=@"0";
//        infoModel.isPremium=@"0";
//        if (i%3==0) {
//            infoModel.is_following=@"1";
//        }
//        [list addObject:infoModel];
//    }
//    successBlock(YES,list);
//    return;
    
    
    
    NSString *stringUrl=[NSString stringWithFormat:@"%@%@/%@/%@/%d",BaseUrl,(!isFollowing)?GetFollowing:GetFollower,uid,ItemNumPerPage,page];
//    NSString *stringUrl=[NSString stringWithFormat:@"%@%@/%@/%d",BaseUrl,GetRecommandUser,ItemNumPerPage,page];
    NSLog(@"%@",stringUrl);
    [NPHTTPRequest getDictionaryWithStringURL:stringUrl usingSuccessBlock:^(NSDictionary *resultDictionary) {
        if (1 == [resultDictionary [@"status"] integerValue]) {
            NSMutableArray *list=[NSMutableArray array];
            for (NSDictionary *dic in resultDictionary[@"data"]) {
                NPUserDetaiInfolModel *model=[[NPUserDetaiInfolModel alloc]initWithDataDic:dic];
                
                [list addObject:model];
            }
            successBlock(YES,list);
        }else{
            
            [SVProgressHUD showErrorWithStatus:resultDictionary[@"message"]];

            successBlock(NO,nil);
        }
        
    } andFailureBlock:^(NSError *resultError) {
        successBlock(NO,nil);
    }];

}
+ (void)getRecommandUser:(NSString *)uid page:(int)page usingSuccessBlock:(void (^)(BOOL isSuccess,NSArray *result))successBlock
{
    NSString *stringUrl=[NSString stringWithFormat:@"%@%@/%@/0/%@/%d",BaseUrl,GetRecommandUser,uid,ItemNumPerPage,page];
    //    NSString *stringUrl=[NSString stringWithFormat:@"%@%@/%@/%d",BaseUrl,GetRecommandUser,ItemNumPerPage,page];
    NSLog(@"%@",stringUrl);
    [NPHTTPRequest getDictionaryWithStringURL:stringUrl usingSuccessBlock:^(NSDictionary *resultDictionary) {
        if (1 == [resultDictionary [@"status"] integerValue]) {
            NSMutableArray *list=[NSMutableArray array];
            for (NSDictionary *dic in resultDictionary[@"data"]) {
                NPUserDetaiInfolModel *model=[[NPUserDetaiInfolModel alloc]initWithDataDic:dic];
                
                [list addObject:model];
            }
            successBlock(YES,list);
        }else{
            
            [SVProgressHUD showErrorWithStatus:resultDictionary[@"message"]];
            
            successBlock(NO,nil);
        }
        
    } andFailureBlock:^(NSError *resultError) {
        successBlock(NO,nil);
    }];
    
}

+(void)getLoginUser:(NSString *)uname type:(NSString *)type usingSuccessBlock:(void (^)(BOOL, NSDictionary *))successBlock{
    NSString *stringUrl=[NSString stringWithFormat:@"%@%@/%@/%@",BaseUrl,LoginStingUrl,uname,type];
    [NPHTTPRequest getDictionaryWithStringURL:stringUrl usingSuccessBlock:^(NSDictionary *resultDictionary) {
        if (1 == [resultDictionary [@"status"] integerValue]) {
            
            successBlock(YES,resultDictionary);
        }else{
            successBlock(NO,resultDictionary);
        }
        
    } andFailureBlock:^(NSError *resultError) {
        successBlock(NO,nil);
    }];
    
}

+(void)getFollowThread:(NSString *)uid thread:(NSString *)tid usingSuccessBlock:(void (^)(BOOL, NSDictionary *))successBlock{
    NSString *stringUrl=[NSString stringWithFormat:@"%@%@/%@/%@",BaseUrl,FollowThread,uid,tid];
    NSLog(@"%@",stringUrl);
    [NPHTTPRequest getDictionaryWithStringURL:stringUrl usingSuccessBlock:^(NSDictionary *resultDictionary) {
        if (1 == [resultDictionary [@"status"] integerValue]) {
            
            successBlock(YES,resultDictionary);
        }else{
            successBlock(NO,resultDictionary);
        }
        
    } andFailureBlock:^(NSError *resultError) {
        successBlock(NO,nil);
    }];
    
}

+(void)getLikeThread:(NSString *)uid thread:(NSString *)tid usingSuccessBlock:(void (^)(BOOL, NSDictionary *))successBlock{
    NSString *stringUrl=[NSString stringWithFormat:@"%@%@/%@/%@",BaseUrl,LikeThread,uid,tid];
    NSLog(@"%@",stringUrl);
    [NPHTTPRequest getDictionaryWithStringURL:stringUrl usingSuccessBlock:^(NSDictionary *resultDictionary) {
        if (1 == [resultDictionary [@"status"] integerValue]) {
            
            successBlock(YES,resultDictionary);
        }else{
            successBlock(NO,resultDictionary);
        }
        
    } andFailureBlock:^(NSError *resultError) {
        successBlock(NO,nil);
    }];
    
}

+(void)getFollowUser:(NSString *)uid targetUser:(NSString *)tid usingSuccessBlock:(void (^)(BOOL, NSDictionary *))successBlock{
    NSString *stringUrl=[NSString stringWithFormat:@"%@%@/%@/%@",BaseUrl,FollowUser,uid,tid];
    NSLog(@"%@",stringUrl);
    [NPHTTPRequest getDictionaryWithStringURL:stringUrl usingSuccessBlock:^(NSDictionary *resultDictionary) {
        if (1 == [resultDictionary [@"status"] integerValue]) {
            
            successBlock(YES,resultDictionary);
        }else{
            successBlock(NO,resultDictionary);
        }
        
    } andFailureBlock:^(NSError *resultError) {
        successBlock(NO,nil);
    }];
    
}
+(void)getUnfollowUser:(NSString *)uid targetUser:(NSString *)tid usingSuccessBlock:(void (^)(BOOL, NSDictionary *))successBlock{
    NSString *stringUrl=[NSString stringWithFormat:@"%@%@/%@/%@",BaseUrl,UnfollowUser,uid,tid];
    NSLog(@"%@",stringUrl);
    [NPHTTPRequest getDictionaryWithStringURL:stringUrl usingSuccessBlock:^(NSDictionary *resultDictionary) {
        if (1 == [resultDictionary [@"status"] integerValue]) {
            
            successBlock(YES,resultDictionary);
        }else{
            successBlock(NO,resultDictionary);
        }
        
    } andFailureBlock:^(NSError *resultError) {
        successBlock(NO,nil);
    }];
    
}



+(void)sendAddThread:(NSString *)uid title:(NSString*)title type:(NSString *)type content:(NSString*)content link:(NSString*)url usingSuccessBlock:(void (^)(BOOL, NSDictionary *))successBlock{
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@""]];//这里要将url设置为空
    
    httpClient.parameterEncoding = AFJSONParameterEncoding;
    
    [httpClient setDefaultHeader:@"Content-Type" value:@"application/json"];
    
    
    NSMutableDictionary *params=[[NSMutableDictionary alloc] init];   // 要传递的json数据是一个字典
    
    [params setObject:uid forKey:@"userid"];
    
    [params setObject:title forKey:@"title"];
    
    [params setObject:type forKey:@"cateid"];
    [params setObject:content forKey:@"content"];
    [params setObject:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"link"];
    
    
    
    // httpClient 的postPath就是上文中的pathStr，即你要访问的URL地址，这里是向服务器提交一个数据请求，
    
    [httpClient postPath:POSTURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"data====%@",params);
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"Request Successful, response '%@'", responseStr);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        successBlock(YES,dic);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        successBlock(NO,nil);
        NSLog(@"[HTTPClient Error]: %@", error);
    }];

}

+(void)sendProfile:(NSString*)username family:(NSString*)family given:(NSString*)given company:(NSString*)company position:(NSString*)position description:(NSString*)description userimage:(NSString*)userimage usingSuccessBlock:(void (^)(BOOL isSuccess,NSDictionary *dic))successBlock
{
//    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@""]];//这里要将url设置为空
//    httpClient.parameterEncoding = AFJSONParameterEncoding;
//    [httpClient setDefaultHeader:@"Content-Type" value:@"application/json"];
//    NSMutableDictionary *params=[[NSMutableDictionary alloc] init];   // 要传递的json数据是一个字典
//    [params setObject:username forKey:@"loginname"];
//    [params setObject:@"facebook" forKey:@"type"];
//    [params setObject:given forKey:@"given"];
//    [params setObject:company forKey:@"company"];
//    [params setObject:position forKey:@"position"];
//    [params setObject:description forKey:@"description"];
////    [params setObject:userimage forKey:@"userimage"];
//    
//    [httpClient postPath:POSTURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
//        successBlock(YES,dic);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        successBlock(NO,nil);
//    }];
    NSString *type = @"facebook";
    NSString *stringUrl = [NSString stringWithFormat:@"%@loginUser/%@/%@/%@/%@/%@/%@/%@/%@",BaseUrl,username,type,family,given,company,position,description,userimage];
    NSLog(@"%@",stringUrl);
    [NPHTTPRequest getDictionaryWithStringURL:stringUrl usingSuccessBlock:^(NSDictionary *resultDictionary) {
        if (1 == [resultDictionary [@"status"] integerValue]) {
            successBlock(YES,[resultDictionary objectForKey:@"data"]);
        }else
        {
            successBlock(NO,nil);
        }
    } andFailureBlock:^(NSError *resultError) {
        successBlock(NO,nil);
    }];
}

+ (void)getUserInfo:(NSString *)uid successBlock:(void (^)(BOOL isSuccess,NPUserInfoModel *result))successBlock
{
    NSString *stringUrl=[NSString stringWithFormat:@"%@%@/%@",BaseUrl,GetUserProfile,uid];
    NSLog(@"%@",stringUrl);
    [NPHTTPRequest getDictionaryWithStringURL:stringUrl usingSuccessBlock:^(NSDictionary *resultDictionary) {
        NSLog(@"-----%@",resultDictionary);
        if (1 == [resultDictionary [@"status"] integerValue]) {
            NSArray *array = [resultDictionary objectForKey:@"data"];
            if (array.count == 1) {
                NSDictionary *dic = [array objectAtIndex:0];
                NPUserInfoModel *model = [[NPUserInfoModel alloc] init];
                model.uid = uid;
                model.name = [dic objectForKey:@"loginname"];
                model.description = [dic objectForKey:@"description"];
                model.typeName = [dic objectForKeyedSubscript:@"type"];
                successBlock(YES,model);
            }

        }else{
            successBlock(NO,nil);
        }
        
    } andFailureBlock:^(NSError *resultError) {
        successBlock(YES,nil);
    }];
}

+ (void)getRecommandThreadSuccessBlock:(void (^)(BOOL isSuccess, NSArray *array))successBlock
{
    NSString *stringUrl=[NSString stringWithFormat:@"%@%@/99/1",BaseUrl,GetRecommandThread];
    [NPHTTPRequest getDictionaryWithStringURL:stringUrl usingSuccessBlock:^(NSDictionary *resultDictionary) {
        if (1 == [resultDictionary [@"status"] integerValue]) {
            NSArray *data = [resultDictionary objectForKey:@"data"];
            NSMutableArray *array = [NSMutableArray array];
            for (int i = 0; i<data.count; i++) {
                NSDictionary *dic = [data objectAtIndex:i];
                NPRecommandThreadModel *recomand = [[NPRecommandThreadModel alloc]init];
                recomand.userimage = [dic objectForKey:@"userimage"];
                recomand.position = [dic objectForKey:@"position"];
                recomand.createdate = [dic objectForKey:@"createdate"];
                recomand.link = [dic objectForKey:@"link"];
                recomand.title = [dic objectForKey:@"title"];
                recomand.threadid = [dic objectForKey:@"threadid"];
                recomand.type = [dic objectForKey:@"type"];
                recomand.description = [dic objectForKey:@"description"];
                recomand.given = [dic objectForKey:@"given"];
                recomand.score = [dic objectForKey:@"score"];
                recomand.family = [dic objectForKey:@"family"];
                recomand.company = [dic objectForKey:@"company"];
                recomand.content = [dic objectForKey:@"content"];
                recomand.loginname = [dic objectForKey:@"loginname"];
                recomand.cateid = [dic objectForKey:@"cateid"];
                recomand.threadimage = [dic objectForKey:@"threadimage"];
                recomand.userid = [dic objectForKey:@"userid"];
                [array addObject:recomand];
            }
            
            successBlock(YES,array);
        }else{
            
            [SVProgressHUD showErrorWithStatus:resultDictionary[@"message"]];
            
            successBlock(NO,nil);
        }
        
    } andFailureBlock:^(NSError *resultError) {
        successBlock(NO,nil);
    }];
    
}

@end
