//
//  TestViewController.m
//  newsPicks
//
//  Created by ZhangCheng on 14-8-4.
//  Copyright (c) 2014年 ZhangCheng. All rights reserved.
//

#import "TestViewController.h"
#import "NPMainViewController.h"
#import "NPFollowCell.h"
#import "NPUserDetaiInfolModel.h"
#import "NPUserDetailViewController.h"
#import "NPNewsListViewController_ipad.h"
#import "SVProgressHUD.h"
@interface TestViewController ()<UITableViewDataSource,UITableViewDelegate,NPFollowCellDelegate>{
    IBOutlet UITableView *mTableView;
    NSMutableArray *list;
    
    NSString *_uid;
    int currentPage;
    BOOL isNib;
}

@end

@implementation TestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.frame=CGRectMake(768, 40, self.view.frame.size.width, self.view.frame.size.height);
        isNib=YES;
    }
    return self;
}
-(IBAction)backAction:(id)sender{
    [((NPMainViewController*)self.parentViewController) closeSecView];
}
-(IBAction)backAction2{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _uid = [[NSUserDefaults standardUserDefaults]objectForKey:@"com.zhangcheng.uid"];
    currentPage=0;
    
    list=[[NSMutableArray alloc]init];
    [self loadMore];

}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
-(IBAction)nextAction{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
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
        if (isNib) {
            cell=[[NPFollowCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];

        }else{
            cell=[[NPFollowCell alloc]initWithStyle2:UITableViewCellStyleDefault reuseIdentifier:cellID];

        }
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

    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
    NPNewsListViewController_ipad *viewController = [main instantiateInitialViewController];
    viewController.isNotSelf=YES;
    
    viewController.uid=infoModel.uid;
    
    
    ((NPMainViewController*)self.parentViewController).navigationController.navigationBar.hidden=NO;

    [((NPMainViewController*)self.parentViewController).navigationController pushViewController:viewController animated:YES];
    [self backAction:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
