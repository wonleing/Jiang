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
        successBlock(nil);
        
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
            
            NSDictionary *value=[NSJSONSerialization JSONObjectWithData:weakOperation.responseData options:NSJSONReadingMutableContainers error:nil];
            successBlock(value);
        }else
        {
            failureBlock(nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(error);
    }];
    [operation start];

}
+ (void)getTimeOnLineData:(NSString *)cid usingSuccessBlock:(void (^)(BOOL isSuccess,NSArray *result))successBlock
{
    
    //测试数据
    NSMutableArray *list=[NSMutableArray array];
    for (int i=0;i<20;i++) {
        NPListModel *model=[[NPListModel alloc]initWithDataDic:[NSDictionary dictionary]];
        NPlistReplyModel *replyModel=[[NPlistReplyModel alloc] init];
        replyModel.praiseNum=@"100";
        replyModel.name=@"额城市";
        replyModel.time=@"2014/00/00";
        replyModel.position=@"大学教授";
        model.type=NPListType_online;
        model.content=@"测试内容测试内内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试容测试内";
         model.title=@"测试标题测试标题测试标题测试标题测试标题测试标题测试标题测试标题测试标题测试标题测试标题测试标题测试标题测试标题测试标题";
         model.subContent=@"subContent";
        model.replyCount=@"250";
        model.time=@"2014/00/00";
        model.contentImage=@"";
        if (i%2==0) {
            model.contentImage=@"imag.imag";
        }
        
        if (i%3) {
            model.userImageList=[NSArray arrayWithObjects:@"dd",@"ddd",@"cccc", nil];
            replyModel.content=@"测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容";
        }
        model.replyModel=replyModel;
        [list addObject:model];
    }
    successBlock(YES,list);

    return;
    NSString *stringUrl=[NSString stringWithFormat:@"%@",MainStingUrl];
    [NPHTTPRequest getDictionaryWithStringURL:stringUrl usingSuccessBlock:^(NSDictionary *resultDictionary) {
        
        if (1 == [resultDictionary [@"status"] integerValue]) {
            NSMutableArray *list=[NSMutableArray array];
            for (NSDictionary *dic in resultDictionary[@"data"]) {
                NPListModel *model=[[NPListModel alloc]initWithDataDic:dic];
                
                [list addObject:model];
            }
            successBlock(YES,list);
        }else{
            successBlock(NO,nil);
//            [[DMCAlertCenter defaultCenter] postAlertWithMessage:resultDictionary [@"message"]];
        }
        
    } andFailureBlock:^(NSError *resultError) {
        successBlock(NO,nil);
//        [[DMCAlertCenter defaultCenter] postAlertWithMessage:ConnectFailMessage];
    }];

    
}
+ (void)getTopData:(NSString *)cid usingSuccessBlock:(void (^)(BOOL isSuccess,NSArray *result,NPlistPopularUsers *popularUser))successBlock;
{
    //测试数据
    NSMutableArray *list=[NSMutableArray array];
    for (int i=0;i<20;i++) {
        NPListModel *model=[[NPListModel alloc]initWithDataDic:[NSDictionary dictionary]];
        NPlistReplyModel *replyModel=[[NPlistReplyModel alloc] init];
        replyModel.praiseNum=@"100";
        replyModel.name=@"额城市";
        replyModel.time=@"2014/00/00";
        replyModel.position=@"大学教授";
        model.type=NPListType_top;
        model.content=@"测试内容测试内内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试容测试内";
        model.title=@"测试标题测试标题测试标题测试标题测试标题测试标题测试标题测试标题测试标题测试标题测试标题测试标题测试标题测试标题测试标题";
        model.subContent=@"subContent";
        model.replyCount=@"250";
        model.time=@"2014/00/00";
        model.contentImage=@"";
        if (i%2==0) {
            model.contentImage=@"imag.imag";
        }
        
        if (i%3) {
            model.userImageList=[NSArray arrayWithObjects:@"dd",@"ddd",@"cccc",@"dd",@"ddd",@"cccc",@"dd",@"ddd",@"cccc",@"dd",@"ddd",@"cccc", nil];
            replyModel.content=@"测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容测试内容";
        }
        model.replyModel=replyModel;
        [list addObject:model];
    }
    NPlistPopularUsers *popularUser=[[NPlistPopularUsers alloc] init];
    popularUser.time=@"2014/07/22";
    NSMutableArray *users=[NSMutableArray array];
    for (int i=0; i<3; i++) {
        NPlistPopularUser *popuser=[[NPlistPopularUser alloc]init];
        popuser.headImageUrl=@"1111";
        popuser.leve=[NSString stringWithFormat:@"%d",i+1];
        [users addObject:popuser];
    }
    popularUser.popularUsers=users;
    successBlock(YES,list,popularUser);
    
    return;
    NSString *stringUrl=[NSString stringWithFormat:@"%@",MainStingUrl];
    [NPHTTPRequest getDictionaryWithStringURL:stringUrl usingSuccessBlock:^(NSDictionary *resultDictionary) {
        
        if (1 == [resultDictionary [@"status"] integerValue]) {
            NSMutableArray *list=[NSMutableArray array];
            for (NSDictionary *dic in resultDictionary[@"data"]) {
                NPListModel *model=[[NPListModel alloc]initWithDataDic:dic];
                
                [list addObject:model];
            }
            successBlock(YES,list,nil);
        }else{
            successBlock(NO,nil,nil);
        }
        
    } andFailureBlock:^(NSError *resultError) {
        successBlock(NO,nil,nil);
    }];
}
+ (void)getTimeOnLineDetail:(NSString *)cid usingSuccessBlock:(void (^)(BOOL isSuccess,NSArray *followings,NSArray *others,NSArray *replyHeadImageList))successBlock
{
    
    
    NSMutableArray *follows=[NSMutableArray array];
    for (int i=0; i<5; i++) {
        NPlistReplyModel *replyModel=[[NPlistReplyModel alloc] init];
        replyModel.praiseNum=@"100";
        replyModel.name=@"额城市";
        replyModel.time=@"2014/00/00";
        replyModel.position=@"大学教授";
        replyModel.content=@"测试数据测试数据测试出测试数据测www.baidu.com试数据测试出测试数据测试数据测试出测试数据测试数据测试出测试数据测试数据测试出测试数据测试数据测试出";
        [follows addObject:replyModel];
    }
    
    NSMutableArray *others=[NSMutableArray array];
    for (int i=0; i<5; i++) {
        NPlistReplyModel *replyModel=[[NPlistReplyModel alloc] init];
        replyModel.praiseNum=@"10";
        replyModel.name=@"额城市";
        replyModel.time=@"2014/00/00";
        replyModel.position=@"大学教授";
        replyModel.content=@"测试数据测试数据测试出测试数据测www.baidu.com试数据测试出测试数据测试数据测试出测试数据测试数据测试出测试数据测试数据测试出测试数据测试数据测试出测试数据测www.baidu.com试数据测试出测试数据测试数据测试出测试数据测试数据测试出测试数据测试数据测试出测试数据测试数据测试出试数据测试出测试数据测www.baidu.com试数据测试出测试数据测试数据测试出测试数据测试数据测试出测试数据测试数据测试出测试数据测试数据测试出试数据测试出";
        [others addObject:replyModel];
    }
    
    NSMutableArray *images=[NSMutableArray array];
    for (int i=0; i<8; i++) {
        NPlistReplyModel *replyModel=[[NPlistReplyModel alloc]init];
        replyModel.headImageUrl=@"ddd";
        replyModel.name=[NSString stringWithFormat:@"title%d",i+1];
        [images addObject:replyModel];
    }
    successBlock(YES,follows,others,images);
    
    return;
    NSString *stringUrl=[NSString stringWithFormat:@"%@",MainStingUrl];
    [NPHTTPRequest getDictionaryWithStringURL:stringUrl usingSuccessBlock:^(NSDictionary *resultDictionary) {
        
        if (1 == [resultDictionary [@"status"] integerValue]) {
            NSMutableArray *list=[NSMutableArray array];
            for (NSDictionary *dic in resultDictionary[@"data"]) {
                NPListModel *model=[[NPListModel alloc]initWithDataDic:dic];
                
                [list addObject:model];
            }
            successBlock(YES,nil,nil,nil);
        }else{
            successBlock(NO,nil,nil,nil);
        }
        
    } andFailureBlock:^(NSError *resultError) {
        successBlock(NO,nil,nil,nil);
    }];

}
+ (void)getTopDetail:(NSString *)cid usingSuccessBlock:(void (^)(BOOL isSuccess,NSArray *TrendingComment,NSArray *followings,NSArray *others,NSArray *replyHeadImageList))successBlock
{
    
    NSMutableArray *follows=[NSMutableArray array];
    for (int i=0; i<5; i++) {
        NPlistReplyModel *replyModel=[[NPlistReplyModel alloc] init];
        replyModel.praiseNum=@"100";
        replyModel.name=@"额城市";
        replyModel.time=@"2014/00/00";
        replyModel.position=@"大学教授";
        replyModel.content=@"测试数据测试数据测试出测试数据测www.baidu.com试数据测试出测试数据测试数据测试出测试数据测试数据测试出测试数据测试数据测试出测试数据测试数据测试出";
        [follows addObject:replyModel];
    }
    
    NSMutableArray *others=[NSMutableArray array];
    for (int i=0; i<5; i++) {
        NPlistReplyModel *replyModel=[[NPlistReplyModel alloc] init];
        replyModel.praiseNum=@"10";
        replyModel.name=@"额城市";
        replyModel.time=@"2014/00/00";
        replyModel.position=@"大学教授";
        replyModel.content=@"测试数据测试数据测试出测试数据测www.baidu.com试数据测试出测试数据测试数据测试出测试数据测试数据测试出测试数据测试数据测试出测试数据测试数据测试出测试数据测www.baidu.com试数据测试出测试数据测试数据测试出测试数据测试数据测试出测试数据测试数据测试出测试数据测试数据测试出试数据测试出测试数据测www.baidu.com试数据测试出测试数据测试数据测试出测试数据测试数据测试出测试数据测试数据测试出测试数据测试数据测试出试数据测试出";
        [others addObject:replyModel];
    }
    
    NSMutableArray *images=[NSMutableArray array];
    for (int i=0; i<8; i++) {
        NPlistReplyModel *replyModel=[[NPlistReplyModel alloc]init];
        replyModel.headImageUrl=@"ddd";
        replyModel.name=[NSString stringWithFormat:@"title%d",i+1];
        [images addObject:replyModel];
    }
    successBlock(YES,follows,follows,others,images);
    
    return;
    NSString *stringUrl=[NSString stringWithFormat:@"%@",MainStingUrl];
    [NPHTTPRequest getDictionaryWithStringURL:stringUrl usingSuccessBlock:^(NSDictionary *resultDictionary) {
        if (1 == [resultDictionary [@"status"] integerValue]) {
            NSMutableArray *list=[NSMutableArray array];
            for (NSDictionary *dic in resultDictionary[@"data"]) {
                NPListModel *model=[[NPListModel alloc]initWithDataDic:dic];
                
                [list addObject:model];
            }
            successBlock(YES,nil,nil,nil,nil);
        }else{
            successBlock(NO,nil,nil,nil,nil);
        }
        
    } andFailureBlock:^(NSError *resultError) {
        successBlock(NO,nil,nil,nil,nil);
    }];
}
@end
