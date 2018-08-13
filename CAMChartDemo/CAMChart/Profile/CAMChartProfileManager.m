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

//利用私有化的initPrivate方法初始化实例，能够实现内部数据的初始化
-(instancetype)initPrivate{
    self = [super init];
    if (self) {
        _customProfiles = [[NSMutableArray alloc]init];
    }
    return self;
}

//默认的Init方法被转接到了单例接口上
- (instancetype)init
{
    return [[self class]shareInstance];
}



#pragma mark - 各种主题配置文件定义

- (CAMChartProfile *)defaultProfile{
    if(!_defaultProfile){
        _defaultProfile = [[CAMChartProfile alloc] init];
        
        _defaultProfile.margin = 20.0f;
        
        _defaultProfile.backgroundColor = [UIColor whiteColor];
        _defaultProfile.themeColor = [UIColor blueColor];
        
        _defaultProfile.animationDisplay = YES;
        _defaultProfile.animationDuration = 1.0f;
        
        
        
        /* XY坐标轴默认样式 */
        _defaultProfile.xyAxis = [[CAMXYAxisProfile alloc] initWithThemeColor:_defaultProfile.themeColor];
        
        _defaultProfile.xyAxis.showXAxis = YES;
        _defaultProfile.xyAxis.showYAxis = YES;
        _defaultProfile.xyAxis.lineWidth = 2.0f;
        _defaultProfile.xyAxis.unitFont = [UIFont systemFontOfSize:11.0f];
        
        _defaultProfile.xyAxis.showXLabel = YES;
        _defaultProfile.xyAxis.showYLabel = YES;
        _defaultProfile.xyAxis.xyLabelFont = [UIFont systemFontOfSize:11.0f];
        _defaultProfile.xyAxis.yLabelFormat = @"%0.1f";
        _defaultProfile.xyAxis.yLabelDefaultCount = 5;
        
        _defaultProfile.xyAxis.showXGrid = YES;
        _defaultProfile.xyAxis.showYGrid = YES;
        _defaultProfile.xyAxis.gridStepSize = 20.0f;
        _defaultProfile.xyAxis.gridColor = [UIColor lightGrayColor];
        
        
        /* Line Chart 默认样式 */
        _defaultProfile.lineChart.lineStyle = CAMChartLineStyleStraight;
        _defaultProfile.lineChart.showPoint = YES;
        _defaultProfile.lineChart.showPointLabel = YES;
        _defaultProfile.lineChart.pointLabelFontSize = 11;
        _defaultProfile.lineChart.pointLabelFontColor = [UIColor blueColor];
        
        
        
        /* 配色方案 */
        NSMutableArray *lineColors = [NSMutableArray new];
        [lineColors addObject:[UIColor redColor]];
        [lineColors addObject:[UIColor purpleColor]];
        [lineColors addObject:[UIColor greenColor]];
        
        _defaultProfile.chartColors = lineColors;
        
    }
    return _defaultProfile;
}


#pragma mark - Custom Theme 管理方法
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
