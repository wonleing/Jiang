//
//  NPContentUrlViewController.m
//  newsPicks
//
//  Created by ZhangCheng on 14-8-2.
//  Copyright (c) 2014年 ZhangCheng. All rights reserved.
//

#import "NPContentUrlViewController.h"
#import "NPHTTPRequest.h"
#import "SVProgressHUD.h"
#import "UIViewController+MJPopupViewController.h"

@interface NPContentUrlViewController (){
    NSThread *th;
}
@property (strong, nonatomic) IBOutlet UIBarButtonItem *rightBtn;
@property (weak, nonatomic) IBOutlet UITextField *urlTF;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentTV;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation NPContentUrlViewController
- (IBAction)sendAction:(id)sender {
    if ([self.titleLabel.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"URL无效或者没有有效的标题"];
        return;
    }
    [NPHTTPRequest sendAddThread:[[NSUserDefaults standardUserDefaults]objectForKey:@"com.zhangcheng.uid"] title:self.titleLabel.text type:@"0" content:self.contentTV.text link:self.urlTF.text usingSuccessBlock:^(BOOL isSuccess, NSDictionary *result) {
        if (isSuccess) {
            [SVProgressHUD showSuccessWithStatus:@"发送成功!"];
            
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                [self.navigationController popViewControllerAnimated:YES];
            else
                [self.navigationController dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade completion:nil];
        }else{
            [SVProgressHUD showErrorWithStatus:@"发送失败"];
        }
    }];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=@"Share an TimeOnline";
        self.btn.hidden=(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone);

    }
    return self;
}
- (IBAction)URLChangedAction:(UITextField*)sender {
    if (th) {
        [th cancel];
        th=nil;
    }
    
    th = [[NSThread alloc]initWithTarget:self selector:@selector(dealWithURL:) object:sender.text];
    [th start];
}
-(void)dealWithURL:(NSString*)URL{
    NSString *str = nil;
    if ([URL hasPrefix:@"http://"]) {
        str=URL;
    }else{
        str = [NSString stringWithFormat:@"http://%@",URL];
    }
    NSError *error ;
    
    NSString *str2 = [[NSString alloc]initWithContentsOfURL:[NSURL URLWithString:str] encoding:NSUTF8StringEncoding error:&error];
    if (!error) {
        
        NSRange r1 =[str2 rangeOfString:@"<title>"];
        NSRange r2 =[str2 rangeOfString:@"</title>"];
        if (r1.location!=NSNotFound && r2.location!=NSNotFound) {
            
            
            NSString *str3 =[[str2 substringToIndex:r2.location]substringFromIndex:r1.location+r1.length];
            self.titleLabel.text=str3;
        }

    }else{
        self.titleLabel.text=@"";
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem=self.rightBtn;
    self.btn.hidden=(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
