//
//  HDSliderTabBar.h
//  HDSliderTabBarExample
//
//  Created by zhangdadi on 15/7/6.
//  Copyright (c) 2015年 张达棣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HDSliderTabBar : UIView

@property (nonatomic, strong) NSArray *itemArray;
@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *middleView;
@property (nonatomic, strong) UIView *rightView;


@property (nonatomic, assign) CGFloat itemMainWith; //每个item的最小宽度,默认为70
@property (nonatomic, assign) UIColor *itemSelectColor; //item选择时的颜色，默认为红色


@end
