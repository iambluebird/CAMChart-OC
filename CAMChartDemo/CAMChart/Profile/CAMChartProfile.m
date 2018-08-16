//
//  CAMChartProfile.m
//  CAMChartDemo
//
//  Created by 欧阳峰 on 2018/8/8.
//  Copyright © 2018年 欧阳峰. All rights reserved.
//

#import "CAMChartProfile.h"
#import "CAMColorKit.h"



@implementation CAMChartProfile



-(id)mutableCopyWithZone:(NSZone *)zone{
    
    CAMChartProfile *newProfile = [[CAMChartProfile alloc] init];
    
    newProfile.margin = self.margin;
    newProfile.padding = self.padding;
    
    newProfile.themeColor = self.themeColor;
    newProfile.backgroundColor = self.backgroundColor;
    
    newProfile.chartColors = [self.chartColors mutableCopy];
    
    newProfile.xyAxis = [self.xyAxis mutableCopy];
    newProfile.circleAxis = [self.circleAxis mutableCopy];
    
    newProfile.lineChart = [self.lineChart mutableCopy];
    newProfile.circleProgress = [self.circleProgress mutableCopy];
    
    newProfile.animationDisplay = self.animationDisplay;
    newProfile.animationDuration = self.animationDuration;
    
    return newProfile;
}



-(CGFloat)margin{
    if(_margin <= 0){
        _margin = 20;
    }
    return _margin;
}

- (CGFloat)padding{
    if(_padding <= 0){
        _padding = 10;
    }
    return _padding;
}

- (UIColor *)backgroundColor{
    if(!_backgroundColor){
        _backgroundColor = [UIColor whiteColor];
    }
    return _backgroundColor;
}

- (UIColor *)themeColor{
    if(!_themeColor){
        _themeColor = [UIColor blueColor];
    }
    return _themeColor;
}

- (CGFloat)animationDuration{
    if(_animationDuration<=0 && _animationDisplay){
        _animationDuration = 1.0f;
    }
    return _animationDuration;
}

- (CAMXYAxisProfile *)xyAxis{
    if(!_xyAxis){
        _xyAxis = [[CAMXYAxisProfile alloc] initWithThemeColor:self.themeColor];
    }
    return _xyAxis;
}

- (CAMCircleAxisProfile *)circleAxis{
    if(!_circleAxis){
        _circleAxis = [[CAMCircleAxisProfile alloc] init];
    }
    return _circleAxis;
}

- (CAMLineChartProfile *)lineChart{
    if(!_lineChart){
        _lineChart = [[CAMLineChartProfile alloc] init];
    }
    return _lineChart;
}

- (CAMCircleProgressChartProfile *)circleProgress{
    if(!_circleProgress){
        _circleProgress = [[CAMCircleProgressChartProfile alloc] init];
    }
    return _circleProgress;
}






- (UIColor *)chartColorWithIndex:(NSInteger)index{
    if(!_chartColors.count){
        return [CAMColorKit weakenWithColor:self.themeColor];
    }
    NSInteger indexInArray = index % _chartColors.count;
    return _chartColors[indexInArray];
}

@end
