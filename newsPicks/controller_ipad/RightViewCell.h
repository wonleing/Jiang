//
//  RightViewCell.h
//  newsPicks
//
//  Created by dengqixiang on 14-8-31.
//  Copyright (c) 2014年 dengqixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NPMainViewController.h"
#import "NPFollowCell.h"
#import "NPUserDetaiInfolModel.h"
#import "NPUserDetailViewController.h"
#import "NPNewsListViewController_ipad.h"
#import "SVProgressHUD.h"
@interface RightViewCell : UICollectionViewCell
@property (strong, nonatomic) UILabel* label;
@property (strong, nonatomic) UIImageView* image;
@property (strong,nonatomic) NSArray *contentarray;
@property (strong,nonatomic) NSString* title;
@property (strong,nonatomic)UIView *backView;
@property (assign)UIColor* color;
@property (strong,nonatomic)UIViewController *parentViewController;
@end
