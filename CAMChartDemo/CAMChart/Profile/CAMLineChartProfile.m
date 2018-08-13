//
//  CAMLineChartProfile.m
//  CAMChartDemo
//
//  Created by 欧阳峰 on 2018/8/13.
//  Copyright © 2018年 欧阳峰. All rights reserved.
//

#import "CAMLineChartProfile.h"

@implementation CAMLineChartProfile

-(id)mutableCopyWithZone:(NSZone *)zone{
    CAMLineChartProfile *newProfile = [[CAMLineChartProfile alloc] init];
    
    newProfile.lineStyle = self.lineStyle;
    newProfile.lineWidth = self.lineWidth;
    
    newProfile.showPoint = self.showPoint;
    newProfile.showPointLabel = self.showPointLabel;
    newProfile.pointLabelFormat = self.pointLabelFormat;
    newProfile.pointLabelFontColor = self.pointLabelFontColor;
    newProfile.pointLabelFontSize = self.pointLabelFontSize;
    
    return newProfile;
}

- (CGFloat)lineWidth{
    if(_lineWidth <= 0){
        _lineWidth = 2;
    }
    return _lineWidth;
}

- (NSString *)pointLabelFormat{
    if(!_pointLabelFormat){
        _pointLabelFormat = @"%0.0f";
    }
    return _pointLabelFormat;
}

- (UIColor *)pointLabelFontColor{
    if(!_pointLabelFontColor){
        _pointLabelFontColor = [UIColor blueColor];
    }
    return _pointLabelFontColor;
}

- (CGFloat)pointLabelFontSize{
    if(_pointLabelFontSize<=0){
        _pointLabelFontSize = 11;
    }
    return _pointLabelFontSize;
}

@end
