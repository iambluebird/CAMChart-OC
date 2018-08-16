//
//  CAMCircleProgressChart.m
//  CAMChartDemo
//
//  Created by 欧阳峰 on 2018/8/15.
//  Copyright © 2018年 欧阳峰. All rights reserved.
//

#import "CAMCircleProgressChart.h"
#import "CAMUICountingLabel.h"

@interface CAMCircleProgressChart(){
    CGFloat _progressValue;
    CGFloat _progressDisplayValue;
    CGRect _chartRect;
    CGRect _valueRect;
}

@end


@implementation CAMCircleProgressChart

#pragma mark - 对外接口函数

- (void)addChartData:(CGFloat)chartData{
    _progressValue = chartData;
}

- (void)drawChart{
    [super drawChart];
}

- (void)drawChartWithAnimationDisplay:(BOOL)animationDisplay{
    if(_progressValue < _minValue || _progressValue > _maxValue){
        NSLog(@"进度值必须大于等于minValue且小于等于maxValue");
        return;
    }
    [super drawChartWithAnimationDisplay:animationDisplay];
    
    //do anything...
    [self calculationChartCanvas];
    [self calculationProgressDisplayValue];
    [self calculationValueRect];
    
    [self drawCircleProgress];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - 初始化及重载代码

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setDefaultValues];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setDefaultValues];
    }
    return self;
}

-(void)setDefaultValues{
    _progressValue = 0;
    self.minValue = 0;
    self.maxValue = 100;
}

- (void)drawRect:(CGRect)rect{
    CAMCoordinateAxisKit *axisKit = [[CAMCoordinateAxisKit alloc] init];
    [axisKit drawCircleCoordinateWithRect:_chartRect AxisProfile:self.chartProfile.circleAxis TopTag:self.topTag bottomTag:self.bottomTag ValueRect:_valueRect];
    [super drawRect:rect];
}




-(void)calculationChartCanvas{
    CGFloat rectWidth = CGRectGetWidth(self.frame);
    CGFloat rectHeight = CGRectGetHeight(self.frame);
    
    //默认认为用户设置的视图尺寸为正方形，如果出现不是正方形的情况，将在下一段代码中进行修正
    CGFloat canvasWidth = rectWidth - self.chartProfile.margin * 2;
    CGFloat canvasHeight = rectHeight - self.chartProfile.margin * 2;
    CGFloat canvasXMin = self.chartProfile.margin;
    CGFloat canvasYMin = self.chartProfile.margin;
    
    //如果视图不是正方形，找出宽和高中更小的那个值，作为正方形边长，并重新计算XY坐标点进行定位
    //最终目的是将视图可视区域定位在VIEW的中心位置
    if(canvasWidth != canvasHeight){
        CGFloat smallerValue = fminf(canvasWidth, canvasHeight);
        canvasWidth = smallerValue;
        canvasHeight = smallerValue;
        canvasXMin = (rectWidth - canvasWidth) / 2.0f;
        canvasYMin = (rectHeight - canvasHeight) / 2.0f;
    }
    
    //OK，这是已经修正过的，确保位于视图正中心的一个统计图可视绘制区域。
    _chartRect = CGRectMake(canvasXMin, canvasYMin, canvasWidth, canvasHeight);
}

-(void)calculationProgressDisplayValue{
    switch (self.chartProfile.circleProgress.progressType) {
        case CAMProgressValueTypePercent:
        {
            _progressDisplayValue = (_progressValue / (_maxValue - _minValue)) * 100.0f;
        }
            break;
        case CAMProgressValueTypeNumber:
        default:
            _progressDisplayValue = _progressValue;
            break;
    }
}

-(NSString*)progressValueFormatString{
    NSString *format;
    switch (self.chartProfile.circleProgress.progressType) {
        case CAMProgressValueTypePercent:
        {
            if([self.chartProfile.circleProgress.progressValueFormat length]){
                format = self.chartProfile.circleProgress.progressValueFormat;
            }else{
                format = @"%.0f%%";
            }
        }
            break;
        case CAMProgressValueTypeNumber:
        default:
            format = self.chartProfile.circleProgress.progressValueFormat;
            break;
    }
    if(![format length]) format = @"%.0f";
    return format;
}

-(void)calculationValueRect{
    NSString *progressDisplayString = [NSString stringWithFormat:[self progressValueFormatString], _maxValue];  //使用最大值来预估valueRect所需尺寸
    CGFloat largerLineWidth = fmaxf(self.chartProfile.circleAxis.lineWidth, self.chartProfile.circleProgress.lineWidth);
    CGFloat maxDisplayWidth = CGRectGetWidth(_chartRect) - largerLineWidth - 20;
    if(maxDisplayWidth<0) maxDisplayWidth = 0;
    
    CGSize size = [CAMTextKit sizeOfString:progressDisplayString Font:self.chartProfile.circleProgress.progressValueFont Width:maxDisplayWidth];
    _valueRect = CGRectMake(CGRectGetMidX(_chartRect) - size.width / 2,
                            CGRectGetMidY(_chartRect) - size.height / 2,
                            size.width,
                            size.height);
}


