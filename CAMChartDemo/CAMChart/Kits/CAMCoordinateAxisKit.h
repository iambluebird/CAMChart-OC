//
//  CAMCoordinateAxisKit.h
//  CAMChartDemo
//  坐标轴绘制工具
//  Created by 欧阳峰 on 2018/8/9.
//  Copyright © 2018年 欧阳峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CAMMacroDefinition.h"
#import "CAMXYAxisProfile.h"
#import "CAMTextKit.h"




@interface CAMCoordinateAxisKit : NSObject


/**
 绘制XY坐标系

 @param rect 整体视图区域
 @param profile 配置信息
 @param canvasMargin 图表外边距：轴与整体视图之间的边距
 @param canvasPadding 图表内边距：轴与可视区域之间的距离
 @param xUnit X坐标单位标签内容
 @param yUnit Y坐标单位标签内容
 @param xLabels X坐标标签
 @param yLabels Y坐标标签
 */
-(void)drawXYCoordinateWithRect:(CGRect)rect ChartProfile:(CAMXYAxisProfile*)profile CanvasMargin:(CGFloat)canvasMargin CanvasPadding:(CGFloat)canvasPadding xUnit:(nullable NSString*)xUnit yUnit:(nullable NSString*)yUnit xLabels:(nullable NSArray*)xLabels yLabels:(nullable NSArray*)yLabels;

@end
