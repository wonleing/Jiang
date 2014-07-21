//
//  NPNewListTopScrollView.h
//  newsPicks
//
//  Created by yunqi on 14-7-21.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NPNewListTopScrollViewDelegate<NSObject>
@optional
-(void)NPNewListTopScrollViewSelectedIndex:(NSInteger)index;
@end
@interface NPNewListTopScrollView : UIScrollView
{
    @private
    NSMutableArray *buttonList;
}
@property(nonatomic,strong)NSArray *nameList;
@property (nonatomic,strong)UIColor *defaultColor;
@property(nonatomic,strong)UIColor *selectedColor;
@property(nonatomic,weak) id<NPNewListTopScrollViewDelegate>delegateListTop;
-(void)restSelectedColor:(NSInteger )selectedIndex;

@end
