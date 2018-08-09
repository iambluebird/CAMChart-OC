//
//  CAMCoordinateAxisKit.m
//  CAMChartDemo
//
//  Created by 欧阳峰 on 2018/8/9.
//  Copyright © 2018年 欧阳峰. All rights reserved.
//

#import "CAMCoordinateAxisKit.h"

@implementation CAMCoordinateAxisKit

-(void)drawXYCoordinateWithRect:(CGRect)rect ChartProfile:(CAMChartProfile*)profile xUnit:(nullable NSString*)xUnit yUnit:(nullable NSString*)yUnit xLabels:(nullable NSArray*)xLabels yLabels:(nullable NSArray*)yLabels{
    
    CGFloat rectWidth = CGRectGetWidth(rect);
    CGFloat rectHeight = CGRectGetHeight(rect);
    
    //此方法调用前必须确保能得到图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //开始绘制坐标轴线条
    CGContextSaveGState(context);
    
    CGFloat axisSeparatorLineWidth = profile.axisLineWidth / 2;
    UIColor *axisSpearatorColor = profile.axisLineColor;
    CGContextSetLineWidth(context, axisSeparatorLineWidth);
    CGContextSetStrokeColorWithColor(context, [axisSpearatorColor CGColor]);
    
    //try
    BOOL isShowYLabel = YES;
    BOOL isShowXLabel = YES;
    
    //从外向内绘制，才能计算出安全距离
    //绘制坐标标签
    UIFont *labelFont = [UIFont systemFontOfSize:11];
    CGFloat yLabelHoldWidth = 0.0f;     //如果显示了Y轴的Label，此时需要留出这些标签的宽度作为占位
    UIColor *labelColor = profile.axisLineColor;
    
    if(isShowYLabel){
        if([yLabels count]){
            CGFloat yLabelMaxWidth = 60.0f;
            //循环得到每个label的尺寸，并找出最大宽度作为水平方向向右偏移量，留出label标签的位置
            NSMutableArray *yLabelSizes = [NSMutableArray new];
            NSMutableArray *yLabelWidths = [NSMutableArray new];
            for (NSString* text in yLabels) {
                CGSize size = [CAMTextKit sizeOfString:text Font:labelFont Width:yLabelMaxWidth];
                [yLabelSizes addObject: [NSValue valueWithCGSize:size]];
                [yLabelWidths addObject: [NSNumber numberWithFloat:size.width]];
            }
            //以最大的Y轴标签宽度作为占位基准宽度
            CGFloat maxValue = [[yLabelWidths valueForKeyPath:@"@max.floatValue"] floatValue];
            yLabelHoldWidth = maxValue + 5; //计算出Y轴标签占位宽度，与Y轴之间留出5PT的安全距离
            
            CGFloat yStart = rectHeight - profile.margin - CAM_XYCOORDINATE_SAFE_OFFSET;
            CGFloat yStep = 0;
            
            if(yLabels.count == 1){
                yStart = profile.margin + CAM_XYCOORDINATE_SAFE_OFFSET + (rectHeight - profile.margin * 2 - CAM_XYCOORDINATE_SAFE_OFFSET * 2) / 2;
            }else{
                yStep = (rectHeight - profile.margin * 2 - CAM_XYCOORDINATE_SAFE_OFFSET * 2) / (yLabels.count - 1);
            }
            
            CGFloat yPoint = yStart;
            for (NSInteger i = 0; i < yLabels.count; i++) {
                //label text
                CGSize size = [yLabelSizes[i] CGSizeValue];
                CGFloat yOffset = size.height / 2;
                CGRect textRect = CGRectMake(profile.margin + maxValue - size.width, yPoint - yOffset, size.width, size.height);
                [CAMTextKit drawText:yLabels[i] InRect:textRect Font:labelFont Color:labelColor];
                
                //separator
                CGContextMoveToPoint(context, profile.margin + yLabelHoldWidth, yPoint - axisSeparatorLineWidth / 2);
                CGContextAddLineToPoint(context, profile.margin + yLabelHoldWidth + profile.axisLineWidth * 3 / 2, yPoint - axisSeparatorLineWidth / 2);
                CGContextStrokePath(context);
                
                yPoint -= yStep;
            }
        }
    }
    
    if(isShowXLabel){
        if([xLabels count]){
            CGFloat xLabelMaxWidth = (rectWidth - profile.margin * 2 - CAM_XYCOORDINATE_SAFE_OFFSET * 2 - yLabelHoldWidth) / xLabels.count;
            CGFloat xStart = profile.margin + yLabelHoldWidth + CAM_XYCOORDINATE_SAFE_OFFSET;
            CGFloat xStep = 0;
            
            if(xLabels.count == 1){
                xStart = profile.margin + yLabelHoldWidth + CAM_XYCOORDINATE_SAFE_OFFSET + (rectWidth - profile.margin * 2 - CAM_XYCOORDINATE_SAFE_OFFSET * 2 - yLabelHoldWidth) / 2;
            }else{
                xStep = (rectWidth - profile.margin * 2 - CAM_XYCOORDINATE_SAFE_OFFSET * 2 - yLabelHoldWidth) / (xLabels.count - 1);
            }
            
            CGFloat xPoint = xStart;
            for (NSInteger i = 0; i < xLabels.count; i++) {
                NSString *text = xLabels[i];
                CGSize size = [CAMTextKit sizeOfString:text Font:labelFont Width:xLabelMaxWidth];   // -6是为了避免X标签太长，两个相邻的紧贴在一起
                CGFloat xOffset = size.width / 2;
                CGRect textRect = CGRectMake(xPoint - xOffset, rectHeight - profile.margin + 5, size.width, size.height);
                [CAMTextKit drawText:xLabels[i] InRect:textRect Font:labelFont Color:labelColor];
                
                //separator
                CGContextMoveToPoint(context, xPoint - axisSeparatorLineWidth / 2, rectHeight - profile.margin);
                CGContextAddLineToPoint(context, xPoint - axisSeparatorLineWidth / 2, rectHeight - profile.margin - profile.axisLineWidth * 3 / 2);
                CGContextStrokePath(context);
                
                xPoint += xStep;
            }
        }
    }
    
    
    
    
    CGContextRestoreGState(context);
    
    //开始绘制坐标轴线条
    CGContextSaveGState(context);
    
    CGFloat axisLineWidth = profile.axisLineWidth;
    UIColor *axisColor = profile.axisLineColor;
    
    CGContextSetLineWidth(context, axisLineWidth);
    CGContextSetStrokeColorWithColor(context, [axisColor CGColor]);
    CGContextSetFillColorWithColor(context, [axisColor CGColor]);
    
    //todo.. 需要预留出yLabels的位置 即 yLabelOffsetWidth
    CGFloat xAxisWidth = rectWidth - profile.margin * 2 - yLabelHoldWidth;
    CGFloat yAxisHeight = rectHeight - profile.margin * 2;
    
    CGFloat xMin = profile.margin + yLabelHoldWidth;
    CGFloat yMin = profile.margin;
    CGFloat xMax = profile.margin + xAxisWidth + yLabelHoldWidth;
    CGFloat yMax = profile.margin + yAxisHeight;
    
    //三点确定坐标系
    CGPoint axisPoints[3];
    axisPoints[0] = CGPointMake(xMin, yMin);
    axisPoints[1] = CGPointMake(xMin, yMax);
    axisPoints[2] = CGPointMake(xMax, yMax);
    CGContextAddLines(context, axisPoints, 3);
    CGContextDrawPath(context, kCGPathStroke);
    
    //绘制箭头符号：通过三角函数（正切）计算出未知点偏移量，确定三角形的三个顶点
    //箭头大小为坐标轴线条宽度的5倍
    CGFloat arrowSize = axisLineWidth * 5;
    CGFloat arrowOffsetSize = arrowSize * tan(CAM_Radians_To_Degrees(30));
    //y-箭头
    axisPoints[0] = CGPointMake(xMin, yMin - arrowSize);
    axisPoints[1] = CGPointMake(xMin - arrowOffsetSize, yMin);
    axisPoints[2] = CGPointMake(xMin + arrowOffsetSize, yMin);
    CGContextAddLines(context, axisPoints, 3);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFill);
    //x-箭头
    axisPoints[0] = CGPointMake(xMax + arrowSize, yMax);
    axisPoints[1] = CGPointMake(xMax, yMax - arrowOffsetSize);
    axisPoints[2] = CGPointMake(xMax, yMax + arrowOffsetSize);
    CGContextAddLines(context, axisPoints, 3);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFill);
    
    CGContextRestoreGState(context);
    
    
    // 绘制坐标单位
    UIFont *font = [UIFont systemFontOfSize:profile.axisUnitFontSize];
    CGFloat unitMaxWidth = xAxisWidth / 3.0;    //单位标签的宽度限定在整个图表的 1/3 范围内
    UIColor *unitColor = profile.axisUnitColor;
    if([xUnit length]){
        CGSize size = [CAMTextKit sizeOfString:xUnit Font:font Width:unitMaxWidth];
        CGRect textRect = CGRectMake(xMax - size.width, yMax - size.height - 5, size.width, size.height);
        [CAMTextKit drawText:xUnit InRect:textRect Font:font Color:unitColor];
    }
    
    if([yUnit length]){
        CGSize size = [CAMTextKit sizeOfString:xUnit Font:font Width:unitMaxWidth];
        CGRect textRect = CGRectMake(xMin + 5, yMin, size.width, size.height);
        [CAMTextKit drawText:yUnit InRect:textRect Font:font Color:unitColor];
    }
    
    
    
    
    
    
}

















@end
