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

@interface CAMBaseChart : UIView{
    BOOL _animationDispayThisTime;  //本次展示是否使用动画效果，解决cell复用引起的动画重复问题
}

@property(nonatomic, strong) CAMChartProfile* chartProfile;



/**
 绘制统计图
 */
-(void)drawChart;


/**
 绘制统计图：用于需要解决cell复用时引起动画复用的问题，如果每次展示都允许动画效果，则调用drawChart函数即可

 @param animationDisplay 本次展示是否使用动画，前提条件是在profile中开启了动画展示，否则此参数无效
 */
-(void)drawChartWithAnimationDisplay:(BOOL)animationDisplay;

@end
