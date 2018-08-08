//
//  LineChartViewController.m
//  CAMChartDemo
//
//  Created by 欧阳峰 on 2018/8/8.
//  Copyright © 2018年 欧阳峰. All rights reserved.
//

#import "LineChartViewController.h"
#import "CAMChartProfileManager.h"

@interface LineChartViewController ()

@end

@implementation LineChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"LineChart";
    
    
    CAMChartProfileManager *pm1 = [CAMChartProfileManager shareInstance];
    CAMChartProfileManager *pm = [pm1 copy];
    
//    CAMChartProfileManager *pm = [CAMChartProfileManager shareInstance];
    
//    CAMChartProfileManager *pm = [[CAMChartProfileManager alloc]init];
    
//    CAMChartProfileManager *pm = [CAMChartProfileManager new];
    
    CAMChartProfile *profile = [pm.defaultProfile mutableCopy];
    [pm registerCustomProfile:profile];
    
    NSLog(@"custom = %f", [pm customProfileForIndex:0].margin);
    NSLog(@"default = %f", pm.defaultProfile.margin);
    
    pm.defaultProfile.margin = 30;
    
    NSLog(@"custom = %f", [pm customProfileForIndex:0].margin);
    NSLog(@"default = %f", pm.defaultProfile.margin);
    
    profile.margin = 40;
    
    NSLog(@"custom = %f", [pm customProfileForIndex:0].margin);
    NSLog(@"default = %f", pm.defaultProfile.margin);
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

@end
