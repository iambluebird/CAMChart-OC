//
//  CAMLineChart.h
//  CAMChartDemo
//
//  Created by 欧阳峰 on 2018/8/9.
//  Copyright © 2018年 欧阳峰. All rights reserved.
//

#import "CAMBaseChart.h"

@interface CAMLineChart : CAMBaseChart

@property (nonatomic) NSArray *xLabels;
@property (nonatomic) NSArray *yLabels;

@property (nonatomic, strong) NSString *xUnit;
@property (nonatomic, strong) NSString *yUnit;

@end
