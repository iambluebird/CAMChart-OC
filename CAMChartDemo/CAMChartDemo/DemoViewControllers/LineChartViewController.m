//
//  LineChartViewController.m
//  CAMChartDemo
//
//  Created by 欧阳峰 on 2018/8/8.
//  Copyright © 2018年 欧阳峰. All rights reserved.
//

/*
 
 这里展示的是通过 CAMChartProfileManager copy出一份profile来进行独立管理视图配置的方法。
 在项目使用中，建议采用 CAMChartProfileManager 对 profile 进行托管，
 参考 registerCustomProfile 和 customProfileForIndex 两个方法，这样可以在项目固定位置
 对全局配置文件进行统一管理，同时保持在项目中所有chart视图的视觉风格一致。
 
 另：如果chart支持动画展示模式，并且呈现在cell中时，由于cell的复用机制，当一个已经展示过的cell
 从屏幕外进入屏幕时，有可能导致chart的动画再次出现，针对这个问题，可以使用
 -(void)drawChartWithAnimationDisplay:(BOOL)animationDisplay;
 这个方法，通过调用参数 animationDisplay 对本次chart展示是否显示动画进行控制。
 具体的操作逻辑在demo中有所体现。
 
 如果chart不是用于cell中，或者不考虑动画重复出现的问题，则可以直接使用 drawChart 方法。
 
*/

#import "LineChartViewController.h"
#import "CAMChart.h"

@interface LineChartViewController ()<UITableViewDelegate, UITableViewDataSource>{
    NSMutableArray *_cellAnimationed;
}

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation LineChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"LineChart";
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

-(void)viewWillLayoutSubviews{
    [self.tableView setFrame:self.view.bounds];
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        //初始化cell动画记录数组
        _cellAnimationed = [NSMutableArray new];
    }
    return _tableView;
}


#pragma mark - TableView Delegates

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.bounds.size.width, 60)];
    return v;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(_cellAnimationed.count < indexPath.row + 1) [_cellAnimationed addObject:@(YES)];
    
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    CAMLineChart *chart = nil;
    switch (indexPath.row) {
        case 0: chart = [self chartStyleDemo0WithRow:indexPath.row]; break;
        case 1: chart = [self chartStyleDemo1WithRow:indexPath.row]; break;
        case 2: chart = [self chartStyleDemo2WithRow:indexPath.row]; break;
        case 3: chart = [self chartStyleDemo3WithRow:indexPath.row]; break;
        default: chart = [self chartStyleDemo0WithRow:indexPath.row]; break;
    }
    [cell.contentView addSubview:chart];

    return cell;
}


#pragma mark - 各种chart样式cell
-(CAMLineChart*) chartStyleDemo0WithRow:(NSInteger)row{
    
    BOOL showWithAnimation = [_cellAnimationed[row] boolValue];
    if(showWithAnimation) _cellAnimationed[row] = @(NO);
    
    CAMChartProfile *profile = [[CAMChartProfileManager shareInstance].defaultProfile mutableCopy];
    
    profile.backgroundColor = CAMHEXCOLOR(@"f8f8ff");
    
    profile.xyAxis.showYAxis = NO;
    profile.xyAxis.showXAxis = NO;
    profile.xyAxis.showYLabel = NO;
    profile.xyAxis.showXGrid = NO;
    profile.xyAxis.showYGrid = NO;
    
    profile.lineChart.lineStyle = CAMChartLineStyleCurve;
    profile.lineChart.showPointLabel = NO;
    profile.lineChart.showPoint = NO;
    
    CAMLineChart *chart = [[CAMLineChart alloc] initWithFrame:CGRectMake(0, 0, _tableView.bounds.size.width, 200)];
    
    chart.chartProfile = profile;
    
    NSArray *data00 = @[@100, @0, @100, @0, @100, @0, @100, @0, @100, @0, @100, @0, @100, @0, @100, @0, @100, @0, @100, @0];
    NSArray *data01 = @[@0, @100, @0, @100, @0, @100, @0, @100, @0, @100, @0, @100, @0, @100, @0, @100, @0, @100, @0, @100];
    
    [chart addChartData:data00];
    [chart addChartData:data01];
    
    [chart drawChartWithAnimationDisplay:showWithAnimation];
    
    return chart;
}

