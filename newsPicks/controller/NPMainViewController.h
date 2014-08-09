//
//  NPMainViewController.h
//  newsPicks
//
//  Created by yunqi on 14-7-20.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NPMainViewController : UIViewController<UIGestureRecognizerDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
-(void)closeSecView;
@end
