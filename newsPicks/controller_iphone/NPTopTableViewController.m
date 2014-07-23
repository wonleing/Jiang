//
//  NPTopTableViewController.m
//  newsPicks
//
//  Created by yunqi on 14-7-21.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "NPTopTableViewController.h"
#import "MJRefresh.h"
#import "NPTimeOnlineCell.h"
#import "NPKeyBoardView.h"
#import "NPlistPopularUsers.h"
#import "NPNewListDetailViewController.h"
@interface NPTopTableViewController ()<MJRefreshBaseViewDelegate,NPKeyBoardViewDelegate>

{
    MJRefreshHeaderView *refreshHeadView;
    NSMutableArray* list;
    NPlistPopularUsers *popularUsers;
    NPKeyBoardView *keyBoard;
}
@end

@implementation NPTopTableViewController

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
    [super viewDidLoad];
    list=[[NSMutableArray alloc]init];
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    refreshHeadView = [MJRefreshHeaderView header];
    refreshHeadView.scrollView = self.tableView;
    refreshHeadView.delegate = self;
    [refreshHeadView beginRefreshing];
}
-(void)reloadDataForFirst
{
    [NPHTTPRequest getTopData:nil usingSuccessBlock:^(BOOL isSuccess, NSArray *result, NPlistPopularUsers *popularUser) {
        if (isSuccess) {
            popularUsers=popularUser;
            [list removeAllObjects];
            [list addObjectsFromArray:result];
            [self.tableView reloadData];
        }
        [self performSelector:@selector(reloadEnd) withObject:nil afterDelay:2];

    }];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return list.count+(popularUsers?1:0);
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==list.count) {
        return NPTimeOnlineCell_topPlace*2+NPTimeOnlineCell_PopularUser_Higth;
    }
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
    }
    //    cell
    
    if (indexPath.row==list.count) {
        [cell restPopularUsers:popularUsers];
    }else
    {
    NPListModel *model=[list objectAtIndex:indexPath.row];
    [cell restCell:model];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (list.count>indexPath.row) {
    NPNewListDetailViewController *detailController=[[NPNewListDetailViewController alloc]init];
    detailController.listModel=[list objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailController animated:YES];
    }
}


@end
