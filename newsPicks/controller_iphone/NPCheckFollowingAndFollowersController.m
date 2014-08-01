//
//  NPCheckFollowingAndFollowersController.m
//  newsPicks
//
//  Created by yunqi on 14-7-25.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "NPCheckFollowingAndFollowersController.h"
#import "MJRefresh.h"
#import "NPFollowCell.h"
#import "NPUserDetaiInfolModel.h"
#import "NPUserDetailViewController.h"
@interface NPCheckFollowingAndFollowersController ()<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate,NPFollowCellDelegate>
{
    UITabBar *tabBar;
    UITableView *mTableView;
    MJRefreshFooterView* refreshFoot;
    NSMutableArray *list;
}
@end

@implementation NPCheckFollowingAndFollowersController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
+(UIImage *)getImageFromView:(UIView *)view{
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
-(UIImage *)itemImage:(NSString *)content color:(UIColor *)color
{
    UIView *view=[[UIView alloc] init];
    view.frame=CGRectMake(0, 0, self.view.frame.size.width/2, 40);
    view.backgroundColor=[UIColor clearColor];
    UILabel *label=[[UILabel alloc]init];
    label.frame=CGRectMake(0, 5, view.frame.size.width, 30);
    label.backgroundColor=[UIColor clearColor];
    label.textAlignment=NSTextAlignmentCenter;
    label.text=content;
    label.font=[UIFont boldSystemFontOfSize:20];
    label.textColor=color ;
    [view addSubview:label];
    return   [self.class getImageFromView:view];
}
-(void)restFollowCount
{
    [[tabBar.items objectAtIndex:0]  setFinishedSelectedImage:[self itemImage:@"1000" color:[UIColor whiteColor]] withFinishedUnselectedImage:[self itemImage:@"1000" color:[UIColor lightGrayColor]]];
    [[tabBar.items objectAtIndex:1]  setFinishedSelectedImage:[self itemImage:@"1030" color:[UIColor whiteColor]] withFinishedUnselectedImage:[self itemImage:@"1030" color:[UIColor lightGrayColor]]];
}
- (void)viewDidLoad
{
    list=[[NSMutableArray alloc]init];
    tabBar=[[UITabBar alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-49-44, self.view.frame.size.width, 49)];
    UITabBarItem *following=[[UITabBarItem alloc]init];
    following.title=@"Following";
    
    UITabBarItem *followers=[[UITabBarItem alloc]init];
    followers.title=@"Follower";
    tabBar.items=[NSArray arrayWithObjects:following,followers, nil];
    [self.view addSubview:tabBar];
    
    mTableView=[[UITableView alloc]init];
    mTableView.frame=CGRectMake(0, 0, self.view.frame.size.width, tabBar.frame.origin.y);
    mTableView.backgroundColor=[UIColor clearColor];
    mTableView.separatorColor=[UIColor clearColor];
    mTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    mTableView.delegate=self;
    mTableView.dataSource=self;
    [self.view addSubview:mTableView];
    refreshFoot=[MJRefreshFooterView  footer];
    refreshFoot.scrollView=mTableView;
    refreshFoot.delegate=self;
    if (self.type==NPCheckFollow_followers) {
        tabBar.selectedItem=followers;
    }else
    {
        tabBar.selectedItem=following;

    }
    [self restFollowCount];
    [self loadMore];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)loadMore
{
//
//    [NPHTTPRequest getUserInfoFollowing:nil usingSuccessBlock:^(BOOL isSuccess, NSArray *result) {
//        if (isSuccess) {
//            [list addObjectsFromArray:result];
//            [mTableView reloadData];
//            [self performSelector:@selector(endLoad) withObject:nil afterDelay:0.3];
//        }
//    }];
}
-(void)endLoad
{
    [refreshFoot endRefreshing];
}
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    [self performSelector:@selector(loadMore) withObject:nil afterDelay:0.7];
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
    }else
    {
        infoModel.is_following=@"1";
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
