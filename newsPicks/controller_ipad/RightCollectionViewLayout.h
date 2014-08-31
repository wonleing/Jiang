//
//  RightCollectionViewLayout.h
//  newsPicks
//
//  Created by dengqixiang on 14-8-31.
//  Copyright (c) 2014年 dengqixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RightCollectionViewLayout : UICollectionViewLayout
// 每个item上方固定偏移
@property (assign, nonatomic) CGFloat topReveal;
@property (assign, nonatomic) CGSize itemSize;
@property (nonatomic, assign) CGFloat tanTheta;
@property (nonatomic, assign) CGFloat offsetY;
@property (nonatomic, assign) CGFloat offsetX;
@property (nonatomic, assign) NSInteger cellCount;
- (CGFloat) getTopReveal;
@end
