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
#import "NPListModel.h"
#import "UIViewController+MJPopupViewController.h"
#import "NPTextInputViewController.h"
@interface NPTopTableViewController ()<MJRefreshBaseViewDelegate,NPKeyBoardViewDelegate,NPTimeOnlineCellDelegate>

{
    MJRefreshHeaderView *refreshHeadView;
    NSMutableArray* list;
    NPlistPopularUsers *popularUsers;
    NPKeyBoardView *keyBoard;
    
    int currentPage;
}
@property (strong, nonatomic)NPTextInputViewController *textInputviewController;

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
    
    currentPage=1;
    list=[[NSMutableArray alloc]init];
    [super viewDidLoad];
    self.tableView.backgroundColor=[UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundView=[[UIView alloc]init];
    self.tableView.backgroundView.backgroundColor=NP_MAIN_BACKGROUND_COLOR;
    refreshHeadView = [MJRefreshHeaderView header];
    refreshHeadView.scrollView = self.tableView;
    refreshHeadView.delegate = self;
    [refreshHeadView beginRefreshing];
    
    
}
-(void)reloadDataForFirst
{
    [NPHTTPRequest getTopData:1 usingSuccessBlock:^(BOOL isSuccess, NSArray *result, NPlistPopularUsers *popularUser) {
        if (isSuccess) {
            popularUsers=popularUser;
            currentPage=1;
            [list removeAllObjects];
            [list addObjectsFromArray:result];
            [self.tableView reloadData];
        }
        [self performSelector:@selector(reloadEnd) withObject:nil afterDelay:2];
        
    }];
}
-(void)reloadMoreData
{
    [NPHTTPRequest getTopData:currentPage+1 usingSuccessBlock:^(BOOL isSuccess, NSArray *result, NPlistPopularUsers *popularUser) {
        if (isSuccess) {
            popularUsers=popularUser;
            
            [list addObjectsFromArray:result];
            currentPage++;
            [self.tableView reloadData];
        }
        [self performSelector:@selector(reloadEnd) withObject:nil afterDelay:0.5];
    }] ;}
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
-(void)NPTimeOnlineCellDelegateClickReply:(NPTimeOnlineCell *)cell
{
    //    [NPKeyBoardView share].delegate =self;
    //    [[NPKeyBoardView share] show];
    
    self.textInputviewController = [[NPTextInputViewController alloc]initWithNibName:@"NPTextInputViewController" bundle:nil];
    self.textInputviewController.tid=cell.model.listID;
    self.textInputviewController.mTitle=cell.model.title;
    [self presentPopupViewController:self.textInputviewController animationType:MJPopupViewAnimationSlideBottomTop];
    
}
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
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=NP_MAIN_BACKGROUND_COLOR;
        cell.delegate=self;
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
        detailController.type=NPListType_top;
        [self.navigationController pushViewController:detailController animated:YES];
    }
}


@end
