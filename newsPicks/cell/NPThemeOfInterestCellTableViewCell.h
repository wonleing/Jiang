//
//  NPThemeOfInterestCellTableViewCell.h
//  newsPicks
//
//  Created by kangxv on 14-8-16.
//  Copyright (c) 2014年 kangxv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NPThemeOfInterestCellTableViewCell : UITableViewCell

@property (retain, nonatomic) UILabel *conte_text;

- (void)selected_cell:(BOOL )isSelect;
@end
