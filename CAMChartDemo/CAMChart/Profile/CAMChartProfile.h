//
//  CAMChartProfile.h
//  CAMChartDemo
//
//  Created by 欧阳峰 on 2018/8/8.
//  Copyright © 2018年 欧阳峰. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CAMXYAxisProfile.h"
#import "CAMCircleAxisProfile.h"

#import "CAMLineChartProfile.h"
#import "CAMCircleProgressChartProfile.h"




@interface CAMChartProfile : NSObject<NSMutableCopying>

/**
 坐标定义
 */
@property(nonatomic, assign) CGFloat margin;                //Chart 视图边距 默认为20
@property(nonatomic, assign) CGFloat padding;               //Chart 视图内边距 默认10


/**
 主题色：如果统计图的各个色值没有定义，则会根据这个主题色进行推算。
 单独定义了的颜色属性，不再受主题色控制。
 */
@property(nonatomic, strong) UIColor* themeColor;           //主题色
@property(nonatomic, strong) UIColor* backgroundColor;      //视图背景色，默认为 whiteColor
@property(nonatomic, strong) NSArray* chartColors;          //统计图配色表，不同的数据组使用不同配色

/**
 子项配置
 */
@property(nonatomic, strong) CAMXYAxisProfile *xyAxis;      //XY坐标配置信息
@property(nonatomic, strong) CAMCircleAxisProfile *circleAxis;  //圆环形坐标配置信息

@property(nonatomic, strong) CAMLineChartProfile *lineChart;//折线图配置信息
@property(nonatomic, strong) CAMCircleProgressChartProfile *circleProgress;     //环形进度图配置信息

/**
 动画配置
 */
@property(nonatomic, assign) BOOL animationDisplay;         //是否开启动画
@property(nonatomic, assign) CGFloat animationDuration;     //动画时长，默认为1s






/**
 获取配色表中的颜色

 @param index 配色索引，这里使用数据组下标
 @return 颜色值
 */
-(UIColor*) chartColorWithIndex:(NSInteger)index;

@end
