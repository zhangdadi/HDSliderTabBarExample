//
//  HDSliderTabBar.h
//  HDSliderTabBarExample
//
//  Created by zhangdadi on 15/7/6.
//  Copyright (c) 2015年 张达棣. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^HDSliderTabBarSelectBlock)(NSInteger index, UITableView *reloadView);

@interface HDSliderTabBar : UIView

@property (nonatomic, strong) NSArray *itemArray; //头顶列表的数据源
@property (nonatomic, strong) UITableView *leftView; //左边的view
@property (nonatomic, strong) UITableView *showView; //正在显示的view
@property (nonatomic, strong) UITableView *rightView; //右边的view
@property (nonatomic, copy) HDSliderTabBarSelectBlock  selectBlock; //切换后的回调

@property (nonatomic, assign) CGFloat itemMainWith; //每个item的最小宽度,默认为70
@property (nonatomic, assign) UIColor *itemSelectColor; //item选择时的颜色，默认为红色


@end
