//
//  NPTextInputViewController.h
//  newsPicks
//
//  Created by ZhangCheng on 14-8-9.
//  Copyright (c) 2014年 ZhangCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NPTextInputViewController : UIViewController
@property(weak,nonatomic)IBOutlet UILabel *titleLabel;
@property(weak,nonatomic)IBOutlet UITextView *textView;
@property(weak,nonatomic)NSNumber *uid;
@property(copy,nonatomic)NSString *tid;
@property(copy,nonatomic)NSString *mTitle;
-(IBAction)sendAction:(id)sender;
@end
