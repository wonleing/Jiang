//  NPMainViewController.m
//  newsPicks
//
//  Created by yunqi on 14-7-20.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//
#import "NPMainViewController.h"
#import "NPContentlayout.h"
#import "NPNewsListViewController.h"
#import "NPNavigationViewController.h"
#import "NPMainleftView.h"
#import "NPFollowersRobotsController.h"
#import "NPContentUrlViewController.h"
#import "NPNewsListViewController_ipad.h"
#import "NPSettingViewController.h"
#import "LoginViewController.h"
#import "gtxCellView.h"
#import "gtxCollectionLayout.h"
#import "NPUserDetailViewController.h"
static void *flabbyContext = &flabbyContext;
@interface NPMainViewController ()<UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,NPMainleftViewDelegate>
{
    UIScrollView *mScrollview;
    NPNavigationViewController *navControllerl;
    NPMainleftView *leftView;
//    UIView *topView;
//    UIView *buttomView;
    
    
}
@property (nonatomic,strong) NSIndexPath *currentIndexPath;
@property(copy,nonatomic)NSNumber *uid;
@property (nonatomic, assign) NSInteger cellCount;
@property (nonatomic,strong)UICollectionView *uperCollectionView;
@end
@implementation NPMainViewController
+ (UIColor *)randomColor {
    
    //    return [UIColor clearColor];
    CGFloat comps[3];
    
    for (int i = 0; i < 3; i++) {
        
        NSUInteger r = arc4random_uniform(256);
        comps[i] = (CGFloat)r/255.f;
    }
    
    return [UIColor colorWithRed:comps[0] green:comps[1] blue:comps[2] alpha:0.3];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section
{
    
}
- (void)viewDidLoad
{
    
    self.cellCount = 20;
    //    UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    //    [self.collectionView addGestureRecognizer:tapRecognizer];
    gtxCollectionLayout *layout = [[gtxCollectionLayout alloc] init];
    self.uperCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 320, 400) collectionViewLayout:layout];
    [self.uperCollectionView setFrame:CGRectMake(0, 0, 320, 400)];
    [self.uperCollectionView setDelegate:self];
    [self.uperCollectionView setDataSource:self];
    [self.uperCollectionView registerClass:[gtxCellView class] forCellWithReuseIdentifier:@"MY_CELL"];
    [self.uperCollectionView reloadData];
    self.uperCollectionView.backgroundColor = [UIColor whiteColor];
    self.uperCollectionView.showsVerticalScrollIndicator = false;
    self.uperCollectionView.contentOffset = CGPointMake(0, 600);
    mScrollview=[[UIScrollView alloc]init];
    mScrollview.frame=CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height-250);
    mScrollview.showsHorizontalScrollIndicator=NO;
    mScrollview.contentSize=CGSizeMake(mScrollview.frame.size.width, mScrollview.frame.size.height+2);
    mScrollview.delegate=self;
    mScrollview.showsVerticalScrollIndicator=NO;
    [self.view addSubview:mScrollview];
    
    leftView=[NPMainleftView mainLeftView];
    [self.view addSubview:self.uperCollectionView];
    [self.view addSubview:leftView];

    leftView.delegate=self;
    NPBaseViewController *base=UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone?[[NPNewsListViewController alloc]init]:[[NPNewsListViewController_ipad alloc]init];
    navControllerl=[[NPNavigationViewController alloc]initWithRootViewController:base];
    navControllerl.view.backgroundColor=[UIColor whiteColor];
    navControllerl.navigationBar.hidden=NO;
    [navControllerl.navigationBar setBackgroundImage:[NPCustomMethod createImageWithColor:[UIColor colorWithRed:18.00/255.0f green:26.0f/255.0f blue:80.0f/255.0f alpha:1] size:CGSizeMake(self.view.frame.size.width, 64)] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBackgroundImage:[NPCustomMethod createImageWithColor:[UIColor colorWithRed:18.00/255.0f green:26.0f/255.0f blue:80.0f/255.0f alpha:1] size:CGSizeMake(self.view.frame.size.width, 64)] forBarMetrics:UIBarMetricsDefault];
    navControllerl.view.frame=CGRectMake(0, mScrollview.frame.size.height+mScrollview.frame.origin.y, navControllerl.view.frame.size.width, navControllerl.view.frame.size.height);
    [self.view addSubview:navControllerl.view];
    
    
       self.view.backgroundColor=[UIColor clearColor];
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    ((UIViewController *)[navControllerl.viewControllers objectAtIndex:0]).navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"Tap" style:UIBarButtonItemStyleBordered target:self action:@selector(clickTap)];
    [super viewDidAppear:animated];
}
-(void)clickTap
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.35];
    if (navControllerl.view.frame.origin.y==20) {
        navControllerl.view.frame=CGRectMake(navControllerl.view.frame.origin.x, mScrollview.frame.origin.y+mScrollview.frame.size.height, navControllerl.view.frame.size.width,navControllerl.view.frame.size.height);
    }else
    {
         navControllerl.view.frame=CGRectMake(navControllerl.view.frame.origin.x,20, navControllerl.view.frame.size.width,navControllerl.view.frame.size.height);
        [self.view bringSubviewToFront:navControllerl.view];
    }
    [UIView commitAnimations];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden=YES;
    
    self.uid = [[NSUserDefaults standardUserDefaults]objectForKey:@"com.zhangcheng.uid"];
    if (self.uid.intValue==0) {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            LoginViewController *viewController = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:viewController];
            [nav setNavigationBarHidden:YES];
            nav.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
            [self presentViewController:nav animated:NO completion:nil];
        }else{
#warning iPad登录
        }
    }
    [self.uperCollectionView deselectItemAtIndexPath:self.currentIndexPath animated:YES];
    [super viewWillAppear:animated];
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Deselected item = %d",indexPath.item);
    UICollectionViewLayoutAttributes * attribute = [collectionView.collectionViewLayout layoutAttributesForItemAtIndexPath:indexPath];
    CGRect framess = attribute.frame;
    gtxCellView* cell = (gtxCellView*)[collectionView cellForItemAtIndexPath:indexPath];
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frames = cell.frame;
        frames.origin.x = framess.origin.x;
        cell.frame = frames;
    }completion:nil];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.currentIndexPath = indexPath;
    NSLog(@"selected item = %d",indexPath.item);
    gtxCellView* cell = (gtxCellView*)[collectionView cellForItemAtIndexPath:indexPath];
    
    //    CGRect frame = attribute.frame;
    //    CGRect framess = cell.frame;
    //    frame.origin.x = 0;
    //    cell.frame = frame;
    // TODO 对cellView做动画
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frames = cell.frame;
        frames.origin.x = 0;
        cell.frame = frames;
    }completion:^(BOOL finished) {
//        NPUserDetailViewController *VC = [[NPUserDetailViewController alloc] init];
//        [self.navigationController pushViewController:VC animated:YES];
    }];
    
}
-(void)NPMainleftViewClickOne
{
    NPFollowersRobotsController *robots=[[NPFollowersRobotsController alloc]init];
    self.navigationController.navigationBar.hidden=NO;
    [self.navigationController pushViewController:robots animated:YES];
}
-(void)NPMainleftViewClickTwo
{
    NPContentUrlViewController *url=[[NPContentUrlViewController alloc]init];
    self.navigationController.navigationBar.hidden=NO;
    [self.navigationController pushViewController:url animated:YES];
}
-(void)NPMainleftViewClickThree
{
    NPSettingViewController *setingController=[[NPSettingViewController alloc]init];
    self.navigationController.navigationBar.hidden=NO;
    [self.navigationController pushViewController:setingController animated:YES];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y+mScrollview.frame.size.height>scrollView.contentSize.height) {
        navControllerl.view.frame=CGRectMake(navControllerl.view.frame.origin.x, self.view.frame.size.height-250-(scrollView.contentOffset.y+mScrollview.frame.size.height-scrollView.contentSize.height), navControllerl.view.frame.size.width, navControllerl.view.frame.size.height);
    }
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == self.uperCollectionView) {
        return 20;
    }else{
    return 10;
    }
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.uperCollectionView) {
        gtxCellView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MY_CELL" forIndexPath:indexPath];
      
        return cell;
    }else{
      UICollectionViewCell*cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    for (UIView*view in cell.contentView.subviews) {
        if (view) {
            [view removeFromSuperview];
        }
    }
    UILabel *label=[[UILabel alloc] init];
    label.frame=CGRectMake(0, 0, self.view.frame.size.width, 40);
    label.text=@"测试";
    label.textColor=[UIColor blackColor];
    label.backgroundColor=[UIColor orangeColor];
    [cell.contentView addSubview:label];
    return cell;
    }
}
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    return CGSizeMake(self.view.frame.size.width,130);
//}

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
