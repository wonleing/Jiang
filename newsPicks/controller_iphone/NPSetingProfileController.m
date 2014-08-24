//
//  NPSetingProfileController.m
//  newsPicks
//
//  Created by yunqi on 14-7-28.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "NPSetingProfileController.h"
#import "SVProgressHUD.h"


@interface NPSetingProfileController ()<UITextFieldDelegate,UITextViewDelegate>
{
    UIScrollView *mScrollView;
    UITextField *textFieldID;
    UITextField *textFildLastName;
    UITextField *textFildFirstName;
     UITextField *textFildCompand;
    UITextField *textFildJob;
    UITextView *textBio;
    
    NSString *user_name;
}
@end

@implementation NPSetingProfileController

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
    // Do any additional setup after loading the view.
    [self creatNavBtn];
    [self creatContentView];
    [self requestUserMessage];
}

- (void)creatNavBtn
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"SAVE" style:UIBarButtonItemStylePlain target:self action:@selector(saveMessage)];
}

- (void)creatContentView
{
    mScrollView.backgroundColor=[UIColor whiteColor];
    mScrollView=[[UIScrollView alloc]init];
    mScrollView.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44);
    [self.view addSubview:mScrollView];
    
    
    self.title=@"Profile";
    float leftPlace=9;
    float place=5;
    UILabel *lableID=[[UILabel alloc]init];
    lableID.frame=CGRectMake(leftPlace, 3, 100, 20);
    lableID.font=[UIFont systemFontOfSize:15];
    lableID.backgroundColor=[UIColor clearColor];
    lableID.textColor=[UIColor lightGrayColor];
    lableID.text=@"ID *";
//    [mScrollView addSubview:lableID];
//
    textFieldID=[[UITextField alloc]init];
    textFieldID.frame=CGRectMake(lableID.frame.origin.x, lableID.frame.size.height+lableID.frame.origin.y,self.view.frame.size.width-leftPlace*2, 25);
    textFieldID.layer.borderWidth=0.5;
    textFieldID.delegate=self;
    textFieldID.layer.borderColor=[UIColor blackColor].CGColor;
    textFieldID.borderStyle=UITextBorderStyleNone;
//    [mScrollView addSubview:textFieldID];
    
    UILabel *labeLastName=[[UILabel alloc]init];
//    labeLastName.frame=CGRectMake(lableID.frame.origin.x, textFieldID.frame.size.height+textFieldID.frame.size.height+place, (self.view.frame.size.width-leftPlace*2-30)/2, lableID.frame.size.height);
    labeLastName.frame=CGRectMake(lableID.frame.origin.x, 3, (self.view.frame.size.width-leftPlace*2-30)/2, lableID.frame.size.height);
    labeLastName.font=lableID.font;
    labeLastName.textColor=lableID.textColor;
    labeLastName.backgroundColor=[UIColor clearColor];
    labeLastName.text=@"Last Name";
    [mScrollView addSubview:labeLastName];
    
    textFildLastName=[[UITextField alloc]init];
    textFildLastName.frame=CGRectMake(labeLastName.frame.origin.x, labeLastName.frame.size.height+labeLastName.frame.origin.y, labeLastName.frame.size.width, textFieldID.frame.size.height);
    textFildLastName.borderStyle=UITextBorderStyleNone;
    textFildLastName.delegate=self;
    textFildLastName.layer.borderColor=textFieldID.layer.borderColor;
    textFildLastName.layer.borderWidth=textFieldID.layer.borderWidth;
    [mScrollView addSubview:textFildLastName];
    
    UILabel *labelFirstName=[[UILabel alloc]init];
