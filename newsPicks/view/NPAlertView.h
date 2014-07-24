//
//  NPAlertView.h
//  newsPicks
//
//  Created by yunqi on 14-7-24.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NPAlertView : NSObject<UIAlertViewDelegate>
{
    NSInteger index;
    CFRunLoopRef currentLoop;
}
@property(nonatomic,assign)NSInteger index;
+(NSInteger)showAlert:(NSString *)title  message:(NSString *)message cancle:(NSString *)cancle other:(NSString *)other;
-(NSInteger)showAlert:(NSString *)title  message:(NSString *)message cancle:(NSString *)cancle other:(NSString *)other;
@end
