//
//  CAMLineChart.m
//  CAMChartDemo
//
//  Created by 欧阳峰 on 2018/8/9.
//  Copyright © 2018年 欧阳峰. All rights reserved.
//

#import "CAMLineChart.h"

@implementation CAMLineChart

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)drawRect:(CGRect)rect{
    CAMCoordinateAxisKit *caKit = [[CAMCoordinateAxisKit alloc] init];
    //[caKit drawXYCoordinateWithRect:rect ChartProfile: self.chartProfile];
    [caKit drawXYCoordinateWithRect:rect ChartProfile:self.chartProfile xUnit:self.xUnit yUnit:self.yUnit xLabels:self.xLabels yLabels:self.yLabels];
    [super drawRect:rect];
}

@end
