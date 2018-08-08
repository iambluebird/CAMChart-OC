//
//  CAMChartProfileManager.h
//  CAMChartDemo
//
//  Created by 欧阳峰 on 2018/8/8.
//  Copyright © 2018年 欧阳峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CAMChartProfile.h"

//typedef NS_ENUM(NSUInteger, CAMChartProfileThemeType) {
//    CAMChartProfileThemeDefault = 0
//};


@interface CAMChartProfileManager : NSObject<NSCopying, NSMutableCopying>

@property(nonatomic, strong) CAMChartProfile *defaultProfile;

+(instancetype)shareInstance;
//+(CAMChartProfileManager*)shareInstance;





#pragma mark - Custom Theme
-(void)registerCustomProfile:(CAMChartProfile*)profile;
-(CAMChartProfile*)customProfileForIndex:(NSInteger)index;

@end
