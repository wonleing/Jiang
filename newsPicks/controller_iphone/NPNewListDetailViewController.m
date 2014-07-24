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
#import "NPNewListDetailCell.h"
#import "NPNewListDetailFootLoadView.h"
#import "NPNewListDetailFootReplysView.h"
#import "NPUserDetailViewController.h"
@interface NPNewListDetailViewController ()<UITableViewDataSource,UITableViewDelegate,NPNewListDetailCellDelegate,NPNewListDetailFootReplysViewDelegate,UIActionSheetDelegate>
{
    UITableView *mTableView;
    NSMutableDictionary *mDicData;
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
    mDicData=[[NSMutableDictionary alloc]initWithCapacity:0];
    
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
    
    NPNewListDetailFootLoadView *footLoad=[[NPNewListDetailFootLoadView alloc]init];
    footLoad.frame=CGRectMake(0, 0, self.view.frame.size.width, 100);
    footLoad.backgroundColor=[UIColor clearColor];
    [footLoad.activityIndicatorView startAnimating];
    mTableView.tableFooterView=footLoad;
    mTableView.tableFooterView.frame=CGRectMake(0, 0, footLoad.frame.size.width, footLoad.frame.size.height);
    
    
    [super viewDidLoad];
    if (self.listModel.type==NPListType_online&&self.listModel.replyModel) {
        [mDicData setObject:[NSArray arrayWithObject:self.listModel.replyModel] forKey:kNPNewListTitleKey_Followings];
        [mTableView reloadData];
    }
    if (self.listModel.type==NPListType_top&&self.listModel.replyModel) {
        [mDicData setObject:[NSArray arrayWithObject:self.listModel.replyModel] forKey:kNPNewListTitleKey_Srending_comment];
        [mTableView reloadData];
    }
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.5];
   
    // Do any additional setup after loading the view.
}
-(void)loadData
{
    if (self.listModel.type==NPListType_online) {
        [NPHTTPRequest getTimeOnLineDetail:@"" usingSuccessBlock:^(BOOL isSuccess, NSArray *followings, NSArray *others, NSArray *replyHeadImageList) {
            [self endLoadView];
            if (isSuccess) {
                if (followings.count) {
                    NSMutableArray *follow=[NSMutableArray array];
                    if ([mDicData objectForKey:kNPNewListTitleKey_Followings]) {
                        [follow addObjectsFromArray:[mDicData objectForKey:kNPNewListTitleKey_Followings]];
                    }
                    [follow addObjectsFromArray:followings];
                    [mDicData setObject:follow forKey:kNPNewListTitleKey_Followings];
                }
                
                if (others.count) {
                    [mDicData setObject:others forKey:kNPNewListTitleKey_Others];
                }
                
                [mTableView reloadData];
                NPNewListDetailFootReplysView *replyListView=[[NPNewListDetailFootReplysView alloc]init];
                [replyListView restSubView:replyHeadImageList count:@"88"];
                replyListView.delegate=self;
                mTableView.tableFooterView=replyListView;
            }
            
        }];
    }
    if (self.listModel.type==NPListType_top) {
        [NPHTTPRequest getTopDetail:nil usingSuccessBlock:^(BOOL isSuccess, NSArray *TrendingComment, NSArray *followings, NSArray *others, NSArray *replyHeadImageList) {
            [self endLoadView];
            if (isSuccess) {
                if (TrendingComment.count) {
                    NSMutableArray *follow=[NSMutableArray array];
                    if ([mDicData objectForKey:kNPNewListTitleKey_Srending_comment]) {
                        [follow addObjectsFromArray:[mDicData objectForKey:kNPNewListTitleKey_Srending_comment]];
                    }
                    [follow addObjectsFromArray:TrendingComment];
                    [mDicData setObject:follow forKey:kNPNewListTitleKey_Srending_comment];
                }
               
                
                if (followings.count) {
                    [mDicData setObject:followings forKey:kNPNewListTitleKey_Followings];
                }
                if (others.count) {
                     [mDicData setObject:others forKey:kNPNewListTitleKey_Others];
                }
               
                
                
                [mTableView reloadData];
                NPNewListDetailFootReplysView *replyListView=[[NPNewListDetailFootReplysView alloc]init];
                [replyListView restSubView:replyHeadImageList count:@"28"];
                replyListView.delegate=self;
                mTableView.tableFooterView=replyListView;
            }
        }];
    }
    
}
-(void)endLoadView
{
     mTableView.tableFooterView=nil;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *allKeys = [NPCustomMethod sortNewsListKey:mDicData];
    NSString *key = [allKeys objectAtIndex:section];
    NSArray *value = [mDicData valueForKey:key];
    return [value count];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return mDicData.allKeys.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *allKeys = [NPCustomMethod sortNewsListKey:mDicData];
    NSString *key = [allKeys objectAtIndex:indexPath.section];
    NSArray *value = [mDicData valueForKey:key];
    return [NPNewListDetailCell cellHigth:[value objectAtIndex:indexPath.row]];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    NSArray *allKeys = [NPCustomMethod sortNewsListKey:mDicData];;
    NSString *key = [allKeys objectAtIndex:section];
    
    UIView *view=[[UIView alloc] init];
    view.frame=CGRectMake(0, 0, self.view.frame.size.width, 25);
    view.backgroundColor=NP_MAIN_BACKGROUND_COLOR;
    UIView *line=[[UIView alloc] init];
    line.frame=CGRectMake(0, 0, view.frame.size.width, 1);
    line.backgroundColor=[UIColor grayColor];
    [view addSubview:line];
    UILabel*title =[[UILabel alloc] init];
    title.frame=CGRectMake(5, 0, view.frame.size.width-5, view.frame.size.height);
    title.font=[UIFont boldSystemFontOfSize:15];
    title.textColor=[UIColor grayColor];
    title.text=key;;
    title.backgroundColor=[UIColor clearColor];
    [view addSubview:title];
    return view;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid=@"detailCell";
    NPNewListDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell=[[NPNewListDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        cell.delegate=self;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    NSArray *allKeys = [NPCustomMethod sortNewsListKey:mDicData];;
    NSString *key = [allKeys objectAtIndex:indexPath.section];
    NSArray *value = [mDicData valueForKey:key];
    [cell restCell:[value objectAtIndex:indexPath.row]];
    return cell;
}
//click userHeader
-(void)NPNewListDetailCellClickContentHeadImage:(NPNewListDetailCell *)cell
{
     NSArray *allKeys = [NPCustomMethod sortNewsListKey:mDicData];
    NSIndexPath *path=[mTableView indexPathForCell:cell];
    NSArray *value=[mDicData objectForKey:[allKeys objectAtIndex:path.section]];
    NPlistReplyModel *reply=[value objectAtIndex:path.row];
    NPUserDetailViewController *userController=[[NPUserDetailViewController alloc]init];
    userController.uid=reply.uid;
    userController.title=reply.name;
    [self.navigationController pushViewController:userController animated:YES];

}
//click userHeader
-(void)NPNewListDetailFootReplysViewClickUser:(NPlistReplyModel *)reply
{
    NPUserDetailViewController *userController=[[NPUserDetailViewController alloc]init];
    userController.uid=reply.uid;
    userController.title=reply.name;
    [self.navigationController pushViewController:userController animated:YES];
}
-(void)NPNewListDetailCellClickContentText:(NPNewListDetailCell *)cell
{
    UIActionSheet *actionSheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Copy Comment" otherButtonTitles:nil, nil];
    [actionSheet showInView:self.view];
    
    
}
-(void)NPNewListDetailCellClickContentUrl:(NSURL *)url
{
    if (![[url.absoluteString lowercaseString] hasPrefix:@"http" ]) {
        url=[NSURL URLWithString:[NSString stringWithFormat: @"http://%@",url.absoluteString]];
    }
    if ([[UIApplication sharedApplication]canOpenURL:url]) {
        [[UIApplication sharedApplication]openURL:url];
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
