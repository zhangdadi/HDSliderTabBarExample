//
//  ViewController.m
//  HDSliderTabBarExample
//
//  Created by zhangdadi on 15/7/6.
//  Copyright (c) 2015年 张达棣. All rights reserved.
//

#import "ViewController.h"
#import "HDSliderTabBar.h"

NSString *KCellIdef = @"zcell";

@interface ViewController ()<UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) HDSliderTabBar *sliderTabBar;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"今日头条";
    // Do any additional setup after loading the view, typically from a nib.
    _sliderTabBar = [[HDSliderTabBar alloc] initWithFrame:CGRectMake(0, 64, 0, 0)];
    _sliderTabBar.itemArray = @[@"热点", @"科技", @"推荐", @"南宁", @"视频", @"推荐", @"社会", @"娱乐", @"国际"];
    _sliderTabBar.leftView = _tableView;
    [self.view addSubview:_sliderTabBar];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:KCellIdef];
    
    
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
    cell.textLabel.text = [NSString stringWithFormat:@"%d", (int)indexPath.row];
    return cell;
}

@end
