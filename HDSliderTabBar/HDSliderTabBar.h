//
//  HDSliderTabBar.h
//  HDSliderTabBarExample
//
//  Created by zhangdadi on 15/7/6.
//  Copyright (c) 2015年 张达棣. All rights reserved.
//
//  GitHub:https://github.com/zhangdadi/HDSliderTabBarExample
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.



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
