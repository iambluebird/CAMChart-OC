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


//以下两个属性需要同时设置才能生效，否则将根据数据自动推算
@property (nonatomic, assign) CGFloat minValue;     //Y轴上的最小值
@property (nonatomic, assign) CGFloat maxValue;     //Y轴上的最大值


/**
 添加一组数据，这组数据将被描述为单独的一条数据线

 @param chartData array of CGFloat values
 */
-(void)addChartData:(NSArray*)chartData;

@end
