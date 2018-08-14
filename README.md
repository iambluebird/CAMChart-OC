#  CAMChart - ObjC


![效果图](./images/linechart-demo-01.png)

```objective-c
CAMChartProfile *profile = [[CAMChartProfileManager shareInstance].defaultProfile mutableCopy];
CAMLineChart *chart = [[CAMLineChart alloc] initWithFrame:CGRectMake(0, 0, 300, 200)];
chart.chartProfile = profile;
chart.xUnit = @"折线图";
chart.xLabels = @[@"一月", @"二月", @"三月", @"四月", @"五月"];

NSArray *data00 = @[@13, @5, @40, @0, @69, @33, @45];
NSArray *data01 = @[@73.2, @57, @69, @26, @117];

[chart addChartData:data00];
[chart addChartData:data01];

[chart drawChart];
```
