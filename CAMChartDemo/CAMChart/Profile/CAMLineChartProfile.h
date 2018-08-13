//
//  CAMLineChartProfile.h
//  CAMChartDemo
//
//  Created by 欧阳峰 on 2018/8/13.
//  Copyright © 2018年 欧阳峰. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 Chart线条类型
 
 - CAMChartLineStyleStraight: 折线图
 - CAMChartLineStyleCurve: 圆滑曲线图
 */
typedef NS_ENUM(NSUInteger, CAMChartLineStyle) {
    CAMChartLineStyleStraight,
    CAMChartLineStyleCurve,
};

@interface CAMLineChartProfile : NSObject<NSMutableCopying>

@property(nonatomic, assign) CAMChartLineStyle lineStyle;       //线条样式：直线 or 曲线
@property(nonatomic, assign) CGFloat lineWidth;                 //线条宽度

@property(nonatomic, assign) BOOL showPoint;                    //是否显示数据节点
@property(nonatomic, assign) BOOL showPointLabel;               //是否显示数据节点标签
@property(nonatomic, strong) NSString* pointLabelFormat;        //数据节点标签格式化
@property(nonatomic, strong) UIColor* pointLabelFontColor;      //数据节点标签文字颜色
@property(nonatomic, assign) CGFloat pointLabelFontSize;        //数据节点标签文字大小

@end
