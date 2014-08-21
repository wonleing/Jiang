//
//  LoginViewController_iPad.m
//  newsPicks
//
//  Created by ZhangCheng on 14-8-8.
//  Copyright (c) 2014年 ZhangCheng. All rights reserved.
//

#import "LoginViewController_iPad.h"
#import "NPHTTPRequest.h"
#import "SVProgressHUD.h"
@interface LoginViewController_iPad ()
@property(weak,nonatomic)IBOutlet UITextField *emailTF;
@property(weak,nonatomic)IBOutlet UITextField *pwdTF;
@end

@implementation LoginViewController_iPad

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return NO;
}
-(IBAction)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)loginAction:(id)sender{
    if ([self.emailTF.text isEqualToString:@""]) {
        return;
    }
    [NPHTTPRequest getLoginUser:self.emailTF.text type:@"facebook" usingSuccessBlock:^(BOOL isSuccess, NSDictionary *result) {
        if (isSuccess) {
            NSLog(@"Yes:%@",result);
            NSNumber *uid = result[@"data"];
            [[NSUserDefaults standardUserDefaults]setObject:uid forKey:@"com.zhangcheng.uid"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }else{
            if (result==nil) {
                [SVProgressHUD showErrorWithStatus:@"网络请求失败"];
            }else{
                [SVProgressHUD showErrorWithStatus:result[@"message"]];
            }
            NSLog(@"no:%@",result);
        }
    }];
}
-(IBAction)regAction:(id)sender{
    if ([self.emailTF.text isEqualToString:@""]) {
        return;
    }
    [NPHTTPRequest getLoginUser:self.emailTF.text type:@"facebook" usingSuccessBlock:^(BOOL isSuccess, NSDictionary *result) {
        if (isSuccess) {
            NSLog(@"Yes:%@",result);
            NSNumber *uid = result[@"data"];
            [[NSUserDefaults standardUserDefaults]setObject:uid forKey:@"com.zhangcheng.uid"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            [self performSegueWithIdentifier:@"next" sender:nil];
        }else{
            if (result==nil) {
                [SVProgressHUD showErrorWithStatus:@"网络请求失败"];
            }else{
                [SVProgressHUD showErrorWithStatus:result[@"message"]];
            }
            NSLog(@"no:%@",result);
        }
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
