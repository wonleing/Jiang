//
//  NPUserInfoDetailHeadView.m
//  newsPicks
//
//  Created by yunqi on 14-7-24.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "NPUserInfoDetailHeadView.h"

#import "NSString+BundleExtensions.h"
#import "UIFont+CoreTextExtensions.h"
#import "NPUserDetailView.h"
#import "NPUserDetaiInfolModel.h"
#import "NPUserFollowNumButton.h"
#import "NPUserFollowingButton.h"
#define NPUserInfoDetailHeadView_higth 160
#define NPUserInfoDetailHeadView_content_higth 100
@interface NPUserInfoDetailHeadView()<AKOMultiColumnTextViewDataSource>
{
    
}
@end
@implementation NPUserInfoDetailHeadView
@synthesize multiPageView=_multiPageView;
@synthesize detailView=_detailView;
@synthesize followersNumBtn=_followersNumBtn;
@synthesize followingNumBtn=_followingNumBtn;
@synthesize followingBtn=_followingBtn;
@synthesize delegate=_delegate;
+(NPUserInfoDetailHeadView *)userInfoDetailHeadView
{
    return [[NPUserInfoDetailHeadView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, NPUserInfoDetailHeadView_higth)];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubView];
        // Initialization code
    }
    return self;
}
-(void)initSubView
{
    
    _multiPageView=[[AKOMultiPageTextView alloc] init];
    _multiPageView.frame=CGRectMake(0, 0, self.frame.size.width, NPUserInfoDetailHeadView_content_higth);
    _multiPageView.dataSource = self;
    _multiPageView.text=@"";
    _multiPageView.columnInset = CGPointMake(10, 10);
    _multiPageView.font = [UIFont systemFontOfSize:14];
    _multiPageView.columnCount = 1;
    _multiPageView.backgroundColor=[UIColor clearColor];
    [self addSubview:_multiPageView];
     _detailView=[[NPUserDetailView alloc] init];
    
    _followingNumBtn=[NPUserFollowNumButton buttonWithType:UIButtonTypeCustom];
    _followingNumBtn.backgroundColor=[UIColor colorWithRed:18.0f/255.0f green:26.0f/255.0f blue:80.0f/255.0f alpha:1];
    _followingNumBtn.frame=CGRectMake(_multiPageView.columnInset.x, _multiPageView.frame.size.height+_multiPageView.frame.origin.y, 55, 40);
    [_followingNumBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _followingNumBtn.titleLabel.font=[UIFont boldSystemFontOfSize:17];
    [_followingNumBtn addTarget:self action:@selector(checkFollowing:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_followingNumBtn];
    
    _followersNumBtn=[NPUserFollowNumButton buttonWithType:UIButtonTypeCustom];
    _followersNumBtn.backgroundColor=_followingNumBtn.backgroundColor;
    _followersNumBtn.frame=CGRectMake(_followingNumBtn.frame.size.width+_followingNumBtn.frame.origin.x+1, _followingNumBtn.frame.origin.y, _followingNumBtn.frame.size.width, _followingNumBtn.frame.size.height);
    [_followersNumBtn addTarget:self action:@selector(checkFollowers:) forControlEvents:UIControlEventTouchUpInside];
    [_followersNumBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _followersNumBtn.titleLabel.font=[UIFont boldSystemFontOfSize:17];
    [self addSubview:_followersNumBtn];
    
    _followingBtn=[NPUserFollowingButton buttonWithType:UIButtonTypeCustom];
    _followingBtn.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-_multiPageView.columnInset.x-80, _followingNumBtn.frame.origin.y+5, 70, 30);

    _followingBtn.titleLabel.font=[UIFont systemFontOfSize:11];
    [_followingBtn addTarget:self action:@selector(clickFollowing) forControlEvents:UIControlEventTouchUpInside];
    [_followingBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _followingBtn.hidden=YES;
//    _followingBtn.highlighted=YES;
    [self addSubview:_followingBtn];
}
- (UIView*)akoMultiColumnTextView:(AKOMultiColumnTextView*)textView viewForColumn:(NSInteger)column onPage:(NSInteger)page
{
    if (page == 0 && column == 0)
    {
        if (!_detailView) {
            _detailView=[[NPUserDetailView alloc] init];
        }
        _detailView.frame=CGRectMake(0, 0,_multiPageView.frame.size.width-_multiPageView.columnInset.x*2, _multiPageView.frame.size.height-_multiPageView.columnInset.y);
        return _detailView;
    }
    return nil;
}
-(void)restValue:(NPUserDetaiInfolModel *)infoModel
{
    _multiPageView.text=infoModel.description;
    [_detailView restValue:infoModel];
    [self changeFollowStatus:infoModel.is_following.boolValue];
    _followingNumBtn.descriptionLabel.text=@"Following";
    [_followingNumBtn setTitle:infoModel.following_num forState:UIControlStateNormal];
    
    _followersNumBtn.descriptionLabel.text=@"Followers";
    [_followersNumBtn setTitle:infoModel.followers_num forState:UIControlStateNormal];
}
-(void)changeFollowStatus:(BOOL)follow
{
    _followingBtn.hidden=NO;
    if (!follow) {
        [_followingBtn setTitle:@"follow" forState:UIControlStateNormal];
        [_followingBtn setBackgroundImage:[NPCustomMethod createImageWithColor:NP_MAIN_BACKGROUND_COLOR size:_followingBtn.frame.size] forState:UIControlStateNormal];
        _followingBtn.layer.masksToBounds=YES;
        _followingBtn.layer.cornerRadius=5;
        _followingBtn.layer.borderColor=[[UIColor whiteColor]CGColor];
        _followingBtn.layer.borderWidth=1;
        
    }else
    {
        _followingBtn.layer.borderColor=[[UIColor clearColor]CGColor];
        _followingBtn.layer.borderWidth=0;
        [_followingBtn setTitle:@"following" forState:UIControlStateNormal];
        [_followingBtn setBackgroundImage:[NPCustomMethod createImageWithColor:[UIColor colorWithRed:62.0f/255.0f green:69.0f/255.0f blue:113.0f/255.0f alpha:1] size:_followingBtn.frame.size] forState:UIControlStateNormal];
        
    }
}
-(void)checkFollowing:(id)sender
{
    if (_delegate&&[_delegate respondsToSelector:@selector(NPUserInfoDetailHeadViewCheckFollowing)]) {
        [_delegate NPUserInfoDetailHeadViewCheckFollowing];
    }
    
}
-(void)checkFollowers:(id)sender
{
    if (_delegate&&[_delegate respondsToSelector:@selector(NPUserInfoDetailHeadViewCheckFollowers)]) {
        [_delegate NPUserInfoDetailHeadViewCheckFollowers];
    }
}
-(void)clickFollowing
{
    if (_delegate&&[_delegate respondsToSelector:@selector(NPUserInfoDetailHeadViewClickFollow)]) {
        [_delegate NPUserInfoDetailHeadViewClickFollow];
    }
}
-(void)setFrame:(CGRect)frame
{
    _multiPageView.frame=CGRectMake(0, 0, frame.size.width, NPUserInfoDetailHeadView_content_higth);
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
