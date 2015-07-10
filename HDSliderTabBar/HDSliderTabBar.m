//
//  HDSliderTabBar.m
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



#import "HDSliderTabBar.h"

@interface HDSliderTabBar ()
@property (nonatomic, strong) UIScrollView *scrollView; //头顶的滚动视图
@property (nonatomic, strong) NSArray *itemViewArray; //按钮view的数组
@property (nonatomic, assign) NSInteger index; //当前选择的index
@property (nonatomic, assign) NSInteger lastIndex; //上一次选择的index

@end

@implementation HDSliderTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self creatView];
    }
    return self;
}

- (void)awakeFromNib {
    [self creatView];
}

- (void)creatView {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.screenWidth, 44);
    self.itemMainWith = 70;
    self.itemSelectColor = [UIColor redColor];
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.frame = self.bounds;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:_scrollView];
    
    _scrollView.backgroundColor = [UIColor grayColor];
}

- (void)setItemArray:(NSArray *)itemArray {
    _itemArray = itemArray;
    CGFloat itemWithd = self.screenWidth / itemArray.count;
    if (itemWithd > _itemMainWith) {
        _itemMainWith = itemWithd;
    }
    [self itemViewTextWithTexts:itemArray];
}

- (void)itemViewTextWithTexts:(NSArray *)textArray {
    CGFloat width = 0;
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:textArray.count];
    for (int i = 0; i < textArray.count; i++) {
        UIButton *itemView = [[UIButton alloc] init];
        itemView.tag = i;
        CGRect itemViewFrame = itemView.frame;
        itemViewFrame.size.width = self.itemMainWith;
        itemViewFrame.size.height = self.frame.size.height;
        itemViewFrame.origin.x = self.itemMainWith * i;
        itemView.frame = itemViewFrame;
        [itemView setTitle:textArray[i] forState:UIControlStateNormal];
        [itemView setTitle:textArray[i] forState:UIControlStateSelected];
        [itemView setTitleColor:_itemSelectColor forState:UIControlStateSelected];
        [itemView addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:itemView];
        [array addObject:itemView];
        width += itemViewFrame.size.width;
    }
    _itemViewArray = array;
    self.index = 0;
    _scrollView.contentSize = CGSizeMake(width, 0);
}

- (CGFloat)screenWidth {
    return [UIScreen mainScreen].bounds.size.width;
}

- (void)setIndex:(NSInteger)index {
    ((UIButton *)_itemViewArray[_index]).selected = NO;
    UIButton *selectButton = (UIButton *)_itemViewArray[index];
    selectButton.selected = YES;
    _index = index;
    
    CGFloat offsetX = selectButton.frame.origin.x - self.screenWidth / 2;
    offsetX = offsetX > 0 ? (offsetX + _itemMainWith / 2) : 0;
    offsetX = offsetX > _scrollView.contentSize.width - _scrollView.frame.size.width ? _scrollView.contentSize.width - _scrollView.frame.size.width : offsetX;
    
    {
        if (index > _lastIndex) { //向右边移动
            
            CGRect frame = _leftView.frame;
            frame.origin.x = _leftView.frame.size.width;
            _leftView.frame = frame;
            
            [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                CGRect frame = _showView.frame;
                frame.origin.x = -_showView.frame.size.width;
                _showView.frame = frame;
                
                frame = _rightView.frame;
                frame.origin.x = 0;
                _rightView.frame = frame;
            } completion:^(BOOL finished) {
                [_scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
            }];
            
            //设置正在显示的view
            UITableView *temp = _showView;
            _showView = _rightView;
            _rightView = _leftView;
            _leftView = temp;
            
            if (index - _lastIndex > 1) {
                [self finishWithIndex:index];
            } else {
                if (index + 1 >= 0 && index + 1 < _itemArray.count) {
                    _selectBlock(index + 1, _rightView);
                }
            }
            
        } else if (index < _lastIndex){ //向左边移动
            CGRect frame = _rightView.frame;
            frame.origin.x = -_rightView.frame.size.width;
            _rightView.frame = frame;
            
            [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                CGRect frame = _showView.frame;
                frame.origin.x = _showView.frame.size.width;
                _showView.frame = frame;
                
                frame = _leftView.frame;
                frame.origin.x = 0;
                _leftView.frame = frame;
            } completion:^(BOOL finished) {
                [_scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
            }];

            //设置正在显示的view
            UITableView *temp = _showView;
            _showView = _leftView;
            _leftView = _rightView;
            _rightView = temp;
            
            if (_lastIndex - index > 1) {
                [self finishWithIndex:index];
            } else {
                if (index - 1 >= 0 && index - 1 < _itemArray.count) {
                    _selectBlock(index - 1, _leftView);
                }
            }
        }
    }
    
    _lastIndex = index;
}

- (void)buttonClick:(UIButton *)button {
    self.index = button.tag;
}

- (void)setLeftView:(UITableView *)leftView {
    _leftView = leftView;
    
    CGRect frame = leftView.frame;
    frame.origin.x = -leftView.frame.size.width;
    leftView.frame = frame;
}

- (void)setShowView:(UITableView *)showView {
    _showView = showView;
}

- (void)setRightView:(UITableView *)rightView {
    _rightView = rightView;
    CGRect frame = rightView.frame;
    frame.origin.x = rightView.frame.size.width;
    rightView.frame = frame;
}

- (void)setSelectBlock:(HDSliderTabBarSelectBlock)selectBlock {
    _selectBlock = [selectBlock copy];
    [self finishWithIndex:0];
}

- (void)finishWithIndex:(NSInteger)index {
    //回调
    if (_selectBlock) {
        if (index >= 0 && index < _itemArray.count) {
            _selectBlock(index, _leftView);
        }
        if (index - 1 >= 0 && index - 1 < _itemArray.count) {
            _selectBlock(index - 1, _leftView);
        }
        if (index + 1 >= 0 && index + 1 < _itemArray.count) {
            _selectBlock(index + 1, _rightView);
        }
    }
}


@end
