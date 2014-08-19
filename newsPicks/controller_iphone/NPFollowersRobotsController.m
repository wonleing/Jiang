//
//  NPFollowersRobotsController.m
//  newsPicks
//
//  Created by yunqi on 14-7-28.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "NPFollowersRobotsController.h"
#import  "NPFollowCell.h"
#import "NPUserDetaiInfolModel.h"
#import "NPUserDetailViewController.h"
#import "SVProgressHUD.h"
@interface NPFollowersRobotsController ()<UITableViewDataSource,UITableViewDelegate,NPFollowCellDelegate>
{
    UITabBar *tabBar;
    UITableView *mTableView;
    NSMutableArray *list;
    
    NSString *_uid;
    int currentPage;
}
@end

@implementation NPFollowersRobotsController

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
    NSLog(@"%@",NSStringFromCGRect(self.view.frame));
    _uid = [[NSUserDefaults standardUserDefaults]objectForKey:@"com.zhangcheng.uid"];
    currentPage=0;
    
    list=[[NSMutableArray alloc]init];
    tabBar=[[UITabBar alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-49-44, self.view.frame.size.width, 49)];
    UITabBarItem *Featured=[[UITabBarItem alloc]init];
    Featured.title=@"Featured";
    
    UITabBarItem *Ranking=[[UITabBarItem alloc]init];
    Ranking.title=@"Ranking";
    
    UITabBarItem *Robots=[[UITabBarItem alloc]init];
    Robots.title=@"Robots";
    tabBar.items=[NSArray arrayWithObjects:Featured,Ranking,Robots, nil];
    [self.view addSubview:tabBar];
    
    mTableView=[[UITableView alloc]init];
    mTableView.frame=CGRectMake(0, 0, self.view.frame.size.width, tabBar.frame.origin.y);
    mTableView.backgroundColor=[UIColor clearColor];
    mTableView.separatorColor=[UIColor clearColor];
    mTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    mTableView.delegate=self;
    mTableView.dataSource=self;
    [self.view addSubview:mTableView];

    [super viewDidLoad];

    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadMore];

}
-(void)loadMore
{
    [NPHTTPRequest getRecommandUser:_uid page:1 usingSuccessBlock:^(BOOL isSuccess, NSArray *result) {
        if (isSuccess) {
//            currentPage++;
            [list removeAllObjects];
            [list addObjectsFromArray:result];
            [mTableView reloadData];
        }
    }];
//    [NPHTTPRequest getUserInfoFollowing:YES uid:_uid page:currentPage+1 usingSuccessBlock:^(BOOL isSuccess, NSArray *result) {
//        if (isSuccess) {
//            currentPage++;
//            [list addObjectsFromArray:result];
//            [mTableView reloadData];
//        }
//    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return list.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [NPFollowCell cellHight];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"checkID";
    NPFollowCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[NPFollowCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle=UITableViewCellSelectionStyleGray;
        cell.delegate=self;
    }
    [cell restSubView:[list objectAtIndex:indexPath.row]];
    return cell;
}
-(void)NPFollowCellClickFollowing:(NPFollowCell *)cell
{
    NPUserDetaiInfolModel *infoModel=[list objectAtIndex:[mTableView indexPathForCell:cell].row];
    if (infoModel.is_following.boolValue) {
        infoModel.is_following=@"0";
        [NPHTTPRequest getUnfollowUser:_uid targetUser:infoModel.uid usingSuccessBlock:^(BOOL isSuccess, NSDictionary *dic) {
            if(isSuccess){
                
            }else{
                [SVProgressHUD showErrorWithStatus:dic[@"message"]];
            }
        }];
    }else
    {
        infoModel.is_following=@"1";
        [NPHTTPRequest getFollowUser:_uid targetUser:infoModel.uid usingSuccessBlock:^(BOOL isSuccess, NSDictionary *dic) {
            if(isSuccess){
                
            }else{
                [SVProgressHUD showErrorWithStatus:dic[@"message"]];
            }
        }];
    }
    [mTableView reloadData];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NPUserDetaiInfolModel *infoModel=[list objectAtIndex:indexPath.row];
    NPUserDetailViewController *userController=[[NPUserDetailViewController alloc]init];
    userController.uid=infoModel.uid;
    userController.title=infoModel.name;
    [self.navigationController pushViewController:userController animated:YES];
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
