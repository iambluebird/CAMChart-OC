//
//  CAMChartProfile.h
//  CAMChartDemo
//
//  Created by 欧阳峰 on 2018/8/8.
//  Copyright © 2018年 欧阳峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CAMChartProfile : NSObject<NSMutableCopying>

@property(nonatomic, assign) CGFloat margin;

@property(nonatomic, strong) UIColor* themeColor;
@property(nonatomic, strong) UIColor* backgroundColor;



@property(nonatomic, assign) CGFloat axisLineWidth;
@property(nonatomic, strong) UIColor* axisLineColor;
@property(nonatomic, assign) CGFloat axisUnitFontSize;
@property(nonatomic, strong) UIColor* axisUnitColor;


@end
