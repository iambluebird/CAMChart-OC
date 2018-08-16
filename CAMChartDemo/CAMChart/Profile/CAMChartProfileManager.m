//
//  CAMChartProfileManager.m
//  CAMChartDemo
//
//  Created by 欧阳峰 on 2018/8/8.
//  Copyright © 2018年 欧阳峰. All rights reserved.
//

#import "CAMChartProfileManager.h"
#import "CAMColorKit.h"

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
        _defaultProfile.padding = 10.0f;
        
        _defaultProfile.backgroundColor = [UIColor whiteColor];
        _defaultProfile.themeColor = [UIColor blueColor];
        
        _defaultProfile.animationDisplay = YES;
        _defaultProfile.animationDuration = 1.0f;
        

#pragma mark - Line Chart
        /* XY坐标轴默认样式 */
        _defaultProfile.xyAxis = [[CAMXYAxisProfile alloc] initWithThemeColor:_defaultProfile.themeColor];
        
        _defaultProfile.xyAxis.showXAxis = YES;
        _defaultProfile.xyAxis.showYAxis = YES;
        _defaultProfile.xyAxis.lineWidth = 2.0f;
        _defaultProfile.xyAxis.lineColor = CAMHEXCOLOR(@"778899");
        
        _defaultProfile.xyAxis.unitFont = [UIFont systemFontOfSize:11.0f];
        _defaultProfile.xyAxis.unitColor = CAMHEXCOLOR(@"778899");
        
        _defaultProfile.xyAxis.showXLabel = YES;
        _defaultProfile.xyAxis.showYLabel = YES;
        _defaultProfile.xyAxis.xyLabelFont = [UIFont systemFontOfSize:11.0f];
        _defaultProfile.xyAxis.xyLabelColor = CAMHEXCOLOR(@"778899");
        _defaultProfile.xyAxis.yLabelFormat = @"%0.1f";
        _defaultProfile.xyAxis.yLabelDefaultCount = 5;
        
        _defaultProfile.xyAxis.showXGrid = YES;
        _defaultProfile.xyAxis.showYGrid = YES;
        _defaultProfile.xyAxis.gridStyle = CAMXYAxisGridStyleDependOnStep;
        _defaultProfile.xyAxis.gridStepSize = 20.0f;
        _defaultProfile.xyAxis.gridColor = CAMHEXCOLOR(@"dcdcdc");
        
        
        /* Line Chart 默认样式 */
        _defaultProfile.lineChart.lineStyle = CAMChartLineStyleStraight;
        _defaultProfile.lineChart.lineWidth = 2;
        
        _defaultProfile.lineChart.showPoint = YES;
        _defaultProfile.lineChart.showPointLabel = YES;
        _defaultProfile.lineChart.pointLabelFontSize = 11;
        _defaultProfile.lineChart.pointLabelFontColor = CAMHEXCOLOR(@"4682b4");
        
        
#pragma mark - Circle Progress Chart
        /* Circle Axis 默认样式 */
        _defaultProfile.circleAxis.showAxis = YES;
        _defaultProfile.circleAxis.lineWidth = 10;
        _defaultProfile.circleAxis.lineColor = CAMHEXCOLOR(@"f5f5f5");
        _defaultProfile.circleAxis.topTagFont = [UIFont systemFontOfSize:11.0f];
        _defaultProfile.circleAxis.topTagColor = CAMHEXCOLOR(@"778899");
        _defaultProfile.circleAxis.topTagMargin = 5;
        _defaultProfile.circleAxis.bottomTagFont = [UIFont systemFontOfSize:11.0f];
        _defaultProfile.circleAxis.bottomTagColor = CAMHEXCOLOR(@"778899");
        _defaultProfile.circleAxis.bottomTagMargin = 5;
        
        
        /* Circle Progress Chart 默认样式 */
        _defaultProfile.circleProgress.progressType = CAMProgressValueTypeNumber;
        _defaultProfile.circleProgress.lineWidth = 10;
        _defaultProfile.circleProgress.lineColor = CAMHEXCOLOR(@"20b2aa");
        _defaultProfile.circleProgress.progressValueFont = [UIFont systemFontOfSize:15.0f];
        _defaultProfile.circleProgress.progressValueColor = CAMHEXCOLOR(@"20b2aa");
        _defaultProfile.circleProgress.progressValueFormat = @"";
        _defaultProfile.circleProgress.startAt = CAMProgressStartAtTop;
        _defaultProfile.circleProgress.clockwiseAs = CAMProgressClockwiseAsYES;
        
        
#pragma mark - 色彩表
        /* 配色方案 */
        NSMutableArray *lineColors = [NSMutableArray new];
        [lineColors addObject:CAMHEXCOLOR(@"20b2aa")];
        [lineColors addObject:CAMHEXCOLOR(@"a52a2a")];
        [lineColors addObject:CAMHEXCOLOR(@"6a5acd")];
        [lineColors addObject:CAMHEXCOLOR(@"ff6347")];
        [lineColors addObject:CAMHEXCOLOR(@"2f4f4f")];
        [lineColors addObject:CAMHEXCOLOR(@"6b8e23")];
        [lineColors addObject:CAMHEXCOLOR(@"c71585")];
        [lineColors addObject:CAMHEXCOLOR(@"b8860b")];
        [lineColors addObject:CAMHEXCOLOR(@"00bfff")];
        [lineColors addObject:CAMHEXCOLOR(@"4682b4")];
        
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
