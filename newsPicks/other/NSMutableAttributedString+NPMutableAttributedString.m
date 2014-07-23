//
//  NSMutableAttributedString+NPMutableAttributedString.m
//  newsPicks
//
//  Created by yunqi on 14-7-23.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "NSMutableAttributedString+NPMutableAttributedString.h"
#import <CoreText/CoreText.h>
@implementation NSMutableAttributedString (NPMutableAttributedString)
+(NSMutableAttributedString *)attributedStringWith:(UIFont *)font lineSpace:(float)lineSpace textColor:(UIColor *)textColor content:(NSString *)content
{
    NSMutableAttributedString *newStr = [[NSMutableAttributedString alloc] initWithString:content];
    [newStr setFont:font];
    [newStr setLineSpace:lineSpace];
    if (textColor) {
        [newStr addAttribute:NSForegroundColorAttributeName
                       value:textColor
                       range:NSMakeRange(0, newStr.string.length)];
    }
   
    return newStr;
}
-(void)setLineSpace:(float)lineSpace
{
    NSRange allTextRange = NSMakeRange(0, [self.string length]);
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentLeft;
    paragraphStyle.lineSpacing = lineSpace;
    [self addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:allTextRange];
}
- (void)setFont:(UIFont*)font
{
    [self setFont:font range:NSMakeRange(0, [self length])];
}

- (void)setFont:(UIFont*)font range:(NSRange)range
{
    if (font)
    {
        [self removeAttribute:(NSString*)kCTFontAttributeName range:range];
        
        CTFontRef fontRef = CTFontCreateWithName((__bridge void *)font.fontName, font.pointSize, nil);
        if (nil != fontRef)
        {
            [self addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)fontRef range:range];
            CFRelease(fontRef);
        }
    }
}
+(CGSize)adjustSizeWithAttributedString:(NSAttributedString *)attributedString MaxWidth:(CGFloat)width;
{
    CTFramesetterRef framesetter =
    CTFramesetterCreateWithAttributedString((__bridge CFMutableAttributedStringRef)attributedString);
    CGSize maxSize = CGSizeMake(width, CGFLOAT_MAX);
    CGSize size = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0), NULL, maxSize, NULL);
    
    CFRelease(framesetter);
    return CGSizeMake(floor(size.width) + 1, floor(size.height) + 1);
}
@end
