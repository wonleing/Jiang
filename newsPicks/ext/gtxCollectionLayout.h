//
//  gtxCollectionLayout.h
//  Animation
//
//  Created by dengqixiang on 14-7-25.
//  Copyright (c) 2014年 gtx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface gtxCollectionLayout : UICollectionViewLayout
// 每个item上方固定偏移
@property (assign, nonatomic) CGFloat topReveal;
@property (assign, nonatomic) CGSize itemSize;
@property (nonatomic, assign) CGFloat tanTheta;
@property (nonatomic, assign) CGFloat offsetY;
@property (nonatomic, assign) CGFloat offsetX;
@property (nonatomic, assign) NSInteger cellCount;
@end
