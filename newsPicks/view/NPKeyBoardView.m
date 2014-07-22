//
//  NPKeyBoardView.m
//  newsPicks
//
//  Created by yunqi on 14-7-22.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "NPKeyBoardView.h"
#import "AppDelegate.h"
@interface NPKeyBoardView()<UITextViewDelegate>
{
    UITapGestureRecognizer *tapGes;
    float yHeight;
}
@property (nonatomic,assign) CGFloat textViewWidth;
@property (nonatomic,assign) BOOL isChange;
@property (nonatomic,assign) BOOL reduce;
@property (nonatomic,assign) CGRect originalKey;
@property (nonatomic,assign) CGRect originalText;
@end
@implementation NPKeyBoardView
@synthesize textView=_textView;
@synthesize delegate=_delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initTextView:frame];
    }
    return self;
}
+(NPKeyBoardView*)share
{
    static dispatch_once_t onceToken;
    static NPKeyBoardView *keyboadr=nil;
    dispatch_once(&onceToken, ^{
        keyboadr= [[NPKeyBoardView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, NPKeyBoardView_Hight)];
        [((AppDelegate*)[UIApplication sharedApplication].delegate).window addSubview:keyboadr];
    });
//    keyboadr.textView.inputAccessoryView=keyboadr;
    return keyboadr;
}
-(void)initTextView:(CGRect)frame
{
    self.headImageView=[[UIImageView alloc] init];
    self.headImageView.frame=CGRectMake(kStartLocation, kStartLocation, NPKeyBoardView_imageView_width, NPKeyBoardView_imageView_width);
    [self addSubview:self.headImageView];
    
    self.backgroundColor=[UIColor lightGrayColor];
    self.textView=[[UITextView alloc]init];
    self.textView.delegate=self;
    CGFloat textX=self.headImageView.frame.size.width+self.headImageView.frame.origin.x+kStartLocation;
    self.textViewWidth=frame.size.width-textX-kStartLocation*2-NPKeyBoardView_picksBtn_width;
    self.textView.frame=CGRectMake(textX, kStartLocation,self.textViewWidth , NPKeyBoardView_picksBtn_hight);
    self.textView.backgroundColor=[UIColor colorWithRed:233.0/255 green:232.0/255 blue:250.0/255 alpha:1.0];
    self.textView.font=[UIFont systemFontOfSize:20.0];
    [self addSubview:self.textView];
    self.textView.inputAccessoryView=self;
}
-(void)addNotification
{
    [self removeNotification];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyDidshow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
-(void)removeNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)beginEditTextView:(NSNotification *)notification
{
    
    if ([[notification object]isEqual:self.textView]) {
         UIWindow *window=((AppDelegate*)[UIApplication sharedApplication].delegate).window;
        if (!tapGes) {
            
            tapGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(regist)];
            [window addGestureRecognizer:tapGes];
        }else
        {
            if ([window.gestureRecognizers indexOfObject:tapGes]==NSNotFound) {
                [window addGestureRecognizer:tapGes];
            }
        }
    }
}
-(void)hiden
{
    [self.textView resignFirstResponder];
    self.textView.text=nil;
    self.textView.inputView=nil;
    [self.textView reloadInputViews ];
    
}
-(void)show
{
    [self.textView becomeFirstResponder];
    
}
-(void)regist
{
    [self hiden];
}
-(void)willshow:(NSNotification *)notification
{
    
    if (self.superview!=nil) {
        if (![self.superview viewWithTag:1111]) {
            UIControl *control=[[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
            [control addTarget:self action:@selector(regist) forControlEvents:UIControlEventTouchUpInside];
            [self.superview addSubview:control];
            control.tag=1111;
        }
        
        [self.superview bringSubviewToFront:self];
        
    }
    NSValue* aValue = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSDictionary *userInfo = [notification userInfo];
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    CGRect keyboardRect = [aValue CGRectValue];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    if (yHeight>=self.superview.frame.size.height) {
        if (IOS7_OR_LATER) {
            self.frame=CGRectMake(self.frame.origin.x,self.superview.frame.size.height- (keyboardRect.size.height-([UIScreen mainScreen].bounds.size.height-self.superview.frame.origin.y-self.superview.frame.size.height))-self.frame.size.height, self.frame.size.width, self.frame.size.height);
        }else
        {
//            self.frame=CGRectMake(self.frame.origin.x, self.superview.frame.size.height-keyboardRect.size.height-self.frame.size.height+([self viewController].tabBarController.tabBar.hidden?0:49), self.frame.size.width, self.frame.size.height);
        }
    }
    else
    {
        self.frame=CGRectMake(self.frame.origin.x, yHeight-keyboardRect.size.height, self.frame.size.width, self.frame.size.height);
    }
    [UIView commitAnimations];
//    if (delegate&&[delegate respondsToSelector:@selector(textKeyBoardViewKeyboardFrameChange:)]) {
//        [delegate textKeyBoardViewKeyboardFrameChange:keyboardRect.size.height];
//    }
    
}

//键盘出现事件
-(void)keyDidshow:(NSNotification *)notification
{
    if (self) {
        [self performSelector:@selector(willshow:) withObject:notification afterDelay:0];
    }
}
-(void)endEditTextView:(NSNotification *)notification
{
    UIWindow *window=((AppDelegate*)[UIApplication sharedApplication].delegate).window;
    [window removeGestureRecognizer:tapGes];
    tapGes=nil;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]){
        
        if([self.delegate respondsToSelector:@selector(keyBoardViewHide: textView:)]){
            
            [self.delegate keyBoardViewHide:self textView:self.textView];
        }
        [self regist];
        return NO;
    }
    
    return YES;
}

-(void)textViewDidChange:(UITextView *)textView
{
//    NSString *content=textView.text;
//    
//    CGSize contentSize=[content sizeWithFont:[UIFont systemFontOfSize:20.0]];
//    if(contentSize.width>self.textViewWidth){
//        
//        if(!self.isChange){
//            
//            CGRect keyFrame=self.frame;
//            self.originalKey=keyFrame;
//            keyFrame.size.height+=keyFrame.size.height;
//            keyFrame.origin.y-=keyFrame.size.height*0.25;
//            self.frame=keyFrame;
//            
//            CGRect textFrame=self.textView.frame;
//            self.originalText=textFrame;
//            textFrame.size.height+=textFrame.size.height*0.5+kStartLocation*0.2;
//            self.textView.frame=textFrame;
//            self.isChange=YES;
//            self.reduce=YES;
//        }
//    }
//    
//    if(contentSize.width<=self.textViewWidth){
//        
//        if(self.reduce){
//            
//            self.frame=self.originalKey;
//            self.textView.frame=self.originalText;
//            self.isChange=NO;
//            self.reduce=NO;
//        }
//    }
}



@end
