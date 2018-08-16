//
//  CAMBaseChart.m
//  CAMChartDemo
//
//  Created by 欧阳峰 on 2018/8/9.
//  Copyright © 2018年 欧阳峰. All rights reserved.
//

#import "CAMBaseChart.h"



@implementation CAMBaseChart

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupBaseDefaultValues];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupBaseDefaultValues];
    }
    return self;
}






- (CAMChartProfile *)chartProfile{
    if(!_chartProfile){
        _chartProfile = [CAMChartProfileManager shareInstance].defaultProfile;
    }
    return _chartProfile;
}



-(void)setupBaseDefaultValues{
    self.clipsToBounds = YES;
    self.userInteractionEnabled = YES;
}

- (void)layoutSubviews{
    self.backgroundColor = self.chartProfile.backgroundColor;
    [super layoutSubviews];
}





- (void)drawChart{
//    [self doesNotRecognizeSelector:_cmd];
    [self drawChartWithAnimationDisplay:YES];
}

- (void)drawChartWithAnimationDisplay:(BOOL)animationDisplay{
    if(self.frame.size.width == 0 || self.frame.size.height == 0){
        @throw [NSException exceptionWithName:@"frame未指定" reason:@"请在调用 drawChart 函数之前设置图表的Frame." userInfo:nil];
    }
//    [self doesNotRecognizeSelector:_cmd];
    _animationDispayThisTime = animationDisplay;
}

@end
