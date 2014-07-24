//
//  NPCustomMethod.m
//  newsPicks
//
//  Created by yunqi on 14-7-23.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "NPCustomMethod.h"
#import "TTTAttributedLabel.h"
@implementation NPCustomMethod
+(NSArray *)matchesInString:(NSString *)reges string:(NSString *)content;
{
    NSRegularExpression *exp_emoji =
    [[NSRegularExpression alloc] initWithPattern:reges
                                         options:NSRegularExpressionCaseInsensitive| NSRegularExpressionDotMatchesLineSeparators
                                           error:nil];
	return  [exp_emoji matchesInString:content
                               options:NSRegularExpressionCaseInsensitive | NSRegularExpressionDotMatchesLineSeparators
                                 range:NSMakeRange(0, [content length])];
    
   

    
}
+(NSArray*)sortNewsListKey:(NSDictionary*)dic
{
    NSArray *allkey=[dic allKeys];
    
    NSMutableArray  *listKey=[NSMutableArray array];
    if ([allkey containsObject:kNPNewListTitleKey_Srending_comment]) {
        [listKey addObject:kNPNewListTitleKey_Srending_comment];
    }
    if ([allkey containsObject:kNPNewListTitleKey_Followings]) {
        [listKey addObject:kNPNewListTitleKey_Followings];
    }
    if ([allkey containsObject:kNPNewListTitleKey_Others]) {
        [listKey addObject:kNPNewListTitleKey_Others];
    }
    return listKey;
}

+(void)matchesInStringUrl:(TTTAttributedLabel *)label;
{
    NSArray *arryHttps=[NPCustomMethod matchesInString:kRegexURLlink string:label.attributedText.string];
    for (NSTextCheckingResult *result in arryHttps) {
		NSRange range = result.range;
        [label addLinkToURL:[NSURL URLWithString: [label.attributedText.string substringWithRange:range]] withRange:range];
	}
}
+(UIImage *) createImageWithColor: (UIColor *) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
+(UIImage *) createImageWithColor: (UIColor *) color size:(CGSize)size
{
    CGRect rect=CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
@end
