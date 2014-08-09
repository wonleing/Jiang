
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
#import "SVProgressHUD.h"
#import "NPListModel.h"
#import "UIViewController+MJPopupViewController.h"
#import "NPTextInputViewController.h"

@interface NPTimeOnlineTableViewController ()<MJRefreshBaseViewDelegate,NPTimeOnlineCellDelegate,NPKeyBoardViewDelegate>
{
    MJRefreshHeaderView* refreshHeadView;
    MJRefreshFooterView *refreshFootView;
    NSMutableArray *list;

    NSString *_uid;
    int currentPage;
}
@property (strong, nonatomic)NPTextInputViewController *textInputviewController;

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
    self.tableView.backgroundView=[[UIView alloc]init];
    self.tableView.backgroundView.backgroundColor=NP_MAIN_BACKGROUND_COLOR;
    refreshHeadView = [MJRefreshHeaderView header];
    refreshHeadView.scrollView = self.tableView;
    refreshHeadView.delegate = self;
    
    refreshFootView=[MJRefreshFooterView footer];
    refreshFootView.scrollView=self.tableView;
    refreshFootView.delegate=self;

    currentPage=1;
    [self reFresh];
}
-(void)viewDidAppear:(BOOL)animated{
//    [self reFresh];
    [super viewDidAppear:animated];
}
-(void)reFresh{
    _uid = [[NSUserDefaults standardUserDefaults]objectForKey:@"com.zhangcheng.uid"];
    [refreshHeadView beginRefreshing];

}
-(void)reloadDataForFirst
{
    [NPHTTPRequest getTimeOnLineData:_uid page:1 usingSuccessBlock:^(BOOL isSuccess, NSArray *result) {
        if (isSuccess) {
            [list removeAllObjects];
            [list addObjectsFromArray:result];
            [self.tableView reloadData];
            currentPage=1;
        }
        [self performSelector:@selector(reloadEnd) withObject:nil afterDelay:2];
    }] ;
    
}
-(void)reloadMoreData
{
    [NPHTTPRequest getTimeOnLineData:_uid page:currentPage+1 usingSuccessBlock:^(BOOL isSuccess, NSArray *result) {
        if (isSuccess) {
            [list addObjectsFromArray:result];
            currentPage++;
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
//    [NPKeyBoardView share].delegate =self;
//    [[NPKeyBoardView share] show];
    
    self.textInputviewController= [[NPTextInputViewController alloc]initWithNibName:@"NPTextInputViewController" bundle:nil];
    self.textInputviewController.tid=cell.model.listID;
    self.textInputviewController.mTitle=cell.model.title;
    [self presentPopupViewController:self.textInputviewController animationType:MJPopupViewAnimationSlideBottomTop];

}
-(void)keyBoardViewHide:(NPKeyBoardView *)keyBoardView textView:(UITextView *)contentView{
    
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
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=NP_MAIN_BACKGROUND_COLOR;
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
    listDetail.type=NPListType_online;

    [self.navigationController pushViewController:listDetail animated:YES];
}


@end
