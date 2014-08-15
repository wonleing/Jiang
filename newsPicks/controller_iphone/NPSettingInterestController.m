//
//  NPSettingInterestController.m
//  newsPicks
//
//  Created by yunqi on 14-7-28.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "NPSettingInterestController.h"

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
    _array = [[NSMutableArray alloc]initWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"com.zhangcheng.categoryArray"]];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text=[NSString stringWithFormat:@"category %d",indexPath.row];
    cell.accessoryType=[_array indexOfObject:[NSNumber numberWithInt:indexPath.row]]==NSNotFound?UITableViewCellAccessoryNone:UITableViewCellAccessoryCheckmark;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    int index =[_array indexOfObject:[NSNumber numberWithInt:indexPath.row]];
    if (index == NSNotFound) {
        [_array addObject:[NSNumber numberWithInt:indexPath.row]];
        UITableViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType=UITableViewCellAccessoryCheckmark;
    }else{
        [_array removeObject:[NSNumber numberWithInt:indexPath.row]];
        UITableViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType=UITableViewCellAccessoryNone;
    }
    [[NSUserDefaults standardUserDefaults]setObject:[NSArray arrayWithArray:_array] forKey:@"com.zhangcheng.categoryArray"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

@end
