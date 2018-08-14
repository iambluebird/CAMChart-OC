//
//  CAMColorKit.m
//  CAMChartDemo
//
//  Created by 欧阳峰 on 2018/8/13.
//  Copyright © 2018年 欧阳峰. All rights reserved.
//

#import "CAMColorKit.h"

@implementation CAMColorKit

+(UIColor*)deepenWithColor:(UIColor*)color{
    CGFloat r=0.0, g=0.0, b=0.0, a=0.0;
    CGColorRef cr = color.CGColor;
    NSInteger numComponents = CGColorGetNumberOfComponents(cr);
    if(numComponents==4){
        const CGFloat *components = CGColorGetComponents(cr);
        r = components[0] * 255.0f;
        g = components[1] * 255.0f;
        b = components[2] * 255.0f;
        a = components[3] * 255.0f;
    }
    
    CGFloat offset = 30.0f;
    r = r < offset ? 0 : r - offset;
    g = g < offset ? 0 : g - offset;
    b = b < offset ? 0 : b - offset;
    
    UIColor *newColor = [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a/255.0f];
    return newColor;
}

+(UIColor*)weakenWithColor:(UIColor*)color{
    CGFloat r=0.0, g=0.0, b=0.0, a=0.0;
    CGColorRef cr = color.CGColor;
    NSInteger numComponents = CGColorGetNumberOfComponents(cr);
    if(numComponents==4){
        const CGFloat *components = CGColorGetComponents(cr);
        r = components[0] * 255.0f;
        g = components[1] * 255.0f;
        b = components[2] * 255.0f;
        a = components[3] * 255.0f;
    }
    
    CGFloat offset = 30.0f;
    r = r > 255.0f - offset ? 255.0f : r + offset;
    g = g > 255.0f - offset ? 255.0f : g + offset;
    b = b > 255.0f - offset ? 255.0f : b + offset;
    
    UIColor *newColor = [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a/255.0f];
    return newColor;
}

+ (UIColor *)colorWithHex:(NSString *)hexString{
    
    hexString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([hexString hasPrefix:@"0X"]) hexString = [hexString substringFromIndex:2];
    if ([hexString hasPrefix:@"#"]) hexString = [hexString substringFromIndex:1];
    if(hexString.length != 6 && hexString.length != 8) return [UIColor clearColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //0
    NSString *rStr = [hexString substringWithRange:range];
    //2
    range.location += range.length;
    NSString *gStr = [hexString substringWithRange:range];
    //4
    range.location += range.length;
    NSString *bStr = [hexString substringWithRange:range];
    //6...if hexString.length isEqual 8.
    NSString *aStr = nil;
    if(hexString.length == 8){
        range.location += range.length;
        aStr = [hexString substringWithRange:range];
    }
    
    unsigned int r, g, b, a;
    a = 255;
    [[NSScanner scannerWithString:rStr] scanHexInt:&r];
    [[NSScanner scannerWithString:gStr] scanHexInt:&g];
    [[NSScanner scannerWithString:bStr] scanHexInt:&b];
    if(aStr) [[NSScanner scannerWithString:aStr] scanHexInt:&a];
    
    UIColor *result = [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:a / 255.0f];
    return result;
}

@end
