//
//  NPSettingEmailController.m
//  newsPicks
//
//  Created by yunqi on 14-7-28.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "NPSettingEmailController.h"

@interface NPSettingEmailController ()
{
    UITextField *textEmail;
    UITextField *textEmailTwo;
}
@end

@implementation NPSettingEmailController

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
    self.title=@"Email";
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatContent];
}
-(void)tapContent
{
    [textEmailTwo resignFirstResponder];
    [textEmail resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)creatContent
{
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithTitle:@"SAVE" style:UIBarButtonItemStylePlain target:self action:@selector(saveEmail)];
    self.navigationItem.rightBarButtonItem = barBtn;
    UILabel *labelCurrent=[[UILabel alloc]init];
    labelCurrent.font=[UIFont systemFontOfSize:15];
    labelCurrent.textColor=[UIColor lightGrayColor];
    labelCurrent.frame=CGRectMake(9, 9, 200, 20);
    labelCurrent.backgroundColor=[UIColor clearColor];
    labelCurrent.text=@"Current Email";
    [self.view addSubview:labelCurrent];
    
    UILabel *labelID=[[UILabel alloc]init];
    labelID.frame=CGRectMake(labelCurrent.frame.origin.x, labelCurrent.frame.size.height+labelCurrent.frame.origin.y+5, self.view.frame.size.width-18, labelCurrent.frame.size.height);
    labelID.font=[UIFont systemFontOfSize:15];
    labelID.textColor=[UIColor blackColor];
    labelID.backgroundColor=[UIColor clearColor];
    labelID.text=@"********";
    [self.view addSubview:labelID];
    
    UILabel *labelNewEmail=[[UILabel alloc]init];
    labelNewEmail.font=labelCurrent.font;
    labelNewEmail.textColor=labelCurrent.textColor;
    labelNewEmail.frame=CGRectMake(9, labelID.frame.size.height+labelID.frame.origin.y+5, 200, labelID.frame.size.height);
    labelNewEmail.backgroundColor=[UIColor clearColor];
    labelNewEmail.text=@"New Email";
    [self.view addSubview:labelNewEmail];
    
    textEmail=[[UITextField alloc]init];
    textEmail.frame=CGRectMake(9, labelNewEmail.frame.origin.y+labelNewEmail.frame.size.height, self.view.frame.size.width-18, 25);
    textEmail.borderStyle=UITextBorderStyleNone;
    textEmail.layer.borderColor=[UIColor blackColor].CGColor;
    textEmail.layer.borderWidth=0.5;
    textEmail.backgroundColor=[UIColor clearColor];
    [self.view addSubview:textEmail];
    
    textEmailTwo=[[UITextField alloc]init];
    textEmailTwo.frame=CGRectMake(textEmail.frame.origin.x, textEmail.frame.size.height+textEmail.frame.origin.y+5, textEmail.frame.size.width, textEmail.frame.size.height);
    textEmailTwo.borderStyle=UITextBorderStyleNone;
    textEmailTwo.layer.borderColor=[UIColor blackColor].CGColor;
    textEmailTwo.layer.borderWidth=0.5;
    [self.view addSubview:textEmailTwo];
    
    UILabel *waring=[[UILabel alloc]init];
    waring.frame=CGRectMake(9, textEmailTwo.frame.size.height+textEmailTwo.frame.origin.y+10, self.view.frame.size.width-18, 20);
    waring.backgroundColor=[UIColor clearColor];
    waring.font=[UIFont systemFontOfSize:14];
    waring.textColor=[UIColor blackColor];
    waring.text=@"*Re-enter for confirmation purpose";
    [self.view addSubview:waring];
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapContent)]];

}

- (void)saveEmail
{
    if ([textEmail.text isEqualToString:textEmailTwo.text]) {
        
    }
}

@end
