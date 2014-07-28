//
//  NPMainleftView.h
//  newsPicks
//
//  Created by yunqi on 14-7-28.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NPMainleftViewDelegate<NSObject>
@optional
-(void)NPMainleftViewClickOne;
-(void)NPMainleftViewClickTwo;
-(void)NPMainleftViewClickThree;
@end
@interface NPMainleftView : UIView
@property(nonatomic,assign)id<NPMainleftViewDelegate>delegate;
+(NPMainleftView *)mainLeftView;
@end
