//
//  NSMutableAttributedString+NPMutableAttributedString.h
//  newsPicks
//
//  Created by yunqi on 14-7-23.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (NPMutableAttributedString)
+(NSMutableAttributedString *)attributedStringWith:(UIFont *)font lineSpace:(float)lineSpace textColor:(UIColor *)textColor content:(NSString *)content;
+(CGSize)adjustSizeWithAttributedString:(NSAttributedString *)attributedString MaxWidth:(CGFloat)width;
@end