-(CAMLineChart*) chartStyleDemo1WithRow:(NSInteger)row{
    
    BOOL showWithAnimation = [_cellAnimationed[row] boolValue];
    if(showWithAnimation) _cellAnimationed[row] = @(NO);
    
    CAMChartProfile *profile = [[CAMChartProfileManager shareInstance].defaultProfile mutableCopy];
    profile.xyAxis.showXGrid = YES;
    profile.xyAxis.showYAxis = NO;
    profile.lineChart.showPointLabel = NO;
    
    CAMLineChart *chart = [[CAMLineChart alloc] initWithFrame:CGRectMake(0, 0, _tableView.bounds.size.width, 200)];
    chart.chartProfile = profile;
    chart.yLabels = @[@"配色1", @"配色2", @"配色3", @"配色4", @"配色5", @"配色6", @"配色7", @"配色8", @"配色9", @"配色10"];
    
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
    
    [chart addChartData:data00];
    [chart addChartData:data01];
    [chart addChartData:data02];
    [chart addChartData:data03];
    [chart addChartData:data04];
    [chart addChartData:data05];
    [chart addChartData:data06];
    [chart addChartData:data07];
    [chart addChartData:data08];
    [chart addChartData:data09];
    
    [chart drawChartWithAnimationDisplay:showWithAnimation];
    
    return chart;
}

-(CAMLineChart*) chartStyleDemo2WithRow:(NSInteger)row{
    
    BOOL showWithAnimation = [_cellAnimationed[row] boolValue];
    if(showWithAnimation) _cellAnimationed[row] = @(NO);
    
    CAMChartProfile *profile = [[CAMChartProfileManager shareInstance].defaultProfile mutableCopy];
    profile.animationDisplay = NO;      //不使用动画
    
    profile.xyAxis.showYGrid = NO;
    profile.xyAxis.showXGrid = YES;
    profile.xyAxis.gridStyle = CAMXYAxisGridStyleDependOnPositions; //辅助线依赖标签进行定位
    profile.xyAxis.yLabelFormat = @"%0.0f元";
    
    profile.lineChart.lineStyle = CAMChartLineStyleStraight;
    profile.lineChart.showPointLabel = YES;
    profile.lineChart.showPoint = YES;
    
    CAMLineChart *chart = [[CAMLineChart alloc] initWithFrame:CGRectMake(0, 0, _tableView.bounds.size.width, 200)];
    
    chart.chartProfile = profile;
    chart.xUnit = @"折线图";
    chart.xLabels = @[@"一月", @"二月", @"三月", @"四月", @"五月"];
    
    NSArray *data00 = @[@13, @5, @40, @0, @69, @33, @45];
    NSArray *data01 = @[@73.2, @57, @69, @26, @117];
    
    [chart addChartData:data00];
    [chart addChartData:data01];
    
    [chart drawChart];  //不管cell的复用问题，动画会重复出现
    
    return chart;
}

-(CAMLineChart*) chartStyleDemo3WithRow:(NSInteger)row{
    
    BOOL showWithAnimation = [_cellAnimationed[row] boolValue];
    if(showWithAnimation) _cellAnimationed[row] = @(NO);
    
    CAMChartProfile *profile = [[CAMChartProfileManager shareInstance].defaultProfile mutableCopy];
    profile.animationDisplay = YES;     //使用动画
    profile.animationDuration = 1.5;    //动画时长
    
    profile.xyAxis.showYGrid = YES;
    profile.xyAxis.showXGrid = NO;
    profile.xyAxis.gridStyle = CAMXYAxisGridStyleDependOnPositions; //辅助线依赖标签进行定位
    
    profile.lineChart.lineStyle = CAMChartLineStyleCurve;       //曲线样式
    profile.lineChart.showPointLabel = YES;
    profile.lineChart.showPoint = YES;
    profile.lineChart.pointLabelFormat = @"%0.1f元";
    
    CAMLineChart *chart = [[CAMLineChart alloc] initWithFrame:CGRectMake(0, 0, _tableView.bounds.size.width, 200)];
    
    chart.chartProfile = profile;
    chart.xUnit = @"曲线图";
    chart.yUnit = @"金额";
    chart.xLabels = @[@"一月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月"];
    chart.yLabels = @[@"0", @"60", @"120"];
    
    NSArray *data00 = @[@13, @5, @40, @0, @69, @33, @45];
    NSArray *data01 = @[@73.2, @57, @69, @26, @117];
    
    [chart addChartData:data00];
    [chart addChartData:data01];
    
    [chart drawChartWithAnimationDisplay:showWithAnimation];
    
    return chart;
}

@end
