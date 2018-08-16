//
//  CircleProgressChartViewController.m
//  CAMChartDemo
//
//  Created by 欧阳峰 on 2018/8/15.
//  Copyright © 2018年 欧阳峰. All rights reserved.
//

#import "CircleProgressChartViewController.h"
#import "CAMChart.h"

@interface CircleProgressChartViewController ()

@end

@implementation CircleProgressChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"CircleProgressChart";
    [self addDemoCharts];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void)addDemoCharts{
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat offsetY = 100;
    
    
    
    
    //头部chart
    //演示：从defaultProfile 克隆一份配置文件出来进行修改
    CAMChartProfile *profile_0 = [[CAMChartProfileManager shareInstance].defaultProfile mutableCopy];
    profile_0.circleAxis.topTagFont = [UIFont systemFontOfSize:15];
    profile_0.circleProgress.progressValueFont = [UIFont boldSystemFontOfSize:25];
    profile_0.animationDisplay = NO;
    
    CAMCircleProgressChart *chart_0 = [[CAMCircleProgressChart alloc]init];
    [chart_0 setFrame:CGRectMake(0, offsetY, screenWidth, 200)];
    chart_0.chartProfile = profile_0;
    chart_0.topTag = @"Circle Progress";
    chart_0.bottomTag = @"camchart";
    [chart_0 addChartData:75];
    [chart_0 drawChart];
    [self.view addSubview:chart_0];
    
    offsetY += chart_0.frame.size.height;
    [self addSplitLineWithOffsetY:offsetY];
    offsetY += 1;
    
    
    
    
    
    
    
    
    //演示：起点、方向、委托 CAMChartProfileManager 管理配置文件
    CGFloat chartWidth = screenWidth / 4;   //我准备一行绘制4个chart，对宽度进行平均分配一下
    
    CAMChartProfileManager *pm = [CAMChartProfileManager shareInstance];    //获得manager单例实例
    CAMChartProfile *tempProfile = [pm.defaultProfile mutableCopy];         //通过pm复制一份默认配置文件，在此基础上进行修改，作为接下来所有视图配置文件的母版
    
    //设置母版样式
    tempProfile.circleAxis.lineWidth = 4;       //修改一下chart中线条宽度
    tempProfile.circleProgress.lineWidth = 4;
    tempProfile.circleAxis.bottomTagFont = [UIFont systemFontOfSize:7];
    [pm registerCustomProfile:tempProfile];     //将刚刚克隆的母版托管到pm中，在项目其他位置通过pm随时可获得该母版配置
    
    //开始绘制chart
    //-------------------- LEFT 逆时针
    CAMChartProfile *profile_left = [[pm customProfileForIndex:0] mutableCopy];       //从pm中取出之前委托的母版，由于这里属性会发生变化而不希望改变母版属性，所以我们克隆一份。
    profile_left.circleProgress.startAt = CAMProgressStartAtLeft;   //从左侧开始绘制
    profile_left.circleProgress.clockwiseAs = CAMProgressClockwiseAsNO;
    
    CAMCircleProgressChart *chart_left = [[CAMCircleProgressChart alloc] initWithFrame:CGRectMake(0 * chartWidth, offsetY, chartWidth, 100)];
    chart_left.chartProfile = profile_left;
    chart_left.bottomTag = @"LEFT";
    [chart_left addChartData:75];
    [chart_left drawChart];
    [self.view addSubview:chart_left];
    
    //-------------------- TOP 逆时针
    CAMChartProfile *profile_top = [[pm customProfileForIndex:0] mutableCopy];
    profile_top.circleProgress.startAt = CAMProgressStartAtTop;
    profile_top.circleProgress.clockwiseAs = CAMProgressClockwiseAsNO;

    CAMCircleProgressChart *chart_top = [[CAMCircleProgressChart alloc] initWithFrame:CGRectMake(1 * chartWidth, offsetY, chartWidth, 100)];
    chart_top.chartProfile = profile_top;
    chart_top.bottomTag = @"TOP";
    [chart_top addChartData:75];
    [chart_top drawChart];
    [self.view addSubview:chart_top];

    //-------------------- BOTTOM 顺时针
    CAMChartProfile *profile_bottom = [[pm customProfileForIndex:0] mutableCopy];
    profile_bottom.circleProgress.startAt = CAMProgressStartAtBottom;
    profile_bottom.circleProgress.clockwiseAs = CAMProgressClockwiseAsYES;

    CAMCircleProgressChart *chart_bottom = [[CAMCircleProgressChart alloc] initWithFrame:CGRectMake(2 * chartWidth, offsetY, chartWidth, 100)];
    chart_bottom.chartProfile = profile_bottom;
    chart_bottom.bottomTag = @"BOTTOM";
    [chart_bottom addChartData:75];
    [chart_bottom drawChart];
    [self.view addSubview:chart_bottom];

    //-------------------- RIGHT 顺时针
    CAMChartProfile *profile_right = [[pm customProfileForIndex:0] mutableCopy];
    profile_right.circleProgress.startAt = CAMProgressStartAtRight;
    profile_right.circleProgress.clockwiseAs = CAMProgressClockwiseAsYES;

    CAMCircleProgressChart *chart_right = [[CAMCircleProgressChart alloc] initWithFrame:CGRectMake(3 * chartWidth, offsetY, chartWidth, 100)];
    chart_right.chartProfile = profile_right;
    chart_right.bottomTag = @"RIGHT";
    [chart_right addChartData:75];
    [chart_right drawChart];
    [self.view addSubview:chart_right];
    
    
    offsetY += chart_left.frame.size.height;
    [self addSplitLineWithOffsetY:offsetY];
    offsetY += 1;
    
    
    
    
    
    //演示：线宽、百分比、背景色调整
    chartWidth = screenWidth / 3;   //接下来准备一行画 3 个chart
    
    CAMChartProfile *profile_1 = [[CAMChartProfileManager shareInstance].defaultProfile mutableCopy];
    profile_1.circleAxis.lineWidth = 2;
    profile_1.circleAxis.lineColor = CAMHEXCOLOR(@"ffd70033");  //8位时，最后两位表示alpha值  RGBA
    profile_1.circleAxis.topTagColor = CAMHEXCOLOR(@"5f9ea0");
    profile_1.circleProgress.lineWidth = 6;
    profile_1.circleProgress.lineColor = CAMHEXCOLOR(@"ff8c00");
    profile_1.circleProgress.progressType = CAMProgressValueTypePercent;
    profile_1.circleProgress.progressValueColor = CAMHEXCOLOR(@"ff8c00");
    
    CAMCircleProgressChart *chart_1 = [[CAMCircleProgressChart alloc] initWithFrame:CGRectMake(0 * chartWidth, offsetY, chartWidth, chartWidth)];
    chart_1.chartProfile = profile_1;
    chart_1.minValue = 0;
    chart_1.maxValue = 1000;
    chart_1.topTag = @"百分比";
    [chart_1 addChartData:750];
    [chart_1 drawChart];
    [self.view addSubview:chart_1];
    
    
    
    CAMChartProfile *profile_2 = [[CAMChartProfileManager shareInstance].defaultProfile mutableCopy];
    profile_2.backgroundColor = CAMHEXCOLOR(@"708090");
    profile_2.circleAxis.showAxis = NO;
    profile_2.circleProgress.lineWidth = 6;
    profile_2.circleProgress.lineColor = CAMHEXCOLOR(@"f8f8ff");
    profile_2.circleProgress.progressValueColor = CAMHEXCOLOR(@"f8f8ff");
    
    CAMCircleProgressChart *chart_2 = [[CAMCircleProgressChart alloc] initWithFrame:CGRectMake(1 * chartWidth, offsetY, chartWidth, chartWidth)];
    chart_2.chartProfile = profile_2;
    [chart_2 addChartData:75];
    [chart_2 drawChart];
    [self.view addSubview:chart_2];
    
    
    
    
    CAMChartProfile *profile_3 = [[CAMChartProfileManager shareInstance].defaultProfile mutableCopy];
    profile_3.circleAxis.lineWidth = 10;
    profile_3.circleAxis.lineColor = CAMHEXCOLOR(@"ff8c00");
    profile_3.circleProgress.lineWidth = 6;
    profile_3.circleProgress.lineColor = CAMHEXCOLOR(@"ffffe0");
    profile_3.circleProgress.progressValueColor = CAMHEXCOLOR(@"ff8c00");
    profile_3.circleProgress.progressValueFormat = @"%.0f分";
    
    CAMCircleProgressChart *chart_3 = [[CAMCircleProgressChart alloc] initWithFrame:CGRectMake(2 * chartWidth, offsetY, chartWidth, chartWidth)];
    chart_3.chartProfile = profile_3;
    [chart_3 addChartData:75];
    [chart_3 drawChart];
    [self.view addSubview:chart_3];
    
}

-(void)addSplitLineWithOffsetY:(CGFloat)offsetY{
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(20, offsetY, [UIScreen mainScreen].bounds.size.width - 40, 1)];
    line.backgroundColor = CAMHEXCOLOR(@"eeeeee");
    [self.view addSubview:line];
}

@end
