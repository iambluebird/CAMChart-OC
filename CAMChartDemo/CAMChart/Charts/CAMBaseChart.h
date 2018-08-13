//
//  CAMBaseChart.h
//  CAMChartDemo
//
//  Created by 欧阳峰 on 2018/8/9.
//  Copyright © 2018年 欧阳峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CAMChartProfile.h"
#import "CAMChartProfileManager.h"
#import "CAMCoordinateAxisKit.h"

@interface CAMBaseChart : UIView

@property(nonatomic, strong) CAMChartProfile* chartProfile;



/**
 绘制统计图
 */
-(void)drawChart;

@end
