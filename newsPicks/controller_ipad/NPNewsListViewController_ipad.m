//
//  ViewController.m
//  testIPAd2
//
//  Created by ZhangCheng on 14-8-4.
//  Copyright (c) 2014年 ZhangCheng. All rights reserved.
//

#import "NPNewsListViewController_ipad.h"

@interface NPNewsListViewController_ipad ()<UICollectionViewDataSource,UICollectionViewDelegate>{
    int isFirst;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation NPNewsListViewController_ipad

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"%d",self.childViewControllers.count);
    isFirst=YES;

}

-(IBAction)changeAction:(id)sender{
    isFirst=!isFirst;
    [self.collectionView setContentOffset:CGPointZero animated:NO];
    [self.collectionView reloadData];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[NSString stringWithFormat:@"cell%d",(indexPath.row+(isFirst?1:2))%3+1] forIndexPath:indexPath];
    
    return cell;
}

-(int)getCurrentPageOfCollectionView{
    CGPoint p = self.collectionView.contentOffset;
    int page = p.x/self.collectionView.frame.size.width;
    return page;
}

-(IBAction)nextAction:(id)sender{
    int page = [self getCurrentPageOfCollectionView];
    if (page<7) {
        [self.collectionView setContentOffset:CGPointMake((page+1)*self.collectionView.frame.size.width, 0) animated:YES];
    }
}
-(IBAction)preAction:(id)sender{
    int page = [self getCurrentPageOfCollectionView];
    if (page>0) {
        [self.collectionView setContentOffset:CGPointMake((page-1)*self.collectionView.frame.size.width, 0) animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
