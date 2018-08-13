//
//  CAMTextKit.h
//  CAMChartDemo
//
//  Created by 欧阳峰 on 2018/8/9.
//  Copyright © 2018年 欧阳峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CAMTextKit : NSObject

+ (CGSize)sizeOfString:(NSString*)text Font:(UIFont*)font Width:(CGFloat)width;

+ (void)drawText:(NSString*)text InRect:(CGRect)rect Font:(UIFont*)font Color:(UIColor*)color;

@end
