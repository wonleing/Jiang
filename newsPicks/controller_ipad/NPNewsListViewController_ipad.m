//
//  ViewController.m
//  testIPAd2
//
//  Created by ZhangCheng on 14-8-4.
//  Copyright (c) 2014年 ZhangCheng. All rights reserved.
//

#import "NPNewsListViewController_ipad.h"
#import "NPTimeOnlineCell_iPad.h"
#import "NPHTTPRequest.h"
#import "NPCellDelegate.h"
#import "NPListModel.h"
#import "NPNewListDetailViewController.h"
#import "NPTextInputViewController.h"
#import "UIViewController+MJPopupViewController.h"
@interface NPNewsListViewController_ipad ()<UICollectionViewDataSource,UICollectionViewDelegate,NPTimeOnlineCellDelegate_iPad>{
    int _currentType;
    NSMutableArray *list;
    NPlistPopularUsers *popularUsers;
    NSMutableArray *resultList;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic)NPTextInputViewController *textInputviewController;
@end

@implementation NPNewsListViewController_ipad

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _currentType=11;
    list=[[NSMutableArray alloc]init];
    resultList =[[NSMutableArray alloc]init];
    [self reFreshAction:nil];
    
}
-(void)dealWithList{
    
    [resultList removeAllObjects];
    
    int num = list.count/5;
    for (int i = 0; i<num; i++) {
        int type = arc4random()%3+1;
        NSLog(@"%d",type);
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"cell%d",type],@"type",[NSArray arrayWithObjects:list[i*5+0],list[i*5+1],list[i*5+2],list[i*5+3],list[i*5+4], nil],@"data", nil];
        [resultList addObject:dic];
    }
    [self.collectionView setContentOffset:CGPointZero animated:NO];
}
-(IBAction)reFreshAction:(id)sender{
    self.uid = self.isNotSelf?self.uid:[[NSUserDefaults standardUserDefaults]objectForKey:@"com.zhangcheng.uid"];
    if (_currentType == 11) {
        [NPHTTPRequest getTimeOnLineData:self.uid page:1 usingSuccessBlock:^(BOOL isSuccess, NSArray *result) {
            if (isSuccess) {
                [list removeAllObjects];
                [list addObjectsFromArray:result];
                [self dealWithList];
                [self.collectionView reloadData];
            }
        }] ;
    }else if (_currentType == 12){
        [NPHTTPRequest getTopData:1 usingSuccessBlock:^(BOOL isSuccess, NSArray *result, NPlistPopularUsers *popularUser) {
            if (isSuccess) {
                popularUsers=popularUser;
                [list removeAllObjects];
                [list addObjectsFromArray:result];
                [self dealWithList];

                [self.collectionView reloadData];
            }            
        }];
    }else{
        
    }
}
-(IBAction)changeAction:(UIButton*)sender{
    if (sender.tag!=_currentType) {
        UIButton *btn = (UIButton*)[self.view viewWithTag:_currentType];
        btn.selected=NO;
        sender.selected=YES;
        _currentType = sender.tag;
        [self reFreshAction:nil];
    }
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return resultList.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [resultList objectAtIndex:indexPath.row];
    NPTimeOnlineCell_iPad *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[dic objectForKey:@"type"] forIndexPath:indexPath];
    [cell restCell:[dic objectForKey:@"data"]];
    return cell;
}

-(int)getCurrentPageOfCollectionView{
    CGPoint p = self.collectionView.contentOffset;
    int page = p.x/self.collectionView.frame.size.width;
    return page;
}

-(IBAction)nextAction:(id)sender{
    int page = [self getCurrentPageOfCollectionView];
    if (page<resultList.count-1) {
        [self.collectionView setContentOffset:CGPointMake((page+1)*self.collectionView.frame.size.width, 0) animated:YES];
    }
}
-(IBAction)preAction:(id)sender{
    int page = [self getCurrentPageOfCollectionView];
    if (page>0) {
        [self.collectionView setContentOffset:CGPointMake((page-1)*self.collectionView.frame.size.width, 0) animated:YES];
    }
}

-(void)NPTimeOnLineCellClickAction:(NPListModel *)model{
//    NSLog(@"click:%@",model);
    NPNewListDetailViewController *listDetail=[[NPNewListDetailViewController alloc] init];
    listDetail.listModel=model;
    listDetail.type=NPListType_online;
    [self.navigationController pushViewController:listDetail animated:YES];
}
-(void)NPTimeOnLineCellPickAction:(NPListModel *)model{
    self.textInputviewController = [[NPTextInputViewController alloc]initWithNibName:@"NPTextInputViewController_iPad" bundle:nil];
    self.textInputviewController.tid=model.listID;
    self.textInputviewController.mTitle=model.title;
    [self presentPopupViewController:self.textInputviewController animationType:MJPopupViewAnimationSlideBottomTop];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
