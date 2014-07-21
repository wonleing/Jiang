//
//  NPMainViewController.m
//  newsPicks
//
//  Created by yunqi on 14-7-20.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "NPMainViewController.h"
#import "NPContentlayout.h"
static void     *flabbyContext = &flabbyContext;
@interface NPMainViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
{
    UICollectionView *myCollectionView;
//    UIView *topView;
//    UIView *buttomView;
}
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
    
    
    
    NPContentlayout*layout=[[NPContentlayout alloc] init];
    myCollectionView=[[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [myCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    myCollectionView.backgroundColor=[UIColor clearColor];
    myCollectionView.delegate=self;
    myCollectionView.dataSource=self;
    [self.view addSubview:myCollectionView];
    
    self.view.backgroundColor=[UIColor clearColor];
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
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