//    labelFirstName.frame=CGRectMake(labeLastName.frame.size.width+labeLastName.frame.origin.x+30, labeLastName.frame.origin.y, labeLastName.frame.size.width, labeLastName.frame.size.height);
    labelFirstName.frame=CGRectMake(labeLastName.frame.size.width+labeLastName.frame.origin.x+30, 3, labeLastName.frame.size.width, labeLastName.frame.size.height);
    labelFirstName.backgroundColor=[UIColor clearColor];
    labelFirstName.font=labeLastName.font;
    labelFirstName.textColor=labeLastName.textColor;
    labelFirstName.text=@"First Name";
    [mScrollView addSubview:labelFirstName];
    
    textFildFirstName=[[UITextField alloc]init];
    textFildFirstName.frame=CGRectMake(labelFirstName.frame.origin.x, labelFirstName.frame.size.height+labelFirstName.frame.origin.y, labelFirstName.frame.size.width, textFieldID.frame.size.height);
    textFildFirstName.backgroundColor=[UIColor clearColor];
    textFildFirstName.borderStyle=UITextBorderStyleNone;
    textFildFirstName.delegate=self;
    textFildFirstName.layer.borderWidth=textFieldID.layer.borderWidth;
    textFildFirstName.layer.borderColor=textFieldID.layer.borderColor;
    [mScrollView addSubview:textFildFirstName];
    
    UILabel *labelCompany=[[UILabel alloc]init];
    labelCompany.frame=CGRectMake(labeLastName.frame.origin.x, textFildFirstName.frame.size.height+textFildFirstName.frame.origin.y+place, 200, lableID.frame.size.height);
    labelCompany.textColor=lableID.textColor;
    labelCompany.font=lableID.font;
    labelCompany.backgroundColor=[UIColor clearColor];
    labelCompany.text=@"Company Name";
    [mScrollView addSubview:labelCompany];
    
    textFildCompand=[[UITextField alloc]init];
    textFildCompand.frame=CGRectMake(labelCompany.frame.origin.x, labelCompany.frame.size.height+labelCompany.frame.origin.y, textFieldID.frame.size.width, textFieldID.frame.size.height);
    textFildCompand.borderStyle=UITextBorderStyleNone;
    textFildCompand.delegate=self;
    textFildCompand.layer.borderColor=textFieldID.layer.borderColor;
    textFildCompand.layer.borderWidth=textFieldID.layer.borderWidth;
    [mScrollView addSubview:textFildCompand];
    
    
    UILabel *labelJob=[[UILabel alloc]init];
    labelJob.frame=CGRectMake(textFildCompand.frame.origin.x, textFildCompand.frame.size.height+textFildCompand.frame.origin.y+place, 200, lableID.frame.size.height);
    labelJob.font=lableID.font;
    labelJob.textColor=lableID.textColor;
    labelJob.backgroundColor=[UIColor clearColor];
    labelJob.text=@"Job Title";
    [mScrollView addSubview:labelJob];
    
    textFildJob=[[UITextField alloc]init];
    textFildJob.frame=CGRectMake(labelJob.frame.origin.x, labelJob.frame.size.height+labelJob.frame.origin.y, textFieldID.frame.size.width, textFieldID.frame.size.height);
    textFildJob.borderStyle=UITextBorderStyleNone;
    textFildJob.delegate=self;
    textFildJob.layer.borderWidth=textFieldID.layer.borderWidth;
    textFildJob.layer.borderColor=textFieldID.layer.borderColor;
    [mScrollView addSubview:textFildJob];
    
    UILabel *labelBio=[[UILabel alloc]init];
    labelBio.frame=CGRectMake(labeLastName.frame.origin.x, textFildJob.frame.size.height+textFildJob.frame.origin.y+place, 200, labelJob.frame.size.height);
    labelBio.font=lableID.font;
    labelBio.textColor=lableID.textColor;
    labelBio.backgroundColor=[UIColor clearColor];
    labelBio.text=@"Bio";
    [mScrollView addSubview:labelBio];
    textBio=[[UITextView alloc]init];
    textBio.delegate=self;
    textBio.backgroundColor=[UIColor clearColor];
    textBio.layer.borderColor=textFildJob.layer.borderColor;
    textBio.layer.borderWidth=textFildJob.layer.borderWidth;
    textBio.frame=CGRectMake(lableID.frame.origin.x, labelBio.frame.size.height+labelBio.frame.origin.y, textFieldID.frame.size.width, 170);
    [mScrollView addSubview:textBio];
    
    
    mScrollView.contentSize=CGSizeMake(mScrollView.frame.size.width, textBio.frame.size.height+textBio.frame.origin.y+130);
    
    [mScrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapContent)]];
}
-(void)tapContent
{
    [textFieldID resignFirstResponder];
    [textFildLastName resignFirstResponder];
    [textFildFirstName resignFirstResponder];
    [textFildCompand resignFirstResponder];
    [textFildJob resignFirstResponder];
    [textBio resignFirstResponder];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([textFildJob isEqual:textField]) {
        [mScrollView setContentOffset:CGPointMake(0, textFildJob.frame.origin.y-60) animated:YES];
    }
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
     [mScrollView setContentOffset:CGPointMake(0, textBio.frame.origin.y-20) animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)saveMessage
{
     [NPHTTPRequest sendProfile:user_name  family:textFildFirstName.text given:textFildLastName.text company:textFildCompand.text position:textFildJob.text description:textBio.text userimage:nil usingSuccessBlock:^(BOOL isSuccess, NSDictionary *dic) {
         if (isSuccess) {
             [SVProgressHUD showSuccessWithStatus:@"发送成功!"];
             
             if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                 [self.navigationController popViewControllerAnimated:YES];
             else
                 [self.navigationController popViewControllerAnimated:YES];
         }else{
             [SVProgressHUD showErrorWithStatus:@"发送失败"];
         }
     }];
}

- (void)requestUserMessage
{
    
    [NPHTTPRequest getUserInfo:[[NSUserDefaults standardUserDefaults]objectForKey:@"com.zhangcheng.uid"] successBlock:^(BOOL isSuccess, NPUserInfoModel *result) {
        if (isSuccess) {
            user_name = result.name;
            textBio.text = result.description;
            textFildFirstName.text=result.family;
            textFildCompand.text = result.company;
            textFildJob.text = result.position;
            textFildLastName.text = result.given;
        }else
        {
            [SVProgressHUD showErrorWithStatus:@"加载失败"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}



@end
