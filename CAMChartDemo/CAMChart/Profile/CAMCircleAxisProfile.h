//
//  CAMCircleAxisProfile.h
//  CAMChartDemo
//  圆环形坐标
//  Created by 欧阳峰 on 2018/8/15.
//  Copyright © 2018年 欧阳峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CAMCircleAxisProfile : NSObject<NSMutableCopying>

@property(nonatomic, assign) BOOL showAxis;                 //是否显示背景环形（坐标）
@property(nonatomic, assign) CGFloat lineWidth;             //坐标轴线条宽度
@property(nonatomic, strong) UIColor* lineColor;            //坐标轴颜色

/*
 上标签样式设置
 */
@property(nonatomic, strong) UIFont* topTagFont;
@property(nonatomic, strong) UIColor* topTagColor;
@property(nonatomic, assign) CGFloat topTagMargin;          //上标签与进度值标签之间的间距（上标签下方）

/*
 下标签样式设置
 */
@property(nonatomic, strong) UIFont* bottomTagFont;
@property(nonatomic, strong) UIColor* bottomTagColor;
@property(nonatomic, assign) CGFloat bottomTagMargin;       //下标签与进度值之间的距离（下标签上方）



@end