-(void)drawCircleProgress{
    
    CAShapeLayer *chartLayer = [CAShapeLayer layer];
    chartLayer.lineCap = kCALineCapRound;
    chartLayer.lineJoin = kCALineJoinRound;
    chartLayer.lineWidth = self.chartProfile.circleProgress.lineWidth;
    chartLayer.fillColor = [UIColor clearColor].CGColor;
    chartLayer.strokeColor = self.chartProfile.circleProgress.lineColor.CGColor;
    chartLayer.path = [self circleProgressPath].CGPath;
    
    CGFloat strokeStart, strokeEnd;
    CGFloat progressValueEqualPercent = _progressValue / (_maxValue - _minValue);
    
    strokeStart = 0;
    strokeEnd = progressValueEqualPercent;
    
    chartLayer.strokeStart = strokeStart;
    chartLayer.strokeEnd = strokeEnd;
    
    [self.layer addSublayer:chartLayer];
    
    CAMUICountingLabel *progressLabel = [[CAMUICountingLabel alloc] initWithFrame:_valueRect];
    [progressLabel setTextAlignment:NSTextAlignmentCenter];
    [progressLabel setFont:self.chartProfile.circleProgress.progressValueFont];
    [progressLabel setTextColor:self.chartProfile.circleProgress.progressValueColor];
    [progressLabel setBackgroundColor:[UIColor clearColor]];
    progressLabel.method = CAMUILabelCountingMethodEaseOut;
    progressLabel.format = [self progressValueFormatString];
    CGFloat fromValue, toValue;
    if(self.chartProfile.circleProgress.progressType == CAMProgressValueTypeNumber){
        fromValue = _minValue;
        toValue = _progressValue;
    }else{
        fromValue = 0;
        toValue = progressValueEqualPercent * 100;
    }
    if(!self.chartProfile.animationDisplay || !_animationDispayThisTime){
        fromValue = toValue;
    }
    [self addSubview:progressLabel];
    
    if(self.chartProfile.animationDisplay && _animationDispayThisTime){
        [chartLayer addAnimation:[self animationForCircleProgressWithStrokeStart:strokeStart StrokeEnd:strokeEnd] forKey:@"strokeEndAnimation"];
    }
    [progressLabel countFrom:fromValue to:toValue withDuration:self.chartProfile.animationDuration];
}

-(UIBezierPath*) circleProgressPath{
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint startPoint;
    CGPoint centerPoint = CGPointMake(CGRectGetMidX(_chartRect), CGRectGetMidY(_chartRect));
    CGFloat raduis = CGRectGetWidth(_chartRect) / 2;
    CGFloat startAngle, endAngle;
    
    switch (self.chartProfile.circleProgress.startAt) {
        case CAMProgressStartAtTop:
            startPoint = CGPointMake(CGRectGetMidX(_chartRect), CGRectGetMinY(_chartRect));
            startAngle = (CGFloat)(1.5 * M_PI);
            break;
        case CAMProgressStartAtLeft:
            startPoint = CGPointMake(CGRectGetMinX(_chartRect), CGRectGetMidY(_chartRect));
            startAngle = (CGFloat)(M_PI);
            break;
        case CAMProgressStartAtBottom:
            startPoint = CGPointMake(CGRectGetMidX(_chartRect), CGRectGetMaxY(_chartRect));
            startAngle = (CGFloat)(0.5 * M_PI);
            break;
        case CAMProgressStartAtRight:
        default:
            startPoint = CGPointMake(CGRectGetMaxX(_chartRect), CGRectGetMidY(_chartRect));
            startAngle = 0;
            break;
    }
    
    BOOL clockwise = self.chartProfile.circleProgress.clockwiseAs == CAMProgressClockwiseAsYES;
    if(clockwise){
        endAngle = startAngle + (CGFloat)(2 * M_PI);
    }else{
        endAngle = startAngle - (CGFloat)(2 * M_PI);
    }
    
    [path moveToPoint:startPoint];
    [path addArcWithCenter:centerPoint radius:raduis startAngle:startAngle endAngle:endAngle clockwise:clockwise];
    
    return path;
}


-(CABasicAnimation*)animationForCircleProgressWithStrokeStart:(CGFloat)strokeStart StrokeEnd:(CGFloat)strokeEnd{
    CABasicAnimation *ani;
    ani = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    ani.duration = self.chartProfile.animationDuration;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    ani.fromValue = [NSNumber numberWithFloat:strokeStart];
    ani.toValue = [NSNumber numberWithFloat:strokeEnd];
    return ani;
}

@end
