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
#import "TestViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "LoginViewController_iPad.h"
#import "NPRecommandThreadModel.h"
static void *flabbyContext = &flabbyContext;
@interface NPMainViewController ()<UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,NPMainleftViewDelegate,UIPopoverControllerDelegate>
{
    UIScrollView *mScrollview;
    NPNavigationViewController *navControllerl;
    NPMainleftView *leftView;
//    UIView *topView;
//    UIView *buttomView;
    
    
}
@property (strong,nonatomic)UINavigationController *commonNav;
@property (strong,nonatomic)NPContentUrlViewController *contentUrlViewController;
@property (strong,nonatomic)NPSettingViewController *settingViewController;
@property (strong,nonatomic) TestViewController *testViewController;
@property (nonatomic,strong) NSIndexPath *currentIndexPath;
@property(copy,nonatomic)NSNumber *uid;
@property (nonatomic, assign) NSInteger cellCount;
@property (nonatomic,strong)UICollectionView *uperCollectionView;
@property (nonatomic,strong)NSArray *upperArray;
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
        self.upperArray = [[NSArray alloc] init];    }
    return self;
}
-(void)configUperContent
{
  [NPHTTPRequest getRecommandThreadSuccessBlock:^(BOOL isSuccess, NSArray *array) {
//      recomand.userimage = [dic objectForKey:@"userimage"];
//      recomand.position = [dic objectForKey:@"position"];
//      recomand.createdate = [dic objectForKey:@"createdate"];
//      recomand.link = [dic objectForKey:@"link"];
//      recomand.title = [dic objectForKey:@"title"];
//      recomand.threadid = [dic objectForKey:@"threadid"];
//      recomand.type = [dic objectForKey:@"type"];
//      recomand.description = [dic objectForKey:@"description"];
//      recomand.given = [dic objectForKey:@"given"];
//      recomand.score = [dic objectForKey:@"score"];
//      recomand.family = [dic objectForKey:@"family"];
//      recomand.company = [dic objectForKey:@"company"];
//      recomand.content = [dic objectForKey:@"content"];
//      recomand.loginname = [dic objectForKey:@"loginname"];
//      recomand.cateid = [dic objectForKey:@"cateid"];
//      recomand.threadimage = [dic objectForKey:@"threadimage"];
//      recomand.userid = [dic objectForKey:@"userid"];
      self.upperArray = array;
      self.cellCount = self.upperArray.count+1;
      [self.uperCollectionView reloadData];
      [self.view addSubview:self.uperCollectionView];
      [self.view sendSubviewToBack:self.uperCollectionView];
  }];
}
-(void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section
{
    
}
- (void)viewDidLoad
{
    self.modalInPopover=YES;
    
    //    UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    //    [self.collectionView addGestureRecognizer:tapRecognizer];
    gtxCollectionLayout *layout = [[gtxCollectionLayout alloc] init];
    self.uperCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 400) collectionViewLayout:layout];
    [self.uperCollectionView setFrame:CGRectMake(0, 0, self.view.frame.size.width, 400)];
    [self.uperCollectionView setDelegate:self];
    [self.uperCollectionView setDataSource:self];
    [self.uperCollectionView registerClass:[gtxCellView class] forCellWithReuseIdentifier:@"MY_CELL"];
    self.uperCollectionView.backgroundColor = [UIColor whiteColor];
    self.uperCollectionView.showsVerticalScrollIndicator = false;
    self.uperCollectionView.contentOffset = CGPointMake(0, 2000);
    //[self.view addSubview:self.uperCollectionView];
    mScrollview=[[UIScrollView alloc]init];
    mScrollview.frame=CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height-250);
    mScrollview.showsHorizontalScrollIndicator=NO;
    mScrollview.contentSize=CGSizeMake(mScrollview.frame.size.width, mScrollview.frame.size.height+2);
    mScrollview.delegate=self;
