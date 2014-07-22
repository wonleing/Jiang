//
//  NPNewListDetailViewController.m
//  newsPicks
//
//  Created by yunqi on 14-7-22.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "NPNewListDetailViewController.h"
#import "NPListModel.h"
#import "NPNewListDetailHeadView.h"
@interface NPNewListDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *mTableView;
}
@end

@implementation NPNewListDetailViewController
@synthesize listModel=_listModel;
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
    mTableView=[[UITableView alloc] init];
    mTableView.separatorColor=[UIColor clearColor];
    mTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    mTableView.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44);
    mTableView.backgroundColor=[UIColor clearColor];
    mTableView.delegate=self;
    mTableView.dataSource=self;
    [self.view addSubview:mTableView];
    
    NPNewListDetailHeadView *headView=[[NPNewListDetailHeadView alloc] init];
    [headView restSubView:self.listModel];
    mTableView.tableHeaderView=headView ;
    mTableView.tableHeaderView.frame=CGRectMake(0, 0, headView.frame.size.width, headView.frame.size.height);
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger count=0;
    if (self.listModel.replyModel) {
        count+=1;
    }
    return count;
}
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 0;
}
-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] init];
    view.frame=CGRectMake(0, 0, self.view.frame.size.width, 25);
    view.backgroundColor=[UIColor lightGrayColor];
    UIView *line=[[UIView alloc] init];
    line.frame=CGRectMake(0, 0, view.frame.size.width, 1);
    line.backgroundColor=[UIColor grayColor];
    [view addSubview:line];
    UILabel*title =[[UILabel alloc] init];
    title.frame=CGRectMake(5, 0, view.frame.size.width-5, view.frame.size.height);
    title.font=[UIFont boldSystemFontOfSize:15];
    title.textColor=[UIColor grayColor];
    title.text=@"Following Users";
    title.backgroundColor=[UIColor clearColor];
    [view addSubview:title];
    return view;
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
