//
//  BCRequest.h
//  Test2
//
//  Created by NFJ on 13-3-3.
//  Copyright (c) 2013年 BlueCloud Limited. All rights reserved.
//

/*
 * MobileCoreServices.framework
 * SystemConfiguration.framework
 */

#import <Foundation/Foundation.h>

@interface BCRequest : NSObject

//获取Dictionary数据
+ (void)getDictionaryWithStringURL:(NSString *)stringURL usingSuccessBlock:(void (^)(NSDictionary *resultDictionary))successBlock andFailureBlock:(void (^)(NSError *resultError))failureBlock;

//ImageView加载网络图片
+ (void)addImageWithStringURL:(NSString *)stringURL andImageView:(UIImageView *)imageView;

//imageview加载等比例缩小的图片
+ (void)loadImageInImageview:(UIImageView*)imageview fromStringUrl:(NSString*)stringUrl scaleImageViewSizeOfX:(CGFloat)x;

//Post上传图片
+ (void)postImageWithImage:(UIImage *)image andTitle:(NSString *)title intro:(NSString *)intro isShowPublic:(BOOL)isShowPublic workTypeID:(NSInteger)workTypeID workID:(NSInteger)workID;


+(void)doLoginOut:(NSString *)str;
+(BOOL)logiOut:(id)value;
@end