//
//  CAMCoordinateAxisKit.h
//  CAMChartDemo
//  坐标轴绘制工具
//  Created by 欧阳峰 on 2018/8/9.
//  Copyright © 2018年 欧阳峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CAMMacroDefinition.h"
#import "CAMChartProfile.h"
#import "CAMTextKit.h"

@interface CAMCoordinateAxisKit : NSObject


-(void)drawXYCoordinateWithRect:(CGRect)rect ChartProfile:(CAMChartProfile*)profile xUnit:(nullable NSString*)xUnit yUnit:(nullable NSString*)yUnit xLabels:(nullable NSArray*)xLabels yLabels:(nullable NSArray*)yLabels;

@end
