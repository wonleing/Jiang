//
//  NPKeyBoardView.h
//  newsPicks
//
//  Created by yunqi on 14-7-22.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kStartLocation 5
#define NPKeyBoardView_imageView_width 30
#define NPKeyBoardView_picksBtn_width 40
#define NPKeyBoardView_picksBtn_hight 30

#define NPKeyBoardView_Hight 44+40
@class NPKeyBoardView;
@protocol NPKeyBoardViewDelegate <NSObject>
@optional
-(void)keyBoardViewHide:(NPKeyBoardView *)keyBoardView textView:(UITextView *)contentView;
@end
@interface NPKeyBoardView : UIView
{
    
}
@property(nonatomic,strong)UIImageView *headImageView;
@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,assign) id<NPKeyBoardViewDelegate> delegate;
+(NPKeyBoardView*)share;
-(void)show;
-(void)hiden;
@end
