//
//  NPAlertView.m
//  newsPicks
//
//  Created by yunqi on 14-7-24.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "NPAlertView.h"

@implementation NPAlertView
@synthesize index;
+(NSInteger)showAlert:(NSString *)title  message:(NSString *)message cancle:(NSString *)cancle other:(NSString *)other
{
    
    NPAlertView *alert=[[NPAlertView alloc] init] ;
    return [alert showAlert:title message:message cancle:cancle other:other];
}
-(id)init
{
    if (self=[super init]) {
    }
    return self;
}
-(NSInteger)showAlert:(NSString *)title  message:(NSString *)message cancle:(NSString *)cancle other:(NSString *)other
{
    self.index=NSNotFound;
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancle otherButtonTitles:other, nil] ;
    [alert show];
    CFRunLoopRun();
    return self.index;
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    self.index=buttonIndex;
    CFRunLoopStop(CFRunLoopGetMain());
}
@end
