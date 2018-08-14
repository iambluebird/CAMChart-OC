//
//  CAMLineChart.m
//  CAMChartDemo
//
//  Created by 欧阳峰 on 2018/8/9.
//  Copyright © 2018年 欧阳峰. All rights reserved.
//

#import "CAMLineChart.h"
#import "CAMColorKit.h"

@interface CAMLineChart(){
    
    CGFloat _minTruncValue, _maxTruncValue;                 //定义：近似最小值，近似最大值
    NSInteger _maxCountInDatas;                             //所有数据线中数据个数的最大数量，X轴将以这个值进行绘制，避免线条超出视图
    CGRect _chartRect;                                      //图表绘制区域（排除坐标系以及安全距离后，可用于绘制线条的区域）
    CGFloat _yLabelHoldWidth;                               //如果显示了Y轴的Label，此时需要留出这些标签的宽度作为占位
    NSMutableArray *_xPositions;                            //x轴数据节点，如果只有一个数据点的时候，这个节点在X轴中间
    NSMutableArray *_chartLines;                            //multiChartDatas 映射到图表上的各个线条，存储的是array of point
    
    //将Layer层数据保持到全局来，重绘时需要将原有Layer全部清除掉
    NSMutableArray *_chartLineLayers, *_pointLayers, *_pointLabelLayers;
}

@property (nonatomic, strong) NSMutableArray *multiChartDatas;      //存储图表数据，支持多个数据线条

@end


@implementation CAMLineChart

#pragma mark - 对外接口函数

- (void)addChartData:(NSArray *)chartData{
    [self.multiChartDatas addObject:chartData];
}


- (void)drawChart{
    [super drawChart];
}

- (void)drawChartWithAnimationDisplay:(BOOL)animationDisplay{
    [super drawChartWithAnimationDisplay:animationDisplay];
    if(self.frame.size.width == 0 || self.frame.size.height == 0){
        @throw [NSException exceptionWithName:@"frame未指定" reason:@"请在调用 drawChart 函数之前设置图表的Frame." userInfo:nil];
    }
    [self resetOldDatas];
    [self calculationFeatureData];
    [self calculationYLabels];
    [self calculationXLables];
    [self calculationChartCanvas];
    [self calculationXPositions];
    [self mapChartDataToCanvas];
    [self drawChartLines];
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
        _minValue = FLT_MIN;
        _maxValue = FLT_MAX;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _minValue = FLT_MIN;
        _maxValue = FLT_MAX;
    }
    return self;
}


- (NSMutableArray *)multiChartDatas{
    if(!_multiChartDatas){
        _multiChartDatas = [NSMutableArray new];
    }
    return _multiChartDatas;
}



//坐标系的绘制实在 drawRect 重载方法里完成的
- (void)drawRect:(CGRect)rect{
    CAMCoordinateAxisKit *axisKit = [[CAMCoordinateAxisKit alloc] init];
    [axisKit drawXYCoordinateWithRect:rect ChartProfile:self.chartProfile.xyAxis CanvasMargin: self.chartProfile.margin CanvasPadding: self.chartProfile.padding xUnit:self.xUnit yUnit:self.yUnit xLabels:self.xLabels yLabels:self.yLabels];
    [super drawRect:rect];
}





#pragma mark - 视图计算函数

/**
 清理上一次绘制时的历史数据，尤其是已绘制图层需要清理掉
 */
-(void)resetOldDatas{
    if(_xPositions){
        [_xPositions removeAllObjects];
    }else{
        _xPositions = [NSMutableArray new];
    }
    
    if(_chartLines){
        [_chartLines removeAllObjects];
    }else{
        _chartLines = [NSMutableArray new];
    }
    
    if(_chartLineLayers){
        for (CALayer *layer in _chartLineLayers) {
            [layer removeFromSuperlayer];
        }
        [_chartLineLayers removeAllObjects];
    }else{
        _chartLineLayers = [NSMutableArray new];
    }
    
    if(_pointLayers){
        for (CALayer *layer in _pointLayers) {
            [layer removeFromSuperlayer];
        }
        [_pointLayers removeAllObjects];
    }else{
        _pointLayers = [NSMutableArray new];
    }
    
    if(_pointLabelLayers){
        for (CALayer *layer in _pointLabelLayers) {
            [layer removeFromSuperlayer];
        }
        [_pointLabelLayers removeAllObjects];
    }else{
        _pointLabelLayers = [NSMutableArray new];
    }
}


