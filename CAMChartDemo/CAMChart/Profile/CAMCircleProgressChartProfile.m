//
//  CAMCircleProgressChartProfile.m
//  CAMChartDemo
//
//  Created by 欧阳峰 on 2018/8/15.
//  Copyright © 2018年 欧阳峰. All rights reserved.
//

#import "CAMCircleProgressChartProfile.h"
#import "CAMColorKit.h"

@implementation CAMCircleProgressChartProfile

-(id)mutableCopyWithZone:(NSZone *)zone{
    CAMCircleProgressChartProfile *newProfile = [[CAMCircleProgressChartProfile alloc] init];
    
    newProfile.progressType = self.progressType;
    
    newProfile.lineWidth = self.lineWidth;
    newProfile.lineColor = self.lineColor;
    
    newProfile.progressValueFont = self.progressValueFont;
    newProfile.progressValueColor = self.progressValueColor;
    newProfile.progressValueFormat = self.progressValueFormat;
    
    newProfile.startAt = self.startAt;
    newProfile.clockwiseAs = self.clockwiseAs;
    
    return newProfile;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _progressType = CAMProgressValueTypeNumber;
        _lineWidth = 10;
        _lineColor = CAMHEXCOLOR(@"20b2aa");
        _progressValueFont = [UIFont systemFontOfSize:15.0f];
        _progressValueColor = CAMHEXCOLOR(@"20b2aa");
        _progressValueFormat = @"";
        _startAt = CAMProgressStartAtTop;
        _clockwiseAs = CAMProgressClockwiseAsYES;
    }
    return self;
}

@end
