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
#import "NPCellDelegate.h"
#import "NPKeyBoardView.h"
#import "NPNewListDetailViewController.h"
@interface NPTimeOnlineTableViewController ()<MJRefreshBaseViewDelegate,NPTimeOnlineCellDelegate,NPKeyBoardViewDelegate>
{
    MJRefreshHeaderView* refreshHeadView;
    MJRefreshFooterView *refreshFootView;
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
    [refreshHeadView beginRefreshing];
    
    refreshFootView=[MJRefreshFooterView footer];
    refreshFootView.scrollView=self.tableView;
    refreshFootView.delegate=self;

   
}
-(void)reloadDataForFirst
{
    [NPHTTPRequest getTimeOnLineData:nil usingSuccessBlock:^(BOOL isSuccess, NSArray *result) {
        if (isSuccess) {
            [list removeAllObjects];
            [list addObjectsFromArray:result];
            [self.tableView reloadData];
        }
        [self performSelector:@selector(reloadEnd) withObject:nil afterDelay:2];
    }] ;
    
}
-(void)reloadMoreData
{
    [NPHTTPRequest getTimeOnLineData:nil usingSuccessBlock:^(BOOL isSuccess, NSArray *result) {
        if (isSuccess) {
            [list addObjectsFromArray:result];
            [self.tableView reloadData];
        }
        [self performSelector:@selector(reloadEnd) withObject:nil afterDelay:0.5];
    }] ;
}
- (void)reloadEnd
{
    [refreshHeadView endRefreshing];
    [refreshFootView endRefreshing];
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
-(void)NPTimeOnlineCellDelegateClickReply:(NPTimeOnlineCell *)cell
{
    [NPKeyBoardView share].delegate =self;
    [[NPKeyBoardView share].textView becomeFirstResponder];
}
-(void)NPloadMoreViewRefresh
{
    [self performSelector:@selector(reloadMoreData) withObject:nil afterDelay:0.3];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return list.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [NPTimeOnlineCell cellHigth:[list objectAtIndex:indexPath.row]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"timeOnLineCell";
    NPTimeOnlineCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[NPTimeOnlineCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.backgroundView=[[UIView alloc]init];
        cell.backgroundView.backgroundColor=[UIColor lightGrayColor];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.delegate=self;
    }
    NPListModel *model=[list objectAtIndex:indexPath.row];
    [cell restCell:model];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NPNewListDetailViewController *listDetail=[[NPNewListDetailViewController alloc] init];
    listDetail.listModel=[list objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:listDetail animated:YES];
}


@end
