//
//  RightViewController.m
//  newsPicks
//
//  Created by dengqixiang on 14-8-31.
//  Copyright (c) 2014年 dengqixiang. All rights reserved.
//

#import "RightViewController.h"
#import "RightViewCell.h"
#import "RightCollectionViewLayout.h"

@interface RightViewController ()
@property (nonatomic, assign) NSInteger cellCount;
@property (nonatomic, assign) NSInteger currentSelectionIndex;
@property (nonatomic, assign) NSArray *arry;
@end

@implementation RightViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.arry = [[NSArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     self.arry = @[@"RECOMMENED USERS",@"RANKING",@"FOLLOW ROBOTS"];
    // Do any additional setup after loading the view.
    // Do any additional setup after loading the view, typically from a nib.
    // Do any additional setup after loading the view, typically from a nib.
    self.cellCount = 3;
    self.currentSelectionIndex = -1;
    //    UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    //    [self.collectionView addGestureRecognizer:tapRecognizer];
    [self.collectionView registerClass:[RightViewCell class] forCellWithReuseIdentifier:@"Right_Cell"];
    [self.collectionView reloadData];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsVerticalScrollIndicator = false;
    CGRect mainframe = [UIScreen mainScreen].applicationFrame;
    self.collectionView.frame = CGRectMake(mainframe.size.width, 0, mainframe.size.width*0.65, mainframe.size.height);
    NSLog(@"self.collectionView.frame = %@",NSStringFromCGRect(self.collectionView.frame));
    [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:2 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    return self.cellCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    RightViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"Right_Cell" forIndexPath:indexPath];
    cell.title = [self.arry objectAtIndex:indexPath.row];
    cell.parentViewController = self.parentViewController;
    if (indexPath.row == 0) {
        cell.color = [UIColor blackColor];
    }
    if (indexPath.row == 1) {
        cell.color = [UIColor redColor];
    }
    if (indexPath.row == 2) {
        cell.color = [UIColor blueColor];
    }
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected item = %d",indexPath.item);
    RightViewCell* cell = nil;
    if(self.currentSelectionIndex != indexPath.item)
    {
        for (NSInteger i = 0; i<self.cellCount; i++) {
            NSIndexPath * preindexPath = [NSIndexPath indexPathForItem:i inSection:0];
            UICollectionViewLayoutAttributes * attribute = [collectionView.collectionViewLayout layoutAttributesForItemAtIndexPath:preindexPath];
            CGRect framess = attribute.frame;
            cell = (RightViewCell*)[collectionView cellForItemAtIndexPath:preindexPath];
            if (cell) {
                if (i<=indexPath.item) // 小于
                {
                    [UIView animateWithDuration:0.5 animations:^{
                        CGRect frames = framess;
                        RightCollectionViewLayout* layout = (RightCollectionViewLayout*)[collectionView collectionViewLayout];
                        frames.origin.y -= i * [layout getTopReveal]*0.75;
                        cell.frame = frames;
                        
                    }completion:nil];
                }
                else // 大于
                {
                    [UIView animateWithDuration:0.5 animations:^{
                        CGRect frames = cell.frame;
                        RightCollectionViewLayout* layout = (RightCollectionViewLayout*)[collectionView collectionViewLayout];
                        frames.origin.y = self.view.frame.size.height-(self.cellCount - i)*[layout getTopReveal]*0.25;
                        cell.frame = frames;
                        
                    }completion:nil];
                }
            }
        }
        self.currentSelectionIndex = indexPath.item;
    }
    else
    {
        for (NSInteger i = 0; i<self.cellCount; i++) {
            NSIndexPath * preindexPath = [NSIndexPath indexPathForItem:i inSection:0];
            UICollectionViewLayoutAttributes * attribute = [collectionView.collectionViewLayout layoutAttributesForItemAtIndexPath:preindexPath];
            CGRect framess = attribute.frame;
            cell = (RightViewCell*)[collectionView cellForItemAtIndexPath:preindexPath];
            if (cell) {
                [UIView animateWithDuration:0.5 animations:^{
                    CGRect frames = cell.frame;
                    frames.origin.y = framess.origin.y;
                    cell.frame = frames;
                }completion:nil];
            }
            
        }
        self.currentSelectionIndex = -1;
    }
    
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
