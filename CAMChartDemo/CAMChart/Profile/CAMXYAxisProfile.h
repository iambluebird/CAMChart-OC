//
//  CAMAxisProfile.h
//  CAMChartDemo
//
//  Created by 欧阳峰 on 2018/8/13.
//  Copyright © 2018年 欧阳峰. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 Grid Line依赖模式

 - CAMXYAxisGridStyleDependOnStep: 依赖于指定的GridStep值，步进绘制
 - CAMXYAxisGridStyleDependOnPositions: 依赖于坐标标签点，一般用于绘制辅助线
 */
typedef NS_ENUM(NSUInteger, CAMXYAxisGridStyle) {
    CAMXYAxisGridStyleDependOnStep,
    CAMXYAxisGridStyleDependOnPositions,
};

@interface CAMXYAxisProfile : NSObject<NSMutableCopying>

//坐标轴设置
@property(nonatomic, assign) BOOL showXAxis;                //是否显示X坐标
@property(nonatomic, assign) BOOL showYAxis;                //是否显示Y坐标
@property(nonatomic, assign) CGFloat lineWidth;             //坐标轴线条宽度
@property(nonatomic, strong) UIColor* lineColor;            //坐标轴颜色

//坐标轴单位标签设置：如果传入空，则不显示单位标签。默认为空
@property(nonatomic, strong) UIFont* unitFont;              //坐标轴上单位标签的字体
@property(nonatomic, strong) UIColor* unitColor;            //坐标轴上单位标签的颜色

//轴标签设置
@property(nonatomic, assign) BOOL showXLabel;               //是否显示X轴上标签
@property(nonatomic, assign) BOOL showYLabel;               //是否显示Y轴上标签
@property(nonatomic, strong) UIFont* xyLabelFont;           //坐标轴上标签字体
@property(nonatomic, strong) UIColor* xyLabelColor;         //坐标轴上标签颜色
//以下属性设置在没有指定Y轴标签内容，且 showYLabel=YES 的情况下生效
//统计图会根据传入的数据自动推算出Y轴标签内容
@property(nonatomic, strong) NSString* yLabelFormat;        //Y轴标签格式化样式，X轴不能进行格式化
@property(nonatomic, assign) NSInteger yLabelDefaultCount;  //Y轴标签默认数量

//Grid设置
@property(nonatomic, assign) BOOL showXGrid;                //是否显示X表格线（垂直）
@property(nonatomic, assign) BOOL showYGrid;                //是否显示Y表格线（水平）
@property(nonatomic, assign) CAMXYAxisGridStyle gridStyle;  //表格线依托方式：步进式 or 节点式
@property(nonatomic, assign) CGFloat gridStepSize;          //步进尺寸，当gridStyle为步进式时生效
@property(nonatomic, strong) UIColor* gridColor;            //表格线颜色




/**
 根据传入的统计图主题色对坐标系设置进行初始化

 @param color 统计图主题色
 @return profile
 */
-(instancetype)initWithThemeColor:(UIColor*)color;

@end
