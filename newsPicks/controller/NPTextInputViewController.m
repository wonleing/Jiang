//
//  NPTextInputViewController.m
//  newsPicks
//
//  Created by ZhangCheng on 14-8-9.
//  Copyright (c) 2014年 ZhangCheng. All rights reserved.
//

#import "NPTextInputViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "NPHTTPRequest.h"
#import "SVProgressHUD.h"
@interface NPTextInputViewController ()

@end

@implementation NPTextInputViewController

-(void)sendAction:(id)sender{
    [NPHTTPRequest getFollowThread:[NSString stringWithFormat:@"%d",self.uid.integerValue] thread:self.tid usingSuccessBlock:^(BOOL isSuccess, NSDictionary *dic) {
//        NSLog(@"%@",dic);
//        if (isSuccess) {
//        }
        if (isSuccess) {
            [SVProgressHUD showSuccessWithStatus:@"Success!"];
        }else{
            [SVProgressHUD showErrorWithStatus:dic==nil?@"Newwork Error!":[dic objectForKey:@"message"]];

        }
        [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade completion:nil];

    }];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.uid = [[NSUserDefaults standardUserDefaults]objectForKey:@"com.zhangcheng.uid"];
    self.titleLabel.text=self.mTitle;
    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
