
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
#import "UIViewController+MJPopupViewController.h"
#import "NPTextInputViewController.h"
#import "SVProgressHUD.h"
#import "NPListModel.h"
@interface NPUserDetailViewController ()<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate,NPUserInfoDetailHeadViewDelegate,NPTimeOnlineCellDelegate>
{
    MJRefreshHeaderView* refreshHeadView;
    MJRefreshFooterView *refreshFootView;
    NPUserInfoDetailHeadView *infoDetailHeadView;
    NSMutableArray *list;
    UITableView *mTableView;
    NSString *m_uid;

    int currentPage;
}
@property (strong, nonatomic)NPTextInputViewController *textInputviewController;
@property (strong, nonatomic)NPUserDetaiInfolModel *userInfoModel;

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
-(void)viewWillAppear:(BOOL)animated
{

    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    self.navigationController.view.frame = CGRectMake(0, 0, 320, self.view.frame.size.height);
//    self.view.frame = CGRectMake(0, 0, 320, self.view.frame.size.height);
}

- (void)viewDidLoad
{
    currentPage=1;
    m_uid = [[NSUserDefaults standardUserDefaults]objectForKey:@"com.zhangcheng.uid"];

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
    [self performSelector:@selector(loadInfoData) withObject:nil afterDelay:0.1];
    [self performSelector:@selector(loadGetRalation) withObject:nil afterDelay:0.9];

    [self performSelector:@selector(reloadDataForFirst) withObject:nil afterDelay:1];
    // Do any additional setup after loading the view.
}
-(void)loadInfoData
{
    [NPHTTPRequest getUserInfo:self.uid usingSuccessBlock:^(BOOL isSuccess, NPUserDetaiInfolModel *result) {
        self.userInfoModel=result;
        NSLog(@"%@",self.userInfoModel.uid);
        [infoDetailHeadView restValue:self.userInfoModel];
    }];
}
-(void)loadGetRalation{
    [NPHTTPRequest getRelation:m_uid targetUser:self.uid usingSuccessBlock:^(BOOL isSuccess, NSDictionary *dic) {
        if (isSuccess) {
            self.userInfoModel.is_following=[NSString stringWithFormat:@"%d",((NSNumber*)dic[@"isfollower"]).intValue];
            self.userInfoModel.followers_num=[NSString stringWithFormat:@"%d",((NSNumber*)dic[@"follower"]).intValue];
            self.userInfoModel.following_num=[NSString stringWithFormat:@"%d",((NSNumber*)dic[@"following"]).intValue];
            [infoDetailHeadView restValue:self.userInfoModel];
        }
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
        cell.delegate=self;
    }
    [cell restCell:[list objectAtIndex:indexPath.row]];
    return cell;
}
-(void)NPTimeOnlineCellDelegateClickReply:(NPTimeOnlineCell *)cell
{
    //    [NPKeyBoardView share].delegate =self;
    //    [[NPKeyBoardView share] show];
    
    self.textInputviewController= [[NPTextInputViewController alloc]initWithNibName:@"NPTextInputViewController" bundle:nil];
    self.textInputviewController.tid=cell.model.listID;
    self.textInputviewController.mTitle=cell.model.title;
    [self presentPopupViewController:self.textInputviewController animationType:MJPopupViewAnimationSlideBottomTop];
    
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
    check.uid=self.userInfoModel.uid;

    [self.navigationController pushViewController:check animated:YES];
}
-(void)NPUserInfoDetailHeadViewCheckFollowers
{
    NPCheckFollowingAndFollowersController *check=[[NPCheckFollowingAndFollowersController alloc]init];
    check.type=NPCheckFollow_followers;
    check.uid=self.userInfoModel.uid;
    [self.navigationController pushViewController:check animated:YES];
}
-(void)change
{
    [infoDetailHeadView changeFollowStatus:[self.userInfoModel.is_following isEqualToString:@"1"]];
}
-(void)NPUserInfoDetailHeadViewClickFollow
{
    if ([self.userInfoModel.is_following isEqualToString:@"0"]) {
        [NPHTTPRequest getFollowUser:m_uid targetUser:self.uid usingSuccessBlock:^(BOOL isSuccess, NSDictionary *dic) {
            if(isSuccess){
                self.userInfoModel.is_following=@"1";
//                infoDetailHeadView.followingBtn.highlighted=YES;
//                [infoDetailHeadView.followingBtn performSelector:@selector(setHighlighted:) withObject:NO afterDelay:1.0];
                //[self performSelector:@selector(change) withObject:nil afterDelay:1.0];
                [self change];
            }else{
                [SVProgressHUD showErrorWithStatus:dic[@"message"]];
            }
        }];
        
    }else
    {
        if ([NPAlertView showAlert:@"Confirm" message:@"Do you want to unfollow this user/robot?" cancle:@"Cancel" other:@"OK"]==1) {
            [NPHTTPRequest getUnfollowUser:m_uid targetUser:self.uid usingSuccessBlock:^(BOOL isSuccess, NSDictionary *dic) {
                if(isSuccess){
                    self.userInfoModel.is_following=@"0";
//                    infoDetailHeadView.followingBtn.highlighted=YES;
//                    [infoDetailHeadView.followingBtn performSelector:@selector(setHighlighted:) withObject:NO afterDelay:1.0];
//                    [self performSelector:@selector(change) withObject:nil afterDelay:1.0];
                    [self change];
                }else{
                    [SVProgressHUD showErrorWithStatus:dic[@"message"]];
                }
            }];
            

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