/**
 计算数据特征值，提取出统计图需要表示的最大值和最小值，
 如果没有手工指定统计图的minValue和maxValue，则使用
 这里提取出的特征值作为Y轴上下限。
 */
-(void)calculationFeatureData{
    _maxCountInDatas = 0;
    //合并所有线条上的数据，提取各项特征值
    NSMutableArray *fullData = [NSMutableArray new];
    for (NSArray *datas in self.multiChartDatas) {
        [fullData addObjectsFromArray:datas];
        if(datas.count > _maxCountInDatas) _maxCountInDatas = datas.count;
    }
    
    if(_minValue!=FLT_MIN && _maxValue!=FLT_MAX){
        _minTruncValue = _minValue;
        _maxTruncValue = _maxValue;
    }else{
        CGFloat minValue = [[fullData valueForKeyPath:@"@min.floatValue"] floatValue];
        CGFloat maxValue = [[fullData valueForKeyPath:@"@max.floatValue"] floatValue];
        
        //对最小值和最大值进行取整操作，控制坐标轴的数据可视范围
        _minTruncValue = floor(minValue / 10.0) * 10.0f;
        _maxTruncValue = ceil(maxValue / 10.0) * 10.0f;
    }
    
    
}


/**
 计算Y轴标签，如果调用时指定了标签内容，此函数不执行。
 注意：即使配置信息里设置不显示Y轴标签，这里仍然需要计算出来，用于Y轴数据节点定位。
 */
-(void)calculationYLabels{
    //如果没有指定yLabel的情况下，通过数据计算出默认的标签
    //具体使用几个标签数量，根据配置文件 Profile.xyAxis.yLabelDefaultCount 而定
    if([self.yLabels count]) return;    //如果指定了yLabels，则不需要重新计算
    CGFloat yStepValue = (_maxTruncValue - _minTruncValue) / (self.chartProfile.xyAxis.yLabelDefaultCount - 1);
    NSMutableArray *arrLabels = [NSMutableArray new];
    for (NSInteger i = 0; i < self.chartProfile.xyAxis.yLabelDefaultCount; i++) {
        [arrLabels addObject: [NSString stringWithFormat:self.chartProfile.xyAxis.yLabelFormat, _minTruncValue + yStepValue * i]];
    }
    self.yLabels = arrLabels;
}


/**
 计算X轴标签
 注意：即使配置信息里设置不显示X轴标签，仍然需要计算一下用于X轴数据节点定位。
 另：如果发现配置信息里配置的X轴标签数量少于单条数据线上的数据节点数量，此时
    需要在X轴标签上进行补足，避免该条数据线超出视图可视范围。
 */
-(void)calculationXLables{
    //如果没有指定xLabel，则根据传入数据的个数，默认生成同等数量的空Label
    if(![self.xLabels count]){
        NSMutableArray *arrLabels = [NSMutableArray new];
        for (NSInteger i = 0; i<_maxCountInDatas; i++) {
            [arrLabels addObject:@""];
        }
        self.xLabels = arrLabels;
    }
    //如果指定的xLabel数量少于数据量，不足的部分补充空Label
    if(self.xLabels.count < _maxCountInDatas){
        NSMutableArray *arrLabels = [NSMutableArray arrayWithArray:self.xLabels];
        for (NSInteger i = self.xLabels.count; i<_maxCountInDatas; i++) {
            [arrLabels addObject:@""];
        }
        self.xLabels = arrLabels;
    }
    //注意：对xLabel标签进行补足，是为了避免出现线条图超出chart视图区域。
    //一个chart视图在横向上能展示多少个数据点，是根据xLabel的数量而定的。
}


/**
 计算出Chart视图的可视范围，主要就是margin位移以及Y轴标签占位位移量的计算。
 */
