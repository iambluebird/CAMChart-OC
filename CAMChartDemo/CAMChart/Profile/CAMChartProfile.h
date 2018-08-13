//
//  CAMChartProfile.h
//  CAMChartDemo
//
//  Created by 欧阳峰 on 2018/8/8.
//  Copyright © 2018年 欧阳峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CAMXYAxisProfile.h"
#import "CAMLineChartProfile.h"




@interface CAMChartProfile : NSObject<NSMutableCopying>


/**
 Chart 视图边距 默认为20
 */
@property(nonatomic, assign) CGFloat margin;


/**
 主题色：如果统计图的各个色值没有定义，则会根据这个主题色进行推算。
 单独定义了的颜色属性，不再受主题色控制。
 */
@property(nonatomic, strong) UIColor* themeColor;

/**
 视图背景色，默认为 whiteColor
 */
@property(nonatomic, strong) UIColor* backgroundColor;

/**
 统计图配色表，不同的数据组使用不同配色
 */
@property(nonatomic, strong) NSArray* chartColors;

/**
 XY坐标配置信息
 */
@property(nonatomic, strong) CAMXYAxisProfile *xyAxis;

/**
 折线图配置信息
 */
@property(nonatomic, strong) CAMLineChartProfile *lineChart;


/**
 是否开启动画显示
 */
@property(nonatomic, assign) BOOL animationDisplay;

/**
 动画时长，默认为1s
 */
@property(nonatomic, assign) CGFloat animationDuration;






/**
 获取配色表中的颜色

 @param index 配色索引，这里使用数据组下标
 @return 颜色值
 */
-(UIColor*) chartColorWithIndex:(NSInteger)index;

@end
