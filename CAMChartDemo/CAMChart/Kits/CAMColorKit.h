//
//  CAMColorKit.h
//  CAMChartDemo
//
//  Created by 欧阳峰 on 2018/8/13.
//  Copyright © 2018年 欧阳峰. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CAMHEXCOLOR(hexStr) [CAMColorKit colorWithHex:hexStr]

@interface CAMColorKit : NSObject


/**
 颜色加深

 @param color color
 @return new color
 */
+(UIColor*)deepenWithColor:(UIColor*)color;


/**
 颜色变浅

 @param color color
 @return new color
 */
+(UIColor*)weakenWithColor:(UIColor*)color;

+(UIColor*)colorWithHex:(NSString*)hexString;

@end
