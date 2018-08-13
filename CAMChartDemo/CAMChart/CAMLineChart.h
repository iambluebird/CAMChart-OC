//
//  CAMLineChart.h
//  CAMChartDemo
//
//  Created by 欧阳峰 on 2018/8/9.
//  Copyright © 2018年 欧阳峰. All rights reserved.
//

#import "CAMBaseChart.h"

@interface CAMLineChart : CAMBaseChart


/**
 X轴上的标签
 */
@property (nonatomic) NSArray *xLabels;

/**
 Y轴上的标签，如果不设置并且需要显示标签，标签会根据数据自动推算出来
 */
@property (nonatomic) NSArray *yLabels;


/**
 X轴上显示的单位
 */
@property (nonatomic, strong) NSString *xUnit;

/**
 Y轴上显示的单位
 */
@property (nonatomic, strong) NSString *yUnit;



-(void)addChartData:(NSArray*)chartData;

@end
