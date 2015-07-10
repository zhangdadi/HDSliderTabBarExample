#HDSliderTabBar
## iOS开发之多表视图滑动切换示例（仿"头条"客户端)

今天给大家分享一个头条新闻客户端各个类别进行切换的一个示例。在Demo中对其界面效果进行封装，在封装的组件中使用的是纯代码的形式，如果想要在项目中进行使用，直接使用就OK的。

使用方法：

```
_sliderTabBar = [[HDSliderTabBar alloc] initWithFrame:CGRectMake(0, 64, 0, 0)];
    _sliderTabBar.itemArray = @[@"热点", @"科技", @"推荐", @"南宁", @"视频", @"推荐", @"社会", @"娱乐", @"国际"];
    [self.view addSubview:_sliderTabBar];
    
    _sliderTabBar.showView = _tableView;
    _sliderTabBar.leftView = table1;
    _sliderTabBar.rightView = table2;
    
    __weak typeof(self) weakSelf = self;
    _sliderTabBar.selectBlock = ^(NSInteger index, UITableView *tableView) {
        NSLog(@"刷新==%@", weakSelf.sliderTabBar.itemArray[index]);
        [tableView reloadData];
    };

```
