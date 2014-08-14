//
//  NPTimeOnlineCell_iPad.h
//  newsPicks
//
//  Created by ZhangCheng on 14-8-6.
//  Copyright (c) 2014年 ZhangCheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NPCellDelegate.h"
@interface NPTimeOnlineCell_iPad : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *backBtn1;
@property (weak, nonatomic) IBOutlet UIButton *pickBtn1;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel1;
@property (weak, nonatomic) IBOutlet UIButton *backBtn2;
@property (weak, nonatomic) IBOutlet UIButton *pickBtn2;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel2;
@property (weak, nonatomic) IBOutlet UIButton *backBtn3;
@property (weak, nonatomic) IBOutlet UIButton *pickBtn3;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel3;
@property (weak, nonatomic) IBOutlet UIButton *backBtn4;
@property (weak, nonatomic) IBOutlet UIButton *pickBtn4;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel4;
@property (weak, nonatomic) IBOutlet UIButton *backBtn5;
@property (weak, nonatomic) IBOutlet UIButton *pickBtn5;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel5;
@property (weak, nonatomic) IBOutlet UIView *mContentView;

@property (assign, nonatomic) IBOutlet id<NPTimeOnlineCellDelegate_iPad> delegate;
@property (strong,nonatomic)NSArray *modelArray;
-(void)restCell:(NSArray *)array;
@end
