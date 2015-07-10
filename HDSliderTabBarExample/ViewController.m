//
//  ViewController.m
//  HDSliderTabBarExample
//
//  Created by zhangdadi on 15/7/10.
//  Copyright (c) 2015年 张达棣. All rights reserved.
//

#import "ViewController.h"
#import "HDSliderTabBar.h"

NSString *KCellIdef = @"zcell";


@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) HDSliderTabBar *sliderTabBar;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"今日头条";
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:KCellIdef];
    
    UITableView *table1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 108, self.view.frame.size.width, self.view.frame.size.height)];
    [table1 registerClass:[UITableViewCell class] forCellReuseIdentifier:KCellIdef];
    table1.dataSource = self;
    _leftTableView = table1;
    [self.view addSubview:table1];
    
    UITableView *table2 = [[UITableView alloc] initWithFrame:CGRectMake(0, 108, self.view.frame.size.width, self.view.frame.size.height)];
    [table2 registerClass:[UITableViewCell class] forCellReuseIdentifier:KCellIdef];
    table2.dataSource = self;
    [self.view addSubview:table2];
    
    
    //使用方法
    
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
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdef forIndexPath:indexPath];
    NSString *str;
    if (tableView == _tableView) {
        str = [NSString stringWithFormat:@"le%d", (int)indexPath.row];
    } else if (tableView == _leftTableView) {
        str = [NSString stringWithFormat:@"mi%d", (int)indexPath.row];

    } else {
        str = [NSString stringWithFormat:@"ri%d", (int)indexPath.row];

    }
    
    cell.textLabel.text = str;
    return cell;
}


@end
