//
//  NPNewsListViewController.m
//  newsPicks
//
//  Created by yunqi on 14-7-21.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "NPNewsListViewController.h"
#import "NPNewListTopScrollView.h"
#import "NPTimeOnlineTableViewController.h"
#import "NPTopTableViewController.h"
#import "NPPremiumTableViewController.h"
#import "NPKeyBoardView.h"
@interface NPNewsListViewController ()<NPNewListTopScrollViewDelegate,UIScrollViewDelegate,NPKeyBoardViewDelegate>
{
    NPNewListTopScrollView *listTopScrollView;
    NPTimeOnlineTableViewController *onLineController;
    NPTopTableViewController *topController;
    NPPremiumTableViewController *premiumController;
    UIScrollView *scrollContent;
}
@end

@implementation NPNewsListViewController

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
    self.title=@"NewsPicks";
    listTopScrollView=[[NPNewListTopScrollView alloc]init];
    listTopScrollView.frame=CGRectMake(0, 0, self.view.frame.size.width, 30);
    listTopScrollView.backgroundColor=[UIColor clearColor];
    listTopScrollView.nameList=[NSArray arrayWithObjects:@"TimeLine",@"Top20",@"Premium", nil];
    listTopScrollView.delegateListTop=self;
    listTopScrollView.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin  |UIViewAutoresizingFlexibleRightMargin;
    [self.view addSubview:listTopScrollView];
    
    scrollContent=[[UIScrollView alloc] init];
    scrollContent.backgroundColor=[UIColor clearColor];
    scrollContent.showsHorizontalScrollIndicator=NO;
    scrollContent.showsVerticalScrollIndicator=NO;
    scrollContent.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin  |UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    scrollContent.pagingEnabled=YES;
    scrollContent.frame=CGRectMake(0, listTopScrollView.frame.size.height+listTopScrollView.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height-listTopScrollView.frame.size.height-listTopScrollView.frame.origin.y-44);
    scrollContent.delegate=self;
    [self.view addSubview:scrollContent];
    onLineController=[[NPTimeOnlineTableViewController alloc] initWithStyle:UITableViewStylePlain];
    onLineController.view.frame=CGRectMake(0, 0, scrollContent.frame.size.width, scrollContent.frame.size.height);
    [self addChildViewController:onLineController];
    [scrollContent addSubview:onLineController.view];
    
    topController=[[NPTopTableViewController alloc]initWithStyle:UITableViewStylePlain];
    topController.view.frame=CGRectMake(onLineController.view.frame.size.width+onLineController.view.frame.origin.x, onLineController.view.frame.origin.y, onLineController.view.frame.size.width, onLineController.view.frame.size.height);
    [self addChildViewController:topController];
    [scrollContent addSubview:topController.view];
    
    premiumController=[[NPPremiumTableViewController alloc]initWithStyle:UITableViewStylePlain];
    premiumController.view.frame=CGRectMake(topController.view.frame.size.width+topController.view.frame.origin.x, topController.view.frame.origin.y, topController.view.frame.size.width, topController.view.frame.size.height);
    [self addChildViewController:premiumController];
    [scrollContent addSubview:premiumController.view];
    
    scrollContent.contentSize=CGSizeMake(premiumController.view.frame.size.width+premiumController.view.frame.origin.x, scrollContent.frame.size.height);
    
    
//    [NPKeyBoardView share];
//    onLineController.view.backgroundColor=[UIColor orangeColor];
//    topController.view.backgroundColor=[UIColor lightGrayColor];
//    premiumController.view.backgroundColor=[UIColor blackColor];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated
{

}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
    [listTopScrollView restSelectedColor:index];
}
-(void)NPNewListTopScrollViewSelectedIndex:(NSInteger)index
{
    [scrollContent setContentOffset:CGPointMake(index*scrollContent.frame.size.width, 0) animated:YES];
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
