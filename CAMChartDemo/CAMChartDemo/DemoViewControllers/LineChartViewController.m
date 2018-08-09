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
    
    
    CAMChartProfileManager *pm = [CAMChartProfileManager shareInstance];
    [pm registerCustomProfile:[pm.defaultProfile mutableCopy]];
    
    CAMChartProfile *profile = [pm customProfileForIndex:0];
    profile.margin = 20;
    profile.backgroundColor = [UIColor whiteColor];
//    profile.axisUnitFontSize = 15;
//    profile.axisUnitColor = [UIColor redColor];
//    profile.axisLineColor = [UIColor grayColor];
//    profile.axisLineWidth = 4;
    
    _lineChart = [[CAMLineChart alloc] init];
    _lineChart.chartProfile = profile;
    _lineChart.xUnit = @"直角坐标系中，正三角形的";
    _lineChart.yUnit = @"直角坐";
//    _lineChart.xLabels = @[@"STEP 1", @"STEP 2", @"STEP 3", @"STEP 4", @"STEP 5", @"STEP 6", @"STEP 7"];
    _lineChart.xLabels = @[@"中国", @"美利坚合众国", @"英格兰", @"巴西", @"法国"];
    _lineChart.yLabels = @[@"中国", @"美利坚合众国", @"英格兰", @"巴西", @"法国"];
    
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
    [_lineChart setFrame:CGRectMake(0, 100, self.view.bounds.size.width, 200)];
}



-(void)btnClick:(id)sender{
    _lineChart.xUnit = @"Hello,world!";
    _lineChart.yUnit = @"Welcome";
    
    [_lineChart setNeedsDisplay];
}

@end
