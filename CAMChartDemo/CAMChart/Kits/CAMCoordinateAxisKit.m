//
//  CAMCoordinateAxisKit.m
//  CAMChartDemo
//
//  Created by 欧阳峰 on 2018/8/9.
//  Copyright © 2018年 欧阳峰. All rights reserved.
//

#import "CAMCoordinateAxisKit.h"

@implementation CAMCoordinateAxisKit

-(void)drawXYCoordinateWithRect:(CGRect)rect AxisProfile:(CAMXYAxisProfile*)profile CanvasMargin:(CGFloat)canvasMargin CanvasPadding:(CGFloat)canvasPadding xUnit:(nullable NSString*)xUnit yUnit:(nullable NSString*)yUnit xLabels:(nullable NSArray*)xLabels yLabels:(nullable NSArray*)yLabels{
    
    /*
     这个函数好丑，回头重写
     */
    
    CGFloat rectWidth = CGRectGetWidth(rect);
    CGFloat rectHeight = CGRectGetHeight(rect);
    
    //此方法调用前必须确保能得到图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //保存一下初始的上下文场景
    CGContextSaveGState(context);
    
    //设置Chart全局绘制场景，使用圆角模式
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    //开始绘制坐标轴线条
    CGContextSaveGState(context);   // 开启新场景 A ，绘制标签、坐标点等元素
    
    CGFloat axisSeparatorLineWidth = profile.lineWidth / 2;
    UIColor *axisSpearatorColor = profile.lineColor;
    CGContextSetLineWidth(context, axisSeparatorLineWidth);
    CGContextSetStrokeColorWithColor(context, [axisSpearatorColor CGColor]);
    
    //从外向内绘制，才能计算出安全距离
    //绘制坐标标签，只有在绘制坐标轴的情况下，才会绘制对应Label的点
    CGFloat yLabelHoldWidth = 0.0f;     //如果显示了Y轴的Label，此时需要留出这些标签的宽度作为占位
    UIColor *labelColor = profile.xyLabelColor;
    
    NSMutableArray *yPositions = [NSMutableArray new];  //y坐标上的节点位置
    NSMutableArray *xPositions = [NSMutableArray new];  //x坐标上的节点位置
    
    if([yLabels count]){
        //计算出yLabel标签需要预留出的宽度来
        NSMutableArray *yLabelSizes = [NSMutableArray new];
        CGFloat maxValue = 0;
        if(profile.showYLabel){
            CGFloat yLabelMaxWidth = 60.0f;
            //循环得到每个label的尺寸，并找出最大宽度作为水平方向向右偏移量，留出label标签的位置
            
            NSMutableArray *yLabelWidths = [NSMutableArray new];
            for (NSString* text in yLabels) {
                CGSize size = [CAMTextKit sizeOfString:text Font:profile.xyLabelFont Width:yLabelMaxWidth];
                [yLabelSizes addObject: [NSValue valueWithCGSize:size]];
                [yLabelWidths addObject: [NSNumber numberWithFloat:size.width]];
            }
            //以最大的Y轴标签宽度作为占位基准宽度
            maxValue = [[yLabelWidths valueForKeyPath:@"@max.floatValue"] floatValue];
            yLabelHoldWidth = maxValue + CAM_XYCOORDINATE_LABEL_SAVE_OFFSET; //计算出Y轴标签占位宽度，与Y轴之间留出安全距离
        }
        
        //计算出Y轴上节点位置
        CGFloat yStart = rectHeight - canvasMargin - canvasPadding;
        CGFloat yStep = 0;
        
        if(yLabels.count == 1){
            yStart = canvasMargin + canvasPadding + (rectHeight - canvasMargin * 2 - canvasPadding * 2) / 2;
        }else{
            yStep = (rectHeight - canvasMargin * 2 - canvasPadding * 2) / (yLabels.count - 1);
        }
        
        CGFloat yPoint = yStart;
        for (NSInteger i = 0; i < yLabels.count; i++) {
            //label text
            if(profile.showYLabel){
                CGSize size = [yLabelSizes[i] CGSizeValue];
                CGFloat yOffset = size.height / 2;
                CGRect textRect = CGRectMake(canvasMargin + maxValue - size.width, yPoint - yOffset, size.width, size.height);
                [CAMTextKit drawText:yLabels[i] InRect:textRect Font:profile.xyLabelFont Color:labelColor];
            }
            
            //separator
            if(profile.showYAxis){
                CGContextMoveToPoint(context, canvasMargin + yLabelHoldWidth, yPoint - axisSeparatorLineWidth / 2);
                CGContextAddLineToPoint(context, canvasMargin + yLabelHoldWidth + profile.lineWidth * 3 / 2, yPoint - axisSeparatorLineWidth / 2);
                CGContextStrokePath(context);
            }
            [yPositions addObject:[NSNumber numberWithFloat:yPoint]];
            yPoint -= yStep;
            
        }
    }
    
    if([xLabels count]){
        CGFloat xLabelMaxWidth = (rectWidth - canvasMargin * 2 - canvasPadding * 2 - yLabelHoldWidth) / xLabels.count;
        CGFloat xStart = canvasMargin + yLabelHoldWidth + canvasPadding;
        CGFloat xStep = 0;
        
        if(xLabels.count == 1){
            xStart = canvasMargin + yLabelHoldWidth + canvasPadding + (rectWidth - canvasMargin * 2 - canvasPadding * 2 - yLabelHoldWidth) / 2;
        }else{
            xStep = (rectWidth - canvasMargin * 2 - canvasPadding * 2 - yLabelHoldWidth) / (xLabels.count - 1);
        }
        
        CGFloat xPoint = xStart;
        for (NSInteger i = 0; i < xLabels.count; i++) {
            //label text
            if(profile.showXLabel){
                NSString *text = xLabels[i];
                CGSize size = [CAMTextKit sizeOfString:text Font:profile.xyLabelFont Width:xLabelMaxWidth];   // -6是为了避免X标签太长，两个相邻的紧贴在一起
                CGFloat xOffset = size.width / 2;
                CGRect textRect = CGRectMake(xPoint - xOffset, rectHeight - canvasMargin + CAM_XYCOORDINATE_LABEL_SAVE_OFFSET, size.width, size.height);
                [CAMTextKit drawText:xLabels[i] InRect:textRect Font:profile.xyLabelFont Color:labelColor];
            }
            
            //separator
            if(profile.showXAxis){
                CGContextMoveToPoint(context, xPoint - axisSeparatorLineWidth / 2, rectHeight - canvasMargin);
                CGContextAddLineToPoint(context, xPoint - axisSeparatorLineWidth / 2, rectHeight - canvasMargin - profile.lineWidth * 3 / 2);
                CGContextStrokePath(context);
            }
            [xPositions addObject:[NSNumber numberWithFloat:xPoint]];
            xPoint += xStep;
        }
    }
    
    
    CGContextRestoreGState(context);    //结束场景 A
    
    //开始绘制坐标轴线条
    CGContextSaveGState(context);   //开启场景 B ，绘制坐标轴线条
    
    CGFloat axisLineWidth = profile.lineWidth;
    UIColor *axisColor = profile.lineColor;
    
    CGContextSetLineWidth(context, axisLineWidth);
    CGContextSetStrokeColorWithColor(context, [axisColor CGColor]);
    CGContextSetFillColorWithColor(context, [axisColor CGColor]);
    
    CGFloat xAxisWidth = rectWidth - canvasMargin * 2 - yLabelHoldWidth;
    CGFloat yAxisHeight = rectHeight - canvasMargin * 2;
    
    CGFloat xMin = canvasMargin + yLabelHoldWidth;
    CGFloat yMin = canvasMargin;
    CGFloat xMax = canvasMargin + xAxisWidth + yLabelHoldWidth;
    CGFloat yMax = canvasMargin + yAxisHeight;
    
    if(profile.showYAxis){
        CGContextMoveToPoint(context, xMin, yMin);
        CGContextAddLineToPoint(context, xMin, yMax);
        CGContextStrokePath(context);
    }
    if(profile.showXAxis){
        CGContextMoveToPoint(context, xMin, yMax);
        CGContextAddLineToPoint(context, xMax, yMax);
        CGContextStrokePath(context);
    }
    
    //只有XY轴都显示的情况下，才绘制箭头
    if(profile.showXAxis && profile.showYAxis){
        //绘制箭头符号：通过三角函数（正切）计算出未知点偏移量，确定三角形的三个顶点
        //箭头大小为坐标轴线条宽度的3倍
        CGFloat arrowSize = axisLineWidth * 3;
        CGFloat arrowOffsetSize = arrowSize * tan(CAM_Radians_To_Degrees(30));
        CGPoint arrowPoints[3];
        //y-箭头
        arrowPoints[0] = CGPointMake(xMin, yMin - arrowSize);
        arrowPoints[1] = CGPointMake(xMin - arrowOffsetSize, yMin);
        arrowPoints[2] = CGPointMake(xMin + arrowOffsetSize, yMin);
        CGContextAddLines(context, arrowPoints, 3);
        CGContextClosePath(context);
        CGContextDrawPath(context, kCGPathFillStroke);
        //x-箭头
        arrowPoints[0] = CGPointMake(xMax + arrowSize, yMax);
        arrowPoints[1] = CGPointMake(xMax, yMax - arrowOffsetSize);
        arrowPoints[2] = CGPointMake(xMax, yMax + arrowOffsetSize);
        CGContextAddLines(context, arrowPoints, 3);
        CGContextClosePath(context);
        CGContextDrawPath(context, kCGPathFillStroke);
    }
    
    CGContextRestoreGState(context);    //结束场景 B
    
    
    //绘制GridLines
    CGContextSaveGState(context);       //开始场景 C ，绘制GridLine
    
    CGFloat gridLineWidth = profile.lineWidth / 2;
    CGFloat dash[] = {5, 5};
    
    CGContextSetLineWidth(context, gridLineWidth);
    CGContextSetStrokeColorWithColor(context, [profile.gridColor CGColor]);
    CGContextSetLineDash(context, 2.5f, dash, 2);
    
    if(profile.showYGrid){
        switch (profile.gridStyle) {
            case CAMXYAxisGridStyleDependOnStep:
            {
                CGFloat yGridPosition = yMax - canvasPadding;
                while (true) {
                    CGContextMoveToPoint(context, xMin + canvasPadding, yGridPosition);
                    CGContextAddLineToPoint(context, xMax - canvasPadding, yGridPosition);
                    CGContextStrokePath(context);
                    yGridPosition -= profile.gridStepSize;
                    if(yGridPosition < yMin + canvasPadding) break;
                }
            }
                break;
            case CAMXYAxisGridStyleDependOnPositions:{
                for (NSNumber *yPosNum in yPositions) {
                    CGFloat yGridPosition = [yPosNum floatValue];
                    CGContextMoveToPoint(context, xMin + canvasPadding, yGridPosition);
                    CGContextAddLineToPoint(context, xMax - canvasPadding, yGridPosition);
                    CGContextStrokePath(context);
                }
            }
                break;
            default:
                break;
        }
        
    }
    
    if(profile.showXGrid){
        switch (profile.gridStyle) {
            case CAMXYAxisGridStyleDependOnStep:
            {
                CGFloat xGridPosition = xMin + canvasPadding;
                while (true) {
                    CGContextMoveToPoint(context, xGridPosition, yMin + canvasPadding);
                    CGContextAddLineToPoint(context, xGridPosition, yMax - canvasPadding);
                    CGContextStrokePath(context);
                    xGridPosition += profile.gridStepSize;
                    if(xGridPosition > xMax - canvasPadding) break;
                }
            }
                break;
            case CAMXYAxisGridStyleDependOnPositions:
            {
                for (NSNumber *xPosNum in xPositions) {
                    CGFloat xGridPosition = [xPosNum floatValue];
                    CGContextMoveToPoint(context, xGridPosition, yMin + canvasPadding);
                    CGContextAddLineToPoint(context, xGridPosition, yMax - canvasPadding);
                    CGContextStrokePath(context);
                }
            }
                break;
            default:
                break;
        }
        
    }
    
    CGContextRestoreGState(context);    //结束场景 C
    
    // 绘制坐标单位
    CGFloat unitMaxWidth = xAxisWidth / 3.0;    //单位标签的宽度限定在整个图表的 1/3 范围内
    UIColor *unitColor = profile.unitColor;
    if(profile.showXAxis && [xUnit length]){
        CGSize size = [CAMTextKit sizeOfString:xUnit Font:profile.unitFont Width:unitMaxWidth];
        CGRect textRect = CGRectMake(xMax - size.width, yMax - size.height - 5, size.width, size.height);
        [CAMTextKit drawText:xUnit InRect:textRect Font:profile.unitFont Color:unitColor];
    }
    
    if(profile.showYAxis && [yUnit length]){
        CGSize size = [CAMTextKit sizeOfString:xUnit Font:profile.unitFont Width:unitMaxWidth];
        CGRect textRect = CGRectMake(xMin + 5, yMin, size.width, size.height);
        [CAMTextKit drawText:yUnit InRect:textRect Font:profile.unitFont Color:unitColor];
    }
    
    CGContextRestoreGState(context);    //恢复到初始场景
    
}







