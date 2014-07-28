//
//  NPContentUrlViewController.m
//  newsPicks
//
//  Created by yunqi on 14-7-28.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "NPContentUrlViewController.h"

@interface NPContentUrlViewController ()<UITextFieldDelegate>
{
    UITextField *textField;
}
@end

@implementation NPContentUrlViewController

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
    self.view.backgroundColor=[UIColor whiteColor];
    UILabel *label=[[UILabel alloc]init];
    label.font=[UIFont systemFontOfSize:13.5];
    label.frame=CGRectMake(0, 5, self.view.frame.size.width , 20);
    label.textAlignment=NSTextAlignmentCenter ;
    label.textColor=[UIColor blackColor];
    label.text=@"Enter the URL of the countent you want to add";
    UILabel *labelUrl=[[UILabel alloc]init];
    labelUrl.frame=CGRectMake(9, label.frame.origin.y+label.frame.size.height+3, 45, 25);
    labelUrl.backgroundColor=[UIColor colorWithRed:73.0f/255.0f green:100.0f/255.0f blue:198.0f/255.0f alpha:1];
    labelUrl.font=[UIFont systemFontOfSize:14];
    labelUrl.textColor=[UIColor whiteColor];
    labelUrl.text=@"URL";
    labelUrl.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:labelUrl];
    [self.view addSubview:label];
    
    textField=[[UITextField alloc]init];
    textField.frame=CGRectMake(labelUrl.frame.size.width+labelUrl.frame.origin.x+3, labelUrl.frame.origin.y,self.view.frame.size.width-labelUrl.frame.origin.x-labelUrl.frame.size.width-3-9, labelUrl.frame.size.height);
    textField.borderStyle=UITextBorderStyleNone;
    textField.returnKeyType=UIReturnKeyDone;
    textField.layer.masksToBounds=YES;
    textField.layer.borderColor=[UIColor blackColor].CGColor;
    textField.layer.borderWidth=0.7;
    textField.delegate=self;
    [self.view addSubview:textField];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

@end
