//
//  RightViewCell.m
//  newsPicks
//
//  Created by dengqixiang on 14-8-31.
//  Copyright (c) 2014年 dengqixiang. All rights reserved.
//

#import "RightViewCell.h"

@interface RightViewCell()<UITableViewDataSource,UITableViewDelegate,NPFollowCellDelegate> // 添加任何需要的delegate
{
    NSMutableArray *list;
    
    NSString *_uid;
    int currentPage;
    BOOL isNib;

}
@property(nonatomic,strong)    UITableView *tableView;
;
@end


@implementation RightViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.layer.cornerRadius = 0.0;
        self.contentView.layer.borderWidth = 1.0f;
        self.contentView.layer.borderColor = [UIColor grayColor].CGColor;
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(40, 5, 200, 32)];
        self.label.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
        self.label.textColor = [UIColor whiteColor];
//        self.label.backgroundColor = [UIColor whiteColor];
        self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)];
        [ self.backView setBackgroundColor:[UIColor blackColor]];
               [self addSubview: self.backView];
        if(self.label)
            [ self.backView addSubview:self.label];
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, self.frame.size.width - 40, self.frame.size.height - 20) style:UITableViewStylePlain];
         self.tableView.delegate = self;
         self.tableView.dataSource = self;
        [self addSubview: self.tableView];
        _uid = [[NSUserDefaults standardUserDefaults]objectForKey:@"com.zhangcheng.uid"];
        currentPage=0;
        
        list=[[NSMutableArray alloc]init];
        [self loadMore];
    }
    return self;

}
-(void)setColor:(UIColor *)color
{
    _backView.backgroundColor = color;
}
-(void)setTitle:(NSString *)title
{
    self.label.text = title;
}
-(void)setContentarray:(NSArray *)contentarray
{
    list = [NSMutableArray arrayWithArray:contentarray];
    [self.tableView reloadData];
}
-(void)loadMore
{
    [NPHTTPRequest getRecommandUser:_uid page:1 usingSuccessBlock:^(BOOL isSuccess, NSArray *result) {
        if (isSuccess) {
            //            currentPage++;
            [list removeAllObjects];
            [list addObjectsFromArray:result];
            [ self.tableView reloadData];
        }
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return list.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [NPFollowCell cellHight];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"checkID";
    NPFollowCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        if (isNib) {
            cell=[[NPFollowCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
        }else{
            cell=[[NPFollowCell alloc]initWithStyle2:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
        }
        cell.selectionStyle=UITableViewCellSelectionStyleGray;
        cell.delegate=self;
    }
    [cell restSubView:[list objectAtIndex:indexPath.row]];
    return cell;
}
-(void)NPFollowCellClickFollowing:(NPFollowCell *)cell
{
    NPUserDetaiInfolModel *infoModel=[list objectAtIndex:[ self.tableView indexPathForCell:cell].row];
    if (infoModel.is_following.boolValue) {
        infoModel.is_following=@"0";
        [NPHTTPRequest getUnfollowUser:_uid targetUser:infoModel.uid usingSuccessBlock:^(BOOL isSuccess, NSDictionary *dic) {
            if(isSuccess){
                
            }else{
                [SVProgressHUD showErrorWithStatus:dic[@"message"]];
            }
        }];
    }else
    {
        infoModel.is_following=@"1";
        [NPHTTPRequest getFollowUser:_uid targetUser:infoModel.uid usingSuccessBlock:^(BOOL isSuccess, NSDictionary *dic) {
            if(isSuccess){
                
            }else{
                [SVProgressHUD showErrorWithStatus:dic[@"message"]];
            }
        }];
    }
    [ self.tableView reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NPUserDetaiInfolModel *infoModel=[list objectAtIndex:indexPath.row];
    
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
    NPNewsListViewController_ipad *viewController = [main instantiateInitialViewController];
    viewController.isNotSelf=YES;
    
    viewController.uid=infoModel.uid;
    ((NPMainViewController*)self.parentViewController).navigationController.navigationBar.hidden=NO;
    [((NPMainViewController*)self.parentViewController).navigationController pushViewController:viewController animated:YES];
}
//    
//    ((NPMainViewController*)self.parentViewController).navigationController.navigationBar.hidden=NO;
//    
//    [((NPMainViewController*)self.parentViewController).navigationController pushViewController:viewController animated:YES];
//}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
