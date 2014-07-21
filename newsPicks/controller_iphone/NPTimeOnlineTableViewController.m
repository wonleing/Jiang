//
//  NPTimeOnlineTableViewController.m
//  newsPicks
//
//  Created by yunqi on 14-7-21.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "NPTimeOnlineTableViewController.h"
#import "MJRefresh.h"
#import "NPListModel.h"
#import "NPTimeOnlineCell.h"
@interface NPTimeOnlineTableViewController ()<MJRefreshBaseViewDelegate>
{
    MJRefreshHeaderView* refreshHeadView;
    NSMutableArray *list;
}
@end

@implementation NPTimeOnlineTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    list=[[NSMutableArray alloc]init];
    [super viewDidLoad];
     self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    refreshHeadView = [MJRefreshHeaderView header];
    refreshHeadView.scrollView = self.tableView;
    refreshHeadView.delegate = self;
    
    
}
-(void)reloadDataForFirst
{
    [self performSelector:@selector(reloadEnd) withObject:nil afterDelay:2];

}
-(void)reloadMoreData
{
    [self performSelector:@selector(reloadEnd) withObject:nil afterDelay:2];
}
- (void)reloadEnd
{
    [refreshHeadView endRefreshing];
}
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (refreshHeadView == refreshView) { // 下拉刷新
        [self performSelector:@selector(reloadDataForFirst) withObject:nil afterDelay:0.3];
    }else
    {
        [self performSelector:@selector(reloadMoreData) withObject:nil afterDelay:0.3];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return list.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [NPTimeOnlineCell cellHigth:[list objectAtIndex:indexPath.row]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"timeOnLineCell";
    NPTimeOnlineCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    if (!cell) {
        cell=[[NPTimeOnlineCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
//     Configure the cell...
    
    return cell;
}


@end
