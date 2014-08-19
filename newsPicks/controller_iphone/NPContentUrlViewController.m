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

@interface NPContentUrlViewController ()<UIWebViewDelegate>{
    NSThread *th;
}
@property (strong, nonatomic) IBOutlet UIBarButtonItem *rightBtn;
@property (weak, nonatomic) IBOutlet UITextField *urlTF;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

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
    
    NSString *str = nil;
    if ([self.urlTF.text hasPrefix:@"http://"]) {
        str=self.urlTF.text;
    }else{
        str = [NSString stringWithFormat:@"http://%@",self.urlTF.text];
    }
    [NPHTTPRequest sendAddThread:[[NSUserDefaults standardUserDefaults]objectForKey:@"com.zhangcheng.uid"] title:self.titleLabel.text type:@"0" content:self.contentTV.text link:str usingSuccessBlock:^(BOOL isSuccess, NSDictionary *result) {
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
//    if (th) {
//        [th cancel];
//        th=nil;
//    }
//    
//    th = [[NSThread alloc]initWithTarget:self selector:@selector(dealWithURL:) object:sender.text];
//    [th start];
    
    NSString *str = nil;
    if ([sender.text hasPrefix:@"http://"]) {
        str=sender.text;
    }else{
        str = [NSString stringWithFormat:@"http://%@",sender.text];
    }
    [self.webView stopLoading];
    NSURL *url =[NSURL URLWithString:str];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [UIApplication sharedApplication].networkActivityIndicatorVisible =NO;

    self.titleLabel.text=@"";
}
-(void)webViewDidStartLoad:(UIWebView *)webView{
    [UIApplication sharedApplication].networkActivityIndicatorVisible =YES;

}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [UIApplication sharedApplication].networkActivityIndicatorVisible =NO;

    NSString *title =  [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if (![self.titleLabel.text isEqualToString:title]) {
        self.titleLabel.text=title;
    }
}
-(void)dealWithURL:(NSString*)URL{
    NSString *str = nil;
    if ([URL hasPrefix:@"http://"]) {
        str=URL;
    }else{
        str = [NSString stringWithFormat:@"http://%@",URL];
    }
    NSError *error ;
//    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:str]];
//    NSData *received = [NSURLConnection sendSynchronousRequest:req returningResponse:nil error:nil];
//    NSString *str2 = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
    
    NSString *str2 = [[NSString alloc]initWithContentsOfURL:[NSURL URLWithString:str] encoding:NSUTF8StringEncoding error:&error];
    if (!error) {
        NSLog(@"%@",str2);
        NSRange r1 =[str2 rangeOfString:@"<title>"];
        NSRange r2 =[str2 rangeOfString:@"</title>"];
        if (r1.location!=NSNotFound && r2.location!=NSNotFound) {
            
            
            NSString *str3 =[[str2 substringToIndex:r2.location]substringFromIndex:r1.location+r1.length];
            self.titleLabel.text=str3;
        }else{
            self.titleLabel.text=str2.length>20?[str2 substringToIndex:20]:str2;
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
