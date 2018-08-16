//
//  NavitationViewController.m
//  CAMChartDemo
//
//  Created by 欧阳峰 on 2018/8/7.
//  Copyright © 2018年 欧阳峰. All rights reserved.
//

#import "NavigationViewController.h"
#import "LineChartViewController.h"
#import "CircleProgressChartViewController.h"

typedef NS_ENUM(NSUInteger, CAMChartType) {
    CAMChartTypeLine = 0,
    CAMChartTypeCircleProgress,
};

@interface NavigationViewController ()<UITableViewDelegate, UITableViewDataSource>{
    NSMutableArray *_charts;
}

@property(nonatomic, strong) UITableView *tableView;

@end

@implementation NavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"CAMChart Demo";
    
    _charts = [[NSMutableArray alloc] init];
    [_charts addObject:@"LineChart Demo"];
    [_charts addObject:@"Circle Progress Chart Demo"];
    
    [self.view addSubview:self.tableView];
    
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
- (void)viewWillLayoutSubviews{
    [self.tableView setFrame:self.view.bounds];
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 44;
    }
    return _tableView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc;
    switch (indexPath.row) {
        case CAMChartTypeLine:
            vc = [[LineChartViewController alloc] init];
            break;
        case CAMChartTypeCircleProgress:
            vc = [[CircleProgressChartViewController alloc] init];
            break;
        default:
            vc = [[LineChartViewController alloc] init];
            break;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _charts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = _charts[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

@end
