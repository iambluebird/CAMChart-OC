//
//  CAMChartProfileManager.h
//  CAMChartDemo
//  全局配置文件管理器，单例对象
//  Created by 欧阳峰 on 2018/8/8.
//  Copyright © 2018年 欧阳峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CAMChartProfile.h"




@interface CAMChartProfileManager : NSObject<NSCopying, NSMutableCopying>


/**
 默认主题配置文件
 */
@property(nonatomic, strong) CAMChartProfile *defaultProfile;




/**
 获得PM实例，PM是一个单例，推荐使用本接口获得实例对象。
 通过 alloc / copy 等方法均获得的是单例对象，但是不推荐。

 @return PM实例
 */
+(instancetype)shareInstance;





#pragma mark - Custom Theme

/**
 注册一个新的配置文件，交由PM托管，实现全局通用

 @param profile 配置文件，一般通过现有配置文件copy一份出来
 */
-(void)registerCustomProfile:(CAMChartProfile*)profile;


/**
 读取一份被托管的配置文件

 @param index 数组下标
 @return 配置文件
 */
-(CAMChartProfile*)customProfileForIndex:(NSInteger)index;

@end