-(void)calculationChartCanvas{
    
    CGFloat rectWidth = CGRectGetWidth(self.frame);
    CGFloat rectHeight = CGRectGetHeight(self.frame);
    
    //计算Y轴上Label占据的宽度，安全绘制区域需要让出这个宽度距离来
    _yLabelHoldWidth = 0.0f;
    if(self.chartProfile.xyAxis.showYLabel){
        if([self.yLabels count]){
            CGFloat yLabelMaxWidth = 60.0f;
            //循环得到每个label的尺寸，并找出最大宽度作为水平方向向右偏移量，留出label标签的位置
            NSMutableArray *yLabelWidths = [NSMutableArray new];
            for (NSString* text in self.yLabels) {
                CGSize size = [CAMTextKit sizeOfString:text Font:self.chartProfile.xyAxis.xyLabelFont Width:yLabelMaxWidth];
                [yLabelWidths addObject: [NSNumber numberWithFloat:size.width]];
            }
            //以最大的Y轴标签宽度作为占位基准宽度
            CGFloat maxValue = [[yLabelWidths valueForKeyPath:@"@max.floatValue"] floatValue];
            _yLabelHoldWidth = maxValue + CAM_XYCOORDINATE_LABEL_SAVE_OFFSET; //计算出Y轴标签占位宽度，与Y轴之间留出安全距离
        }
    }
    
    CGFloat canvasWidth = rectWidth - self.chartProfile.margin * 2 - _yLabelHoldWidth - self.chartProfile.padding * 2;
    CGFloat canvasHeight = rectHeight - self.chartProfile.margin * 2 - self.chartProfile.padding * 2;
    CGFloat canvasXMin = self.chartProfile.margin + _yLabelHoldWidth + self.chartProfile.padding;
    CGFloat canvasYMin = self.chartProfile.margin + self.chartProfile.padding;
    //得到了图表绘制的rect，与坐标系中的Grid部分重叠
    _chartRect = CGRectMake(canvasXMin, canvasYMin, canvasWidth, canvasHeight);
    
}


/**
 根据xLabel数量计算出数据在X轴上的数据点定位，
 Y轴的定位根据数值与Y轴范围进行百分比计算进行定位，
 联合X定位和Y定位即可获得该数据节点在视图中的显示坐标。
 */
-(void)calculationXPositions{
    //计算出x坐标数据节点
//    _xPositions = [NSMutableArray new];
    if([self.xLabels count]){
        CGFloat xStart = self.chartProfile.margin + _yLabelHoldWidth + self.chartProfile.padding;
        CGFloat xStep = 0;
        
        if(self.xLabels.count == 1){
            //如果X轴上只有一个数据标签，那么这个数据点呈现在视图中间
            xStart = self.chartProfile.margin + _yLabelHoldWidth + self.chartProfile.padding + _chartRect.size.width / 2;
        }else{
            //如果X轴上超出一个数据标签，从xMin开始，步进一直到xMax，xStep就是步进值
            xStep = _chartRect.size.width / (self.xLabels.count - 1);
        }
        
        CGFloat xPoint = xStart;
        for (NSInteger i = 0; i < self.xLabels.count; i++) {
            [_xPositions addObject:[NSNumber numberWithFloat:xPoint]];
            xPoint += xStep;
        }
    }
}


/**
 将统计图数据（可能包含多条数据线）映射到视图坐标上。
 X方向为数据节点在数据线上的下标位置，
 Y方向为数据节点在Y轴呈现百分比量。
 */
-(void)mapChartDataToCanvas{
    //effectiveValue 是这个图表能够展示的有效数级值，根据这个数值，通过百分比运算可以得知需要展示的数据的Y坐标
    CGFloat effectiveValue = _maxTruncValue - _minTruncValue;
//    _chartLines = [NSMutableArray new];
    //读取每条线条数据
    for (NSArray* chartDatas in self.multiChartDatas) {
        //读取线条数据中的每个数据节点
        NSMutableArray *eachLine = [NSMutableArray new];
        for (NSInteger i = 0; i<chartDatas.count; i++) {
            CGFloat value = [chartDatas[i] floatValue];
            CGFloat xPosition = [_xPositions[i] floatValue];
            CGFloat yOffset = ((value - _minTruncValue) / effectiveValue) * _chartRect.size.height;
            CGFloat yPosition = _chartRect.origin.y + _chartRect.size.height - yOffset;
            CGPoint point = CGPointMake(xPosition, yPosition);
            [eachLine addObject:[NSValue valueWithCGPoint:point]];
        }
        [_chartLines addObject:eachLine];
    }
}


/**
 将数据线绘制到视图上
 */
