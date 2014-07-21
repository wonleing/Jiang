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
@end
