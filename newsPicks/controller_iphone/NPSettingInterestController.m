//
//  NPSettingInterestController.m
//  newsPicks
//
//  Created by yunqi on 14-7-28.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "NPSettingInterestController.h"
#import "NPThemeOfInterestCellTableViewCell.h"

@interface NPSettingInterestController ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *_array;
}

@end

@implementation NPSettingInterestController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=@"Theme of Interest";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
}

- (void)initData
{
    _array = [[NSMutableArray alloc]initWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"com.zhangcheng.categoryArray"]];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(NPThemeOfInterestCellTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NPThemeOfInterestCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell = [[NPThemeOfInterestCellTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.conte_text.text = [NSString stringWithFormat:@"category %d",(int)indexPath.row];
    [cell selected_cell:[_array indexOfObject:[NSNumber numberWithInt:indexPath.row]]==NSNotFound?NO:YES];
//    cell.accessoryType=[_array indexOfObject:[NSNumber numberWithInt:indexPath.row]]==NSNotFound?UITableViewCellAccessoryNone:UITableViewCellAccessoryCheckmark;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger index =[_array indexOfObject:[NSNumber numberWithInt:indexPath.row]];
    if (index == NSNotFound) {
        [_array addObject:[NSNumber numberWithInt:indexPath.row]];
        NPThemeOfInterestCellTableViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];
        [cell selected_cell:YES];
    }else{
        [_array removeObject:[NSNumber numberWithInt:indexPath.row]];
        NPThemeOfInterestCellTableViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];
//        cell.accessoryType=UITableViewCellAccessoryNone;
        [cell selected_cell:NO];
    }
    [[NSUserDefaults standardUserDefaults]setObject:[NSArray arrayWithArray:_array] forKey:@"com.zhangcheng.categoryArray"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

@end
