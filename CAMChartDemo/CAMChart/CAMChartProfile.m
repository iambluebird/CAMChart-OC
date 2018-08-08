//
//  CAMChartProfile.m
//  CAMChartDemo
//
//  Created by 欧阳峰 on 2018/8/8.
//  Copyright © 2018年 欧阳峰. All rights reserved.
//

#import "CAMChartProfile.h"



@implementation CAMChartProfile

-(id)mutableCopyWithZone:(NSZone *)zone{
    CAMChartProfile *newProfile = [[CAMChartProfile alloc] init];
    newProfile.margin = self.margin;
    return newProfile;
}

@end
