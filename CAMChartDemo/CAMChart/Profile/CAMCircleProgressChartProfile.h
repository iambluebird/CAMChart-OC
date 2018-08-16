//
//  CAMCircleProgressChartProfile.h
//  CAMChartDemo
//
//  Created by 欧阳峰 on 2018/8/15.
//  Copyright © 2018年 欧阳峰. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 进度类型

 - CAMProgressValueTypeNumber: 普通数值型，直接显示传入数值
 - CAMProgressValueTypePercent: 百分比型，传入数值后根据minValue和maxValue计算出百分比值进行显示
 */
typedef NS_ENUM(NSUInteger, CAMProgressValueType) {
    CAMProgressValueTypeNumber,
    CAMProgressValueTypePercent,
};

/**
 进度图起点

 - CAMProgressStartAtTop: 顶部
 - CAMProgressStartAtRight: 右侧
 - CAMProgressStartAtBottom: 下部
 - CAMProgressStartAtLeft: 左侧
 */
typedef NS_ENUM(NSUInteger, CAMProgressStartAt) {
    CAMProgressStartAtTop,
    CAMProgressStartAtRight,
    CAMProgressStartAtBottom,
    CAMProgressStartAtLeft,
};


/**
 进度方向

 - CAMProgressClockwiseAsYES: 顺时针方向
 - CAMProgressClockwiseAsNO: 逆时针方向
 */
typedef NS_ENUM(NSUInteger, CAMProgressClockwiseAs) {
    CAMProgressClockwiseAsYES,
    CAMProgressClockwiseAsNO,
};

@interface CAMCircleProgressChartProfile : NSObject<NSMutableCopying>

@property(nonatomic, assign) CAMProgressValueType progressType;     //进度类型

@property(nonatomic, assign) CGFloat lineWidth;                     //进度图线宽，可以和坐标线宽不一致，实现精美效果
@property(nonatomic, strong) UIColor* lineColor;                    //进度图颜色

/**
 进度值样式设置
 */
@property(nonatomic, strong) UIFont* progressValueFont;
@property(nonatomic, strong) UIColor* progressValueColor;
@property(nonatomic, strong) NSString* progressValueFormat;         //格式化字符串

@property(nonatomic, assign) CAMProgressStartAt startAt;            //进度图起点
@property(nonatomic, assign) CAMProgressClockwiseAs clockwiseAs;    //进度方向

@end