-(void)drawChartLines{
    
    //绘制顺序：线条 -> 节点 -> 节点标签
    
    NSArray *chartLinePaths = [self makeDataLines];
    
    for (NSInteger i = 0; i < chartLinePaths.count; i++) {
        UIBezierPath *linePath = chartLinePaths[i];
        CAShapeLayer *chartLineLayer = [CAShapeLayer layer];
        chartLineLayer.lineCap = kCALineCapRound;
        chartLineLayer.lineJoin = kCALineJoinRound;
        chartLineLayer.lineWidth = self.chartProfile.lineChart.lineWidth;
        chartLineLayer.fillColor = [UIColor clearColor].CGColor;
        chartLineLayer.strokeColor = [self.chartProfile chartColorWithIndex:i].CGColor;
        chartLineLayer.path = linePath.CGPath;
        
        [self.layer addSublayer:chartLineLayer];
        [_chartLineLayers addObject:chartLineLayer];
        
        
        CALayer *pointLayer = [self pointLayerWithChartLineIndex:i];
        if(pointLayer) [_pointLayers addObject:pointLayer];
        
        if(self.chartProfile.animationDisplay && _animationDispayThisTime){
            [CATransaction begin];
            
            [chartLineLayer addAnimation:[self animationForChartLine] forKey:@"strokeEndAnimation"];
            if(pointLayer) [pointLayer addAnimation:[self animationForChartPoint] forKey:@"opacityAnimation"];
            
            [CATransaction commit];
        }
    }
    
    NSArray* pointLabelLayers = [self makePointLabels];
    [_pointLabelLayers addObjectsFromArray:pointLabelLayers];
    
    if(self.chartProfile.animationDisplay && _animationDispayThisTime){
        for (CALayer *layer in pointLabelLayers) {
            [layer addAnimation:[self animationForChartPoint] forKey:nil];
        }
    }
    
}


/**
 将数据映射点转换为绘图路径，可能包括多条数据线

 @return array of UIBezierPath
 */
-(NSArray*) makeDataLines{
    NSArray *result;
    switch (self.chartProfile.lineChart.lineStyle) {
        case CAMChartLineStyleStraight:
            result = [self makeDataLinesAsStraight];
            break;
        case CAMChartLineStyleCurve:
            result = [self makeDataLinesAsCurve];
            break;
        default:
            result = [self makeDataLinesAsCurve];
            break;
    }
    return result;
}


/**
 折线类型路径

 @return array of UIBezierPath
 */
-(NSArray*) makeDataLinesAsStraight{
    //直线路径straight line
    NSMutableArray *chartLinePaths = [NSMutableArray new];
    for (NSArray *line in _chartLines) {
        UIBezierPath *linePath = [UIBezierPath bezierPath];
        [linePath moveToPoint:[line[0] CGPointValue]];
        for (NSInteger i = 1; i<line.count; i++) {
            CGPoint point = [line[i] CGPointValue];
            [linePath addLineToPoint:point];
        }
        [chartLinePaths addObject:linePath];
    }
    return chartLinePaths;
}


/**
 曲线类型路径

 @return array of UIBezierPath
 */
-(NSArray*) makeDataLinesAsCurve{
    NSMutableArray *chartLinePaths = [NSMutableArray new];
    //贝塞尔曲线路径curve
    for (NSArray *line in _chartLines) {
        UIBezierPath *linePath = [UIBezierPath bezierPath];
        [linePath moveToPoint:[line[0] CGPointValue]];
        CGPoint fromPoint = [line[0] CGPointValue];
        for (NSInteger i = 1; i<line.count; i++) {
            CGPoint toPoint = [line[i] CGPointValue];
            CGPoint midPoint = [self midPointWithPointA:fromPoint PointB:toPoint];
            [linePath addQuadCurveToPoint:midPoint controlPoint:[self bezierControlPointBetweenPointA:midPoint andPointB:fromPoint]];
            [linePath addQuadCurveToPoint:toPoint controlPoint:[self bezierControlPointBetweenPointA:midPoint andPointB:toPoint]];
            fromPoint = toPoint;
        }
        [chartLinePaths addObject:linePath];
    }
    return chartLinePaths;
}

/**
 为一条数据线生成节点图层

 @param lineIndex 数据线下标
 @return 节点表示图层
 */
