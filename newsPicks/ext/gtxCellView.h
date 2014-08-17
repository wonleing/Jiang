//
//  gtxCellView.h
//  Animation
//
//  Created by dengqixiang on 14-7-24.
//  Copyright (c) 2014年 gtx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface gtxCellView : UICollectionViewCell
{
    UIImageView * avatarImageView;
}
@property (strong, nonatomic) UILabel* label;
@property (strong, nonatomic) UIImageView* image;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *imageUrl;
@property (strong,nonatomic) UIView *colorVIew;
@property (strong,nonatomic)UIColor *color;
@end
