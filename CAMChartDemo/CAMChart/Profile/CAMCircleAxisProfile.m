//
//  CAMCircleAxisProfile.m
//  CAMChartDemo
//
//  Created by 欧阳峰 on 2018/8/15.
//  Copyright © 2018年 欧阳峰. All rights reserved.
//

#import "CAMCircleAxisProfile.h"
#import "CAMColorKit.h"

@implementation CAMCircleAxisProfile

-(id)mutableCopyWithZone:(NSZone *)zone{
    CAMCircleAxisProfile *newProfile = [[CAMCircleAxisProfile alloc] init];
    
    newProfile.showAxis = self.showAxis;
    newProfile.lineWidth = self.lineWidth;
    newProfile.lineColor = self.lineColor;
    
    newProfile.topTagFont = self.topTagFont;
    newProfile.topTagColor = self.topTagColor;
    newProfile.topTagMargin = self.topTagMargin;
    
    newProfile.bottomTagFont = self.bottomTagFont;
    newProfile.bottomTagColor = self.bottomTagColor;
    newProfile.bottomTagMargin = self.bottomTagMargin;
    
    return newProfile;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _showAxis = YES;
        _lineWidth = 10;
        _lineColor = CAMHEXCOLOR(@"f5f5f5");
        _topTagFont = [UIFont systemFontOfSize:11.0f];
        _topTagColor = CAMHEXCOLOR(@"778899");
        _topTagMargin = 5;
        _bottomTagFont = [UIFont systemFontOfSize:11.0f];
        _bottomTagColor = CAMHEXCOLOR(@"778899");
        _bottomTagMargin = 5;
    }
    return self;
}


@end
