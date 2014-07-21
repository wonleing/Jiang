//
//  NPNewListTopScrollView.m
//  newsPicks
//
//  Created by yunqi on 14-7-21.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "NPNewListTopScrollView.h"
#import "NPNewListTopButton.h"
#define NPTopSubView_width [UIScreen mainScreen].bounds.size.width/3.0f
@implementation NPNewListTopScrollView
@synthesize nameList=_nameList;
@synthesize defaultColor=_defaultColor;
@synthesize selectedColor=_selectedColor;
@synthesize delegateListTop=_delegateListTop;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}
-(id)init
{
    if (self=[super init]) {
        _nameList=[[NSArray alloc] init];
        buttonList=[[NSMutableArray alloc] init];
        _defaultColor=[UIColor lightGrayColor];
        _selectedColor=[UIColor grayColor];
    }
    return self;
}
-(void)setNameList:(NSArray *)nameListValue
{
    _nameList=nameListValue;
    [self restList];
}
-(void)restList
{
    [buttonList removeAllObjects];
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[NPNewListTopButton class]]) {
            [view removeFromSuperview];
        }
    }
    float x=0;
    for (NSString *str in _nameList) {
        NPNewListTopButton *btn=[NPNewListTopButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(x, 0,  NPTopSubView_width, self.frame.size.height);
        [btn setTitle:str forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.backgroundColor=self.defaultColor;
        btn.autoresizingMask=UIViewAutoresizingFlexibleHeight;
        [btn addTarget:self action:@selector(newsListClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        x=btn.frame.size.width+btn.frame.origin.x;
        [buttonList addObject:btn];
    }
    if (x>self.frame.size.width) {
        self.contentSize=CGSizeMake(x, self.frame.size.height);
    }else
    {
        self.contentSize=CGSizeMake(self.frame.size.width+2, self.frame.size.height);
    }
    [self restSelectedColor:0];
}
-(void)restSelectedColor:(NSInteger )selectedIndex
{
    for (NPNewListTopButton *btn in self.subviews) {
        [btn setBackgroundColor:self.defaultColor];
    }
    if (buttonList.count>selectedIndex) {
        NPNewListTopButton *btn=[buttonList objectAtIndex:selectedIndex];
        btn.backgroundColor=self.selectedColor;
    }
}
-(void)newsListClick:(NPNewListTopButton *)btn
{
    [self restSelectedColor:[buttonList indexOfObject:btn]];
    if (self.delegateListTop&&[self.delegateListTop respondsToSelector:@selector(NPNewListTopScrollViewSelectedIndex:)]) {
        [self.delegateListTop NPNewListTopScrollViewSelectedIndex:[buttonList indexOfObject:btn]];
    }
}
-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