- (void)drawCircleCoordinateWithRect:(CGRect)rect AxisProfile:(CAMCircleAxisProfile *)profile TopTag:(NSString *)topTag bottomTag:(NSString *)bottomTag ValueRect:(CGRect)valueRect{
    
    //此方法调用前必须确保能得到图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //保存一下初始的上下文场景
    CGContextSaveGState(context);
    
    //设置Chart全局绘制场景，使用圆角模式
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    //绘制环形背景
    if(profile.showAxis){
        CGContextSaveGState(context);   //开启场景 A - 绘制环形背景
        
        CGContextSetLineWidth(context, profile.lineWidth);
        CGContextSetStrokeColorWithColor(context, profile.lineColor.CGColor);
        
        CGPoint circleCenterPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
        CGPoint circleStartPoint = CGPointMake(CGRectGetMaxX(rect), CGRectGetMidY(rect));
        CGFloat circleRadius = rect.size.width / 2.0f;
        
        CGContextMoveToPoint(context, circleStartPoint.x, circleStartPoint.y);
        CGContextAddArc(context, circleCenterPoint.x, circleCenterPoint.y, circleRadius, 0, (CGFloat)(2 * M_PI), 0);
        CGContextStrokePath(context);
        
        CGContextRestoreGState(context);    //结束场景 A - 绘制环形背景
    }
    
    //绘制上标签
    CGFloat tagMaxWidth = CGRectGetWidth(rect) * 2 / 3;     //Tag标签最大显示宽度为可视区域的 2/3
    if([topTag length]){
        CGSize size = [CAMTextKit sizeOfString:topTag Font:profile.topTagFont Width:tagMaxWidth];
        CGRect textRect = CGRectMake(CGRectGetMidX(valueRect) - size.width / 2,
                                     CGRectGetMinY(valueRect) - size.height - profile.topTagMargin,
                                     size.width,
                                     size.height);
        [CAMTextKit drawText:topTag InRect:textRect Font:profile.topTagFont Color:profile.topTagColor];
    }
    
    //绘制下标签
    if([bottomTag length]){
        CGSize size = [CAMTextKit sizeOfString:bottomTag Font:profile.bottomTagFont Width:tagMaxWidth];
        CGRect textRect = CGRectMake(CGRectGetMidX(valueRect) - size.width / 2,
                                     CGRectGetMaxY(valueRect) + profile.bottomTagMargin,
                                     size.width,
                                     size.height);
        [CAMTextKit drawText:bottomTag InRect:textRect Font:profile.bottomTagFont Color:profile.bottomTagColor];
    }
    
    
    CGContextRestoreGState(context);    //恢复到初始场景
    
}









@end
