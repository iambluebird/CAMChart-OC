//
//  CAMTextKit.m
//  CAMChartDemo
//
//  Created by 欧阳峰 on 2018/8/9.
//  Copyright © 2018年 欧阳峰. All rights reserved.
//

#import "CAMTextKit.h"

@implementation CAMTextKit

+ (CGSize)sizeOfString:(NSString *)text Font:(UIFont *)font Width:(CGFloat)width{
    
    CGSize size = CGSizeMake(width, MAXFLOAT);
    
    NSMutableParagraphStyle *priceParagraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    priceParagraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    priceParagraphStyle.alignment = NSTextAlignmentLeft;
    
    NSDictionary *tdic = @{NSParagraphStyleAttributeName: priceParagraphStyle, NSFontAttributeName: font};
    
    size = [text boundingRectWithSize:size
                              options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine
                           attributes:tdic
                              context:nil].size;
    
    return size;
}

+ (void)drawText:(NSString*)text InRect:(CGRect)rect Font:(UIFont*)font Color:(UIColor*)color{
    NSMutableParagraphStyle *priceParagraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    priceParagraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    priceParagraphStyle.alignment = NSTextAlignmentLeft;
    
    if (color != nil) {
        [text drawInRect:rect
          withAttributes:@{NSParagraphStyleAttributeName: priceParagraphStyle, NSFontAttributeName: font,
                           NSForegroundColorAttributeName: color}];
    } else {
        [text drawInRect:rect
          withAttributes:@{NSParagraphStyleAttributeName: priceParagraphStyle, NSFontAttributeName: font}];
    }
}

@end
