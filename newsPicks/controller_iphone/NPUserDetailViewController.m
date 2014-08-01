//
//  NPUserDetailViewController.m
//  newsPicks
//
//  Created by yunqi on 14-7-23.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "NPUserDetailViewController.h"
#import "MJRefresh.h"
#import "NPUserInfoDetailHeadView.h"
#import "NPTimeOnlineCell.h"
#import  "NPUserDetaiInfolModel.h"
#import "NPAlertView.h"
#import "NPNewListDetailViewController.h"
#import "NPCheckFollowingAndFollowersController.h"
@interface NPUserDetailViewController ()<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate,NPUserInfoDetailHeadViewDelegate>
{
    MJRefreshHeaderView* refreshHeadView;
    MJRefreshFooterView *refreshFootView;
    NPUserInfoDetailHeadView *infoDetailHeadView;
    NPUserDetaiInfolModel *userInfoModel;
    NSMutableArray *list;
    UITableView *mTableView;
    
    int currentPage;
}
@end

@implementation NPUserDetailViewController
@synthesize uid=_uid;
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
    currentPage=1;
    list=[[NSMutableArray array]init];
    mTableView=[[UITableView alloc]init];
    mTableView.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44);
    mTableView.separatorColor=[UIColor clearColor];
    mTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    mTableView.backgroundView=[[UIView alloc] init];
    mTableView.backgroundView.backgroundColor=NP_MAIN_BACKGROUND_COLOR;
    mTableView.delegate=self;
    mTableView.dataSource=self;
    [self.view addSubview:mTableView];
    
    refreshHeadView = [MJRefreshHeaderView header];
    refreshHeadView.scrollView = mTableView;
    refreshHeadView.delegate = self;
    
    refreshFootView=[MJRefreshFooterView footer];
    refreshFootView.scrollView=mTableView;
    refreshFootView.delegate=self;
    
    
    infoDetailHeadView=[NPUserInfoDetailHeadView userInfoDetailHeadView];
    infoDetailHeadView.delegate=self;
    infoDetailHeadView.detailView.backgroundColor=[UIColor clearColor];
    infoDetailHeadView.backgroundColor=[UIColor clearColor];
    mTableView.tableHeaderView=infoDetailHeadView;
    mTableView.tableHeaderView.frame=CGRectMake(0, 0, infoDetailHeadView.frame.size.width, infoDetailHeadView.frame.size.height);
    [super viewDidLoad];
    [self performSelector:@selector(loadInfoData) withObject:nil afterDelay:0.8];
    [self performSelector:@selector(reloadDataForFirst) withObject:nil afterDelay:1];
    // Do any additional setup after loading the view.
}
-(void)loadInfoData
{
    [NPHTTPRequest getUserInfo:self.uid usingSuccessBlock:^(BOOL isSuccess, NPUserDetaiInfolModel *result) {
        userInfoModel=result;
        [infoDetailHeadView restValue:userInfoModel];
    }];
}
-(void)reloadDataForFirst
{
    [NPHTTPRequest getTimeOnLineData:self.uid page:1 usingSuccessBlock:^(BOOL isSuccess, NSArray *result) {
        if (isSuccess) {
            currentPage=1;
            [list removeAllObjects];
            [list addObjectsFromArray:result];
            [mTableView reloadData];
        }
        [self performSelector:@selector(reloadEnd) withObject:nil afterDelay:2];
    }] ;
    
}
-(void)reloadMoreData
{
    [NPHTTPRequest getTimeOnLineData:self.uid page:currentPage+1 usingSuccessBlock:^(BOOL isSuccess, NSArray *result) {
        if (isSuccess) {
            currentPage++;
            [list addObjectsFromArray:result];
            [mTableView reloadData];
        }
        [self performSelector:@selector(reloadEnd) withObject:nil afterDelay:0.5];
    }] ;
}
-(void)reloadEnd
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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return list.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [NPTimeOnlineCell cellHigth:[list objectAtIndex:indexPath.row]];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"detailCell";
    NPTimeOnlineCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[NPTimeOnlineCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=NP_MAIN_BACKGROUND_COLOR;
    }
    [cell restCell:[list objectAtIndex:indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NPNewListDetailViewController *listDetail=[[NPNewListDetailViewController alloc] init];
    listDetail.listModel=[list objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:listDetail animated:YES];
}
-(void)NPUserInfoDetailHeadViewCheckFollowing
{
    NPCheckFollowingAndFollowersController *check=[[NPCheckFollowingAndFollowersController alloc]init];
    check.type=NPCheckFollow_following;
    [self.navigationController pushViewController:check animated:YES];
}
-(void)NPUserInfoDetailHeadViewCheckFollowers
{
    NPCheckFollowingAndFollowersController *check=[[NPCheckFollowingAndFollowersController alloc]init];
    check.type=NPCheckFollow_followers;
    [self.navigationController pushViewController:check animated:YES];
}
-(void)change
{
    [infoDetailHeadView changeFollowStatus:userInfoModel.is_following.boolValue];
}
-(void)NPUserInfoDetailHeadViewClickFollow
{
    if (userInfoModel.is_following.boolValue) {
        userInfoModel.is_following=@"0";
        infoDetailHeadView.followingBtn.highlighted=YES;
        [infoDetailHeadView.followingBtn performSelector:@selector(setHighlighted:) withObject:NO afterDelay:1.0];
        [self performSelector:@selector(change) withObject:nil afterDelay:1.0];
    }else
    {
        if ([NPAlertView showAlert:@"Confirm" message:@"Do you want to unfollow this user/robot?" cancle:@"Cancel" other:@"OK"]==1) {
            userInfoModel.is_following=@"1";
            infoDetailHeadView.followingBtn.highlighted=YES;
            [infoDetailHeadView.followingBtn performSelector:@selector(setHighlighted:) withObject:NO afterDelay:1.0];
            [self performSelector:@selector(change) withObject:nil afterDelay:1.0];

        }
    }
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
