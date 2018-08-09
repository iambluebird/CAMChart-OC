//
//  CAMChartProfileManager.m
//  CAMChartDemo
//
//  Created by 欧阳峰 on 2018/8/8.
//  Copyright © 2018年 欧阳峰. All rights reserved.
//

#import "CAMChartProfileManager.h"

@interface CAMChartProfileManager(){
    NSMutableArray* _customProfiles;
}

@end

@implementation CAMChartProfileManager

#pragma mark - 单例实现

/*
 * CAMChartProfileManager 是一个单例管理器，这里对实例化过程进行了处理，无论采用
 * shareInstance / alloc init / new / copy / mutableCopy 哪种方法创建实例，
 * 都能确保Manager是一个单例存在
 *
 * 推荐使用 shareInstance 的方法，调用时更加明确
 */
static id _instance = nil;

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] initPrivate];
    });
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    return [CAMChartProfileManager shareInstance];
}

-(id)copyWithZone:(NSZone *)zone{
    return _instance;
}

-(id)mutableCopyWithZone:(NSZone *)zone{
    return _instance;
}

-(instancetype)initPrivate{
    self = [super init];
    if (self) {
        _customProfiles = [[NSMutableArray alloc]init];
    }
    return self;
}

- (instancetype)init
{
    return [[self class]shareInstance];
}





- (CAMChartProfile *)defaultProfile{
    if(!_defaultProfile){
        _defaultProfile = [[CAMChartProfile alloc] init];
        
        _defaultProfile.margin = 20.0f;
        
        _defaultProfile.backgroundColor = [UIColor whiteColor];
        _defaultProfile.themeColor = [UIColor blueColor];
        
        _defaultProfile.axisLineWidth = 2.0f;
        _defaultProfile.axisUnitFontSize = 11.0f;
    }
    return _defaultProfile;
}



#pragma mark - Custom Theme
- (void)registerCustomProfile:(CAMChartProfile *)profile{
    [_customProfiles addObject:profile];
}

- (CAMChartProfile *)customProfileForIndex:(NSInteger)index{
    if(index < 0){
        @throw [NSException exceptionWithName:@"Custom profile's pointer wrong!" reason:@"index不能为负数" userInfo:nil];
    }
    if(index >= _customProfiles.count){
        @throw [NSException exceptionWithName:@"Custom profile's pointer wrong!" reason:@"index超出自定义配置文件数量" userInfo:nil];
    }
    return _customProfiles[index];
}






@end
