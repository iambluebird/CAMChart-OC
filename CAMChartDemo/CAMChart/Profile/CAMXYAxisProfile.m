//
//  CAMAxisProfile.m
//  CAMChartDemo
//
//  Created by 欧阳峰 on 2018/8/13.
//  Copyright © 2018年 欧阳峰. All rights reserved.
//

#import "CAMXYAxisProfile.h"
#import "CAMColorKit.h"

@interface CAMXYAxisProfile()

@property (nonatomic, strong) UIColor *themeColor;

@end

@implementation CAMXYAxisProfile

- (instancetype)initWithThemeColor:(UIColor *)themeColor
{
    self = [super init];
    if (self) {
        self.themeColor = themeColor;
    }
    return self;
}

-(id)mutableCopyWithZone:(NSZone *)zone{
    CAMXYAxisProfile *newProfile = [[CAMXYAxisProfile alloc] init];
    
    newProfile.showXAxis = self.showXAxis;
    newProfile.showYAxis = self.showYAxis;
    newProfile.lineWidth = self.lineWidth;
    newProfile.lineColor = self.lineColor;
    newProfile.unitFont = self.unitFont;
    newProfile.unitColor = self.unitColor;
    
    newProfile.showXLabel = self.showXLabel;
    newProfile.showYLabel = self.showYLabel;
    newProfile.xyLabelFont = self.xyLabelFont;
    newProfile.xyLabelColor = self.xyLabelColor;
    newProfile.yLabelFormat = self.yLabelFormat;
    newProfile.yLabelDefaultCount = self.yLabelDefaultCount;
    
    newProfile.showXGrid = self.showXGrid;
    newProfile.showYGrid = self.showYGrid;
    newProfile.gridStyle = self.gridStyle;
    newProfile.gridColor = self.gridColor;
    newProfile.gridStepSize = self.gridStepSize;
    
    return newProfile;
}

- (UIColor *)themeColor{
    if(!_themeColor){
        _themeColor = [UIColor blueColor];
    }
    return _themeColor;
}



#pragma mark - 根据主题配置自动计算的一些默认属性
- (UIColor *)lineColor{
    if(!_lineColor){
        _lineColor = [CAMColorKit deepenWithColor:self.themeColor];
    }
    return _lineColor;
}

- (UIFont *)unitFont{
    if(!_unitFont){
        _unitFont = [UIFont systemFontOfSize:11.0f];
    }
    return _unitFont;
}

- (UIColor *)unitColor{
    if(!_unitColor){
        _unitColor = self.lineColor;
    }
    return _unitColor;
}

- (UIFont *)xyLabelFont{
    if(!_xyLabelFont){
        _xyLabelFont = [UIFont systemFontOfSize:11.0f];
    }
    return _xyLabelFont;
}

-(UIColor *)xyLabelColor{
    if(!_xyLabelColor){
        _xyLabelColor = self.lineColor;
    }
    return _xyLabelColor;
}

- (NSString *)yLabelFormat{
    if(!_yLabelFormat){
        _yLabelFormat = @"%0.1f";
    }
    return _yLabelFormat;
}

- (UIColor *)gridColor{
    if(!_gridColor){
        _gridColor = [UIColor lightGrayColor];
    }
    return _gridColor;
}

@end