//    [self.view addSubview:mScrollview];
//    mScrollview.backgroundColor = [UIColor redColor];
    leftView=[NPMainleftView mainLeftView];
    [self.view addSubview:leftView];

    leftView.delegate=self;
    
    NPBaseViewController *base=nil;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        base =[[NPNewsListViewController alloc]init];
    else{
        UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
        NPNewsListViewController_ipad *viewController = [main instantiateInitialViewController];
        base = viewController;
    }
    navControllerl=[[NPNavigationViewController alloc]initWithRootViewController:base];
    navControllerl.view.backgroundColor=[UIColor whiteColor];
    navControllerl.navigationBar.hidden=NO;
    [navControllerl.navigationBar setBackgroundImage:[NPCustomMethod createImageWithColor:[UIColor colorWithRed:18.00/255.0f green:26.0f/255.0f blue:80.0f/255.0f alpha:1] size:CGSizeMake(self.view.frame.size.width, 64)] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBackgroundImage:[NPCustomMethod createImageWithColor:[UIColor colorWithRed:18.00/255.0f green:26.0f/255.0f blue:80.0f/255.0f alpha:1] size:CGSizeMake(self.view.frame.size.width, 64)] forBarMetrics:UIBarMetricsDefault];
//    float y = mScrollview.frame.origin.y;
//    float h = mScrollview.frame.size.height;
    navControllerl.view.frame=CGRectMake(0, 0, navControllerl.view.frame.size.width, navControllerl.view.frame.size.height);
    
    [self.view addSubview:navControllerl.view];
    
    
       self.view.backgroundColor=[UIColor clearColor];
    [super viewDidLoad];
    
    [self configUperContent];
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
    if (navControllerl.view.frame.origin.y==0) {
        navControllerl.view.frame=CGRectMake(navControllerl.view.frame.origin.x, self.uperCollectionView.frame.size.height-70, navControllerl.view.frame.size.width,navControllerl.view.frame.size.height);
        mScrollview.userInteractionEnabled = YES;

    }else
    {
         navControllerl.view.frame=CGRectMake(navControllerl.view.frame.origin.x,0, navControllerl.view.frame.size.width,navControllerl.view.frame.size.height);
        [self.view bringSubviewToFront:navControllerl.view];
        mScrollview.userInteractionEnabled = NO;
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
            LoginViewController_iPad *viewController = [[LoginViewController_iPad alloc]initWithNibName:@"LoginViewController_iPad" bundle:nil];
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:viewController];
            [nav setNavigationBarHidden:YES];
            nav.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
            [self presentViewController:nav animated:NO completion:nil];
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
//        NPUserDetaiInfolModel *infoModel=[list objectAtIndex:indexPath.row];
        NPUserDetailViewController *userController=[[NPUserDetailViewController alloc]init];
        NPRecommandThreadModel *model = [[NPRecommandThreadModel alloc] init];
        model = [self.upperArray objectAtIndex:indexPath.row];

        userController.uid=model.userid;
        userController.title=model.title;
        self.navigationController.navigationBar.hidden=NO;

        [self.navigationController pushViewController:userController animated:YES];
        [self collectionView:self.uperCollectionView didDeselectItemAtIndexPath:indexPath];
    }];
    
}
-(void)NPMainleftViewClickOne
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        NPFollowersRobotsController *robots=[[NPFollowersRobotsController alloc]init];
        self.navigationController.navigationBar.hidden=NO;
        [self.navigationController pushViewController:robots animated:YES];
    }else{
        self.testViewController = [[TestViewController alloc]initWithNibName:@"TestViewController" bundle:nil];
        [self addChildViewController:self.testViewController];
        NSLog(@"%@",NSStringFromCGRect(self.testViewController.view.frame));
        UIColor *color = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.75f];
        UIView *view = [[UIView alloc]initWithFrame:self.view.frame];
        view.backgroundColor=color;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=view.frame;
        view.alpha=0;
        view.tag=999;
        [btn addTarget:self action:@selector(closeSecView) forControlEvents:UIControlEventTouchDown];
        [view addSubview:btn];
        [view addSubview:self.testViewController.view];
        [self.view addSubview:view];
        [UIView animateWithDuration:0.25 animations:^{
            view.alpha=1.0f;
            self.testViewController.view.frame=CGRectMake(768-self.testViewController.view.frame.size.width, 40, self.testViewController.view.frame.size.width, self.testViewController.view.frame.size.height);
        }];
    }
    
}
-(void)closeSecView{
    [UIView animateWithDuration:0.25 animations:^{
        UIView *view = [self.view viewWithTag:999];
        view.alpha=0.0f;
        self.testViewController.view.frame=CGRectMake(768, 40, self.testViewController.view.frame.size.width, self.testViewController.view.frame.size.height);
    } completion:^(BOOL finished) {
        UIView *view = [self.view viewWithTag:999];
        [view removeFromSuperview];
        [self.testViewController removeFromParentViewController];
        self.testViewController=nil;
    }];
}
-(void)NPMainleftViewClickTwo
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        self.contentUrlViewController=[[NPContentUrlViewController alloc]initWithNibName:@"NPContentUrlViewController" bundle:nil];
        self.navigationController.navigationBar.hidden=NO;
        [self.navigationController pushViewController:self.contentUrlViewController animated:YES];
    }else{
        
        self.contentUrlViewController=[[NPContentUrlViewController alloc]initWithNibName:@"NPContentUrlViewController" bundle:nil];
        self.commonNav = [[UINavigationController alloc]initWithRootViewController:self.contentUrlViewController];
        self.commonNav.view.frame=self.contentUrlViewController.view.frame;
        [self.commonNav setNavigationBarHidden:YES];
        [self presentPopupViewController:self.commonNav animationType:MJPopupViewAnimationFade];
    }
    
}
-(void)NPMainleftViewClickThree
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        NPSettingViewController *setingController=[[NPSettingViewController alloc]init];
        self.navigationController.navigationBar.hidden=NO;
        [self.navigationController pushViewController:setingController animated:YES];
    }else{
        self.settingViewController=[[NPSettingViewController alloc]init];
        self.commonNav = [[UINavigationController alloc]initWithRootViewController:self.settingViewController];
        self.commonNav.view.frame=self.settingViewController.view.frame;
//        [self.commonNav setNavigationBarHidden:YES];
        [self presentPopupViewController:self.commonNav animationType:MJPopupViewAnimationFade];

    }
    
}
//- (void)cancelButtonClicked:(MJSecondDetailViewController *)aSecondDetailViewController
//{
//    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
//    self.secondDetailViewController = nil;
//}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   NSIndexPath* index = [NSIndexPath indexPathForItem:(self.cellCount-2) inSection:0];
    gtxCellView* cell = (gtxCellView*)[self.uperCollectionView cellForItemAtIndexPath:index];
    float deltaH = self.uperCollectionView.collectionViewLayout.collectionViewContentSize.height - self.uperCollectionView.frame.size.height;
    float deltaContenty = scrollView.contentOffset.y - deltaH;
    CGRect frame = navControllerl.view.frame;

    if(cell&&deltaContenty>0)
    {
        NSLog(@"cell frame = %@",NSStringFromCGRect(cell.frame));
        frame.origin.y = cell.frame.origin.y - deltaH - deltaContenty;
        navControllerl.view.frame = frame;
    }
    //if (scrollView.contentOffset.y+mScrollview.frame.size.height>scrollView.contentSize.height) {
    
//        navControllerl.view.frame=CGRectMake(navControllerl.view.frame.origin.x, self.view.frame.size.height-250-(scrollView.contentOffset.y+mScrollview.frame.size.height-scrollView.contentSize.height), navControllerl.view.frame.size.width, navControllerl.view.frame.size.height);
//    }
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == self.uperCollectionView) {
        return self.upperArray.count;
    }else{
    return 10;
    }
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.uperCollectionView) {
        gtxCellView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MY_CELL" forIndexPath:indexPath];
        NPRecommandThreadModel *model = [[NPRecommandThreadModel alloc] init];
        model = [self.upperArray objectAtIndex:indexPath.row];
        if (indexPath.row == self.upperArray.count) {
            cell.title = @"MY CONTENT";
        }else
        {
            cell.title = model.title;
            if ([model.cateid intValue] == 1) {
                cell.color = [UIColor redColor];
            }
            if ([model.cateid intValue] == 2) {
                cell.color = [UIColor orangeColor];
            }
            if ([model.cateid intValue] == 3) {
                cell.color = [UIColor cyanColor];
            }
            
            
        }
      
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
