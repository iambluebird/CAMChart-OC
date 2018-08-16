//
//  CAMCircleProgressChart.h
//  CAMChartDemo
//
//  Created by 欧阳峰 on 2018/8/15.
//  Copyright © 2018年 欧阳峰. All rights reserved.
//

#import "CAMBaseChart.h"

@interface CAMCircleProgressChart : CAMBaseChart

/*
 chart所能展现的数据上下限，如果不指定，默认为 0 - 100
 */
@property(nonatomic, assign) CGFloat minValue;
@property(nonatomic, assign) CGFloat maxValue;

@property(nonatomic, strong) NSString *topTag;      //上标签：为空时不显示
@property(nonatomic, strong) NSString *bottomTag;   //下标签：为空时不显示

/**
 添加进度值，对于环形进度统计图来说，只能添加一个CGFloat数据，且必须于minValue与maxValue之间

 @param chartData 数据值，如果设置环形进度图按照百分比模式显示，将换算为百分比进度
 */
-(void) addChartData:(CGFloat)chartData;

@end
