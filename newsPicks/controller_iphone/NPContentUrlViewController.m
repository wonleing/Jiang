//
//  NPContentUrlViewController.m
//  newsPicks
//
//  Created by yunqi on 14-7-28.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "NPContentUrlViewController.h"

@interface NPContentUrlViewController ()

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
    [self.view addSubview:label];
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
