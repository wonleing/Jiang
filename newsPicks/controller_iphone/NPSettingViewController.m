//
//  NPSettingViewController.m
//  newsPicks
//
//  Created by yunqi on 14-7-28.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "NPSettingViewController.h"
#import "NPSetingProfileController.h"
#import "NPSettingEmailController.h"
#import "NPSettingPasswordController.h"
#import "NPSettingInterestController.h"
#import "NPAlertView.h"
#import "UIViewController+MJPopupViewController.h"
#import "LoginViewController_iPad.h"
#import "NPMainViewController.h"
@interface NPSettingViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    UITableView *mTableView;
}
@end

@implementation NPSettingViewController


- (void)loadView{
    [super loadView];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self.view.frame=CGRectMake(0, 0, 320, 480);
    }
}
- (void)viewDidLoad
{
    self.title=@"Setting";
    mTableView=[[UITableView alloc]init];
    mTableView.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad?0:44));
    mTableView.backgroundColor=[UIColor colorWithRed:232.0f/255.0f green:234.0f/255.0f blue:239.0f/255.0f alpha:1];
    [self.view addSubview:mTableView];
    mTableView.delegate=self;
    mTableView.dataSource=self;
    
    UIView *foot=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    mTableView.tableFooterView=foot;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }if (section==1) {
        return 3;
    }
    if (section==2) {
        return 1;
    }
    if (section==3) {
        return 2;
    }
    if (section==4) {
        return 1;
    }
    if (section==5) {
        return 1;
    }
    return 0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat sectionHeaderHeight = 40;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    view.backgroundColor=[UIColor clearColor];
    return view;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
//    for (UIView *view in cell.contentView.subviews) {
//        [view removeFromSuperview];
//    }
    UIView *view = [cell viewWithTag:100];
    if (view) {
        [view removeFromSuperview];
    }
    cell.textLabel.textColor=[UIColor blackColor];
    if (indexPath.section==0) {
        UIImageView *imageView=[[UIImageView alloc]init];
        imageView.frame=CGRectMake(9, 0, 40, 40);
        imageView.image=[UIImage imageNamed:NP_IMG_TIME_ONLINE_DEFAULT];
        imageView.tag=100;
        [cell.contentView addSubview:imageView];
        cell.textLabel.textAlignment=NSTextAlignmentCenter;
        cell.textLabel.text=@"Edit Profile Picture";
    }
    if (indexPath.section==1) {
        cell.textLabel.textAlignment=NSTextAlignmentLeft;
        if (indexPath.row==0) {
            cell.textLabel.text=@"Profile";
        }
        if (indexPath.row==1) {
            cell.textLabel.text=@"Email";
        }
        if (indexPath.row==2) {
            cell.textLabel.text=@"Password";
        }
    }
    if (indexPath.section==2) {
        cell.textLabel.textAlignment=NSTextAlignmentCenter;
        cell.textLabel.text=@"Theme of Interest";
    }
    if (indexPath.section==3) {
        cell.textLabel.textAlignment=NSTextAlignmentLeft;
        if (indexPath.row==0) {
            cell.textLabel.text=@"Connect With Twitter";
        }
        if (indexPath.row==1) {
            cell.textLabel.text=@"Connect with Facebook";
        }
    }
    if (indexPath.section==4) {
        cell.textLabel.textAlignment=NSTextAlignmentCenter;
        cell.textLabel.text=@"Manage Subscription";
    }
    if (indexPath.section==5) {
        cell.textLabel.textAlignment=NSTextAlignmentCenter;
        cell.textLabel.text=@"Logout";
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0) {
        UIActionSheet *sheet=[[UIActionSheet alloc]initWithTitle:@"Select Photo" delegate:nil cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"From Photo Library",@"Take Photo", nil];
        [sheet showInView:self.view];
    }
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            NPSetingProfileController *profileController=[[NPSetingProfileController alloc]init];
            [self.navigationController pushViewController:profileController animated:YES];
        }
        if (indexPath.row==1) {
            NPSettingEmailController *emailController=[[NPSettingEmailController alloc]init];
            [self.navigationController pushViewController:emailController animated:YES];
        }
        if (indexPath.row==2) {
            NPSettingPasswordController * passwordController=[[NPSettingPasswordController alloc]init];
            [self.navigationController pushViewController:passwordController animated:YES];
        }
    }
    if (indexPath.section==2) {
        NPSettingInterestController *interestController=[[NPSettingInterestController alloc]initWithNibName:@"NPSettingInterestController" bundle:nil];
        [self.navigationController pushViewController:interestController animated:YES];
    }
    if (indexPath.section==3) {
        
    }
    if (indexPath.section==4) {
        
    }
    if (indexPath.section==5) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Logout" message:@"Do you want to logout？" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Logout", nil];
        [alert show];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        [[NSUserDefaults standardUserDefaults]setObject:[NSNumber numberWithInt:0] forKey:@"com.zhangcheng.uid"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [self.navigationController popViewControllerAnimated:NO];

        }else{
            [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade completion:^{
                LoginViewController_iPad *viewController = [[LoginViewController_iPad alloc]initWithNibName:@"LoginViewController_iPad" bundle:nil];
                UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:viewController];
                [nav setNavigationBarHidden:YES];
                nav.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
                [((NPMainViewController*)((UINavigationController*)((UIWindow*)[UIApplication sharedApplication].windows.firstObject).rootViewController).viewControllers.firstObject) viewWillAppear:NO];
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
