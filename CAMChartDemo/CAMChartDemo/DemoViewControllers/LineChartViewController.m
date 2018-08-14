//
//  LineChartViewController.m
//  CAMChartDemo
//
//  Created by 欧阳峰 on 2018/8/8.
//  Copyright © 2018年 欧阳峰. All rights reserved.
//

#import "LineChartViewController.h"
#import "CAMChartProfileManager.h"
#import "CAMLineChart.h"

@interface LineChartViewController (){
    CAMLineChart *_lineChart;
}

@end

@implementation LineChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"LineChart";
//    self.view.backgroundColor = [UIColor darkGrayColor];
    
    CAMChartProfileManager *pm = [CAMChartProfileManager shareInstance];
//    pm.defaultProfile.themeColor = [UIColor purpleColor];   //设置主题色一定要放到mutableCopy之前，否则无法影响整个色系
    [pm registerCustomProfile:[pm.defaultProfile mutableCopy]];
    
    CAMChartProfile *profile = [pm customProfileForIndex:0];
//    profile.padding = 20;
//    profile.margin = 20;
//    profile.backgroundColor = [UIColor whiteColor];
//    profile.lineWidth = 1;
//    profile.unitFont = [UIFont systemFontOfSize:15];
//    profile.xyAxis.unitColor = [UIColor redColor];
//    profile.lineColor = [UIColor grayColor];
//    profile.lineWidth = 4;
//    profile.showYAxis = false;
    
//    profile.lineChart.lineWidth = 3;
    profile.xyAxis.showYAxis = YES;
    profile.xyAxis.showYLabel = YES;
    profile.xyAxis.showXLabel = YES;
    
//    profile.lineChart.showPoint = YES;
    
//    profile.xyAxis.gridStepSize = 30;
//    profile.xyAxis.showXGrid = NO;
    profile.xyAxis.gridStyle = CAMXYAxisGridStyleDependOnPositions;

//    profile.animationDisplay = NO;
    
//    profile.xyLabelFont = [UIFont systemFontOfSize:13];
    
    profile.lineChart.lineStyle = CAMChartLineStyleCurve;
//    profile.lineChart.pointLabelFormat = @"%0.0f分";
    
//    CAMChartProfile *pf = [[CAMChartProfile alloc] init];
    
    _lineChart = [[CAMLineChart alloc] init];
    [_lineChart setFrame:CGRectMake(0, 100, self.view.bounds.size.width, 200)];
//    _lineChart = [[CAMLineChart alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 200)];
    _lineChart.chartProfile = profile;
    _lineChart.xUnit = @"X轴";
    _lineChart.yUnit = @"Y轴";
//    _lineChart.xLabels = @[@"STEP 1", @"STEP 2", @"STEP 3", @"STEP 4", @"STEP 5", @"STEP 6", @"STEP 7"];
//    _lineChart.xLabels = @[@"中国", @"美利坚合众国", @"英格兰", @"巴西", @"法国"];
//    _lineChart.yLabels = @[@"中国", @"美利坚合众国", @"英格兰", @"巴西", @"法国"];
    
    profile.xyAxis.yLabelDefaultCount = 10;
    profile.lineChart.pointLabelFormat = @"%0.1f";
    profile.lineChart.showPointLabel = NO;
    
//    _lineChart.minValue = -33.2;
//    _lineChart.maxValue = 250.3;
   
//    NSArray *data01 = @[@3, @5, @0, @0, @69, @33, @45];
//    NSArray *data02 = @[@73.2, @57, @69, @26, @117];
    
    NSArray *data00 = @[@10, @10];
    NSArray *data01 = @[@20, @20];
    NSArray *data02 = @[@30, @30];
    NSArray *data03 = @[@40, @40];
    NSArray *data04 = @[@50, @50];
    NSArray *data05 = @[@60, @60];
    NSArray *data06 = @[@70, @70];
    NSArray *data07 = @[@80, @80];
    NSArray *data08 = @[@90, @90];
    NSArray *data09 = @[@100, @100];
    
    [_lineChart addChartData:data00];
    [_lineChart addChartData:data01];
    [_lineChart addChartData:data02];
    [_lineChart addChartData:data03];
    [_lineChart addChartData:data04];
    [_lineChart addChartData:data05];
    [_lineChart addChartData:data06];
    [_lineChart addChartData:data07];
    [_lineChart addChartData:data08];
    [_lineChart addChartData:data09];
    
    [_lineChart drawChart];
    [self.view addSubview:_lineChart];
    
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 400, 200, 40);
    btn.backgroundColor = [UIColor purpleColor];
    [btn setTitle:@"click" forState:UIControlStateNormal];
    btn.titleLabel.textColor = [UIColor whiteColor];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

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

-(void)viewWillLayoutSubviews{
//    [_lineChart setFrame:CGRectMake(0, 100, self.view.bounds.size.width, 200)];
}


-(void)btnClick:(id)sender{
    _lineChart.xUnit = @"Hello,world!";
    _lineChart.yUnit = @"Welcome";
    
    NSArray *data03 = @[@33, @57, @78, @12, @68];
    
    [_lineChart addChartData:data03];
    [_lineChart drawChart];
    [_lineChart setNeedsDisplay];
}



@end
