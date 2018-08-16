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
#import "CAMCircleAxisProfile.h"
#import "CAMTextKit.h"




@interface CAMCoordinateAxisKit : NSObject


/**
 绘制XY坐标系
 
 说明：XY坐标系与具体的数值没有关系，只会依赖轴标签进行绘制，如需绘制指定尺度的坐标系，需要按尺度及分布生成步进标签即可。
 即使是不显示坐标标签的情况，也需要设置标签以实现坐标尺度控制。
 注意：如果不设置坐标标签，统计图会自动计算出数据依赖的X轴标签和Y轴标签数量，具体标签值会根据数据进行推算。
 
 @param rect 整体视图区域
 @param profile 配置信息
 @param canvasMargin 图表外边距：轴与整体视图之间的边距
 @param canvasPadding 图表内边距：轴与可视区域之间的距离
 @param xUnit X坐标单位标签内容
 @param yUnit Y坐标单位标签内容
 @param xLabels X坐标标签
 @param yLabels Y坐标标签
 */
-(void)drawXYCoordinateWithRect:(CGRect)rect AxisProfile:(CAMXYAxisProfile*)profile CanvasMargin:(CGFloat)canvasMargin CanvasPadding:(CGFloat)canvasPadding xUnit:(nullable NSString*)xUnit yUnit:(nullable NSString*)yUnit xLabels:(nullable NSArray*)xLabels yLabels:(nullable NSArray*)yLabels;



/**
 绘制圆环型坐标系

 @param rect 坐标视图区域
 @param profile 配置信息
 @param topTag 上标签内容
 @param bottomTag 下标签内容
 @param valueRect 值标签显示区域
 */
-(void)drawCircleCoordinateWithRect:(CGRect)rect AxisProfile:(CAMCircleAxisProfile *)profile TopTag:(NSString*)topTag bottomTag:(NSString*)bottomTag ValueRect:(CGRect)valueRect;

@end