-(CAShapeLayer*)pointLayerWithChartLineIndex:(NSInteger)lineIndex{
    if(!self.chartProfile.lineChart.showPoint) return nil;
    NSArray* chartLine = _chartLines[lineIndex];
    UIBezierPath *pointPath = [UIBezierPath bezierPath];
    for (NSInteger i = 0; i<chartLine.count; i++) {
        CGPoint point = [chartLine[i] CGPointValue];
        [pointPath moveToPoint: CGPointMake(point.x + self.chartProfile.lineChart.lineWidth, point.y)];
        [pointPath addArcWithCenter:point radius:self.chartProfile.lineChart.lineWidth startAngle:0 endAngle:(CGFloat)(2*M_PI) clockwise:YES];
    }
    
    CAShapeLayer *pointLayer = [CAShapeLayer layer];
    pointLayer.lineCap = kCALineCapRound;
    pointLayer.lineJoin = kCALineJoinRound;
    pointLayer.lineWidth = self.chartProfile.lineChart.lineWidth;
    pointLayer.fillColor = self.chartProfile.backgroundColor.CGColor;
    UIColor *pointColor = [CAMColorKit deepenWithColor:[self.chartProfile chartColorWithIndex:lineIndex]];
    pointLayer.strokeColor = pointColor.CGColor;
    pointLayer.path = pointPath.CGPath;
    [self.layer addSublayer:pointLayer];
    
    return pointLayer;
}


/**
 生成所有的数据节点标签

 @return array of layer
 */
-(NSArray*)makePointLabels{
    
    if(!self.chartProfile.lineChart.showPointLabel) return nil;
    
    NSMutableArray* labelLayers = [NSMutableArray new];
    for (NSInteger lineIndex = 0; lineIndex < self.multiChartDatas.count; lineIndex++) {
        NSArray *lineDatas = self.multiChartDatas[lineIndex];
        NSArray *chartLine = _chartLines[lineIndex];
        for (NSInteger dataIndex = 0; dataIndex < lineDatas.count; dataIndex++) {
            
            CGPoint point = [chartLine[dataIndex] CGPointValue];
            CGFloat pointValue = [self.multiChartDatas[lineIndex][dataIndex] floatValue];
            NSString *pointString = [NSString stringWithFormat:self.chartProfile.lineChart.pointLabelFormat, pointValue];
            
            CGSize size = [CAMTextKit sizeOfString:pointString Font:[UIFont systemFontOfSize:self.chartProfile.lineChart.pointLabelFontSize] Width:40];
            CGRect textRect = CGRectMake(point.x - size.width / 2, point.y - size.height - 3, size.width, size.height);
            CATextLayer *textLayer = [CATextLayer layer];
            textLayer.alignmentMode = kCAAlignmentCenter;
            textLayer.foregroundColor = self.chartProfile.lineChart.pointLabelFontColor.CGColor;
            textLayer.backgroundColor = [UIColor clearColor].CGColor;
            textLayer.font = (__bridge CFTypeRef _Nullable)([UIFont systemFontOfSize:self.chartProfile.lineChart.pointLabelFontSize]);
            textLayer.fontSize = self.chartProfile.lineChart.pointLabelFontSize;
            textLayer.string = pointString;
            textLayer.frame = textRect;
            textLayer.contentsScale = [UIScreen mainScreen].scale;
            
            [self.layer addSublayer:textLayer];
            [labelLayers addObject:textLayer];
        }
    }
    return labelLayers;
}


#pragma mark - 换算函数
-(CGPoint)midPointWithPointA:(CGPoint)pointA PointB:(CGPoint)pointB{
    return CGPointMake((pointA.x + pointB.x) / 2, (pointA.y + pointB.y) / 2);
}

-(CGPoint)bezierControlPointBetweenPointA:(CGPoint)pointA andPointB:(CGPoint)pointB {
    CGPoint controlPoint = [self midPointWithPointA:pointA PointB:pointB];
    CGFloat diffY = abs((int) (pointB.y - controlPoint.y));
    if (pointA.y < pointB.y)
        controlPoint.y += diffY;
    else if (pointA.y > pointB.y)
        controlPoint.y -= diffY;
    return controlPoint;
}

#pragma mark - 动画函数
- (CABasicAnimation *)animationForChartLine {
    CABasicAnimation *ani;
    ani = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    ani.duration = self.chartProfile.animationDuration * 0.8;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    ani.fromValue = @0.0f;
    ani.toValue = @1.0f;
    return ani;
}

-(CABasicAnimation *)animationForChartPoint{
    CABasicAnimation *ani;
    ani = [CABasicAnimation animationWithKeyPath:@"opacity"];
    ani.duration = self.chartProfile.animationDuration * 0.2;
    ani.beginTime = CACurrentMediaTime() + self.chartProfile.animationDuration * 0.8;
    ani.fillMode = kCAFillModeBackwards;
    ani.fromValue = @0.0f;
    ani.toValue = @1.0f;
    return ani;
}



@end
