//
//  HDSliderTabBar.m
//  HDSliderTabBarExample
//
//  Created by zhangdadi on 15/7/6.
//  Copyright (c) 2015年 张达棣. All rights reserved.
//

#import "HDSliderTabBar.h"

@interface HDSliderTabBar ()
@property (nonatomic, assign, readonly) CGFloat screenWidth;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *itemViewArray;
@property (nonatomic, assign) NSInteger index; //当前选择的index

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
    offsetX = offsetX > 0 ? offsetX : 0;
    offsetX = offsetX > _scrollView.contentSize.width - _scrollView.frame.size.width ? _scrollView.contentSize.width - _scrollView.frame.size.width : offsetX;
    [_scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

- (void)buttonClick:(UIButton *)button {
    self.index = button.tag;
}

//- (void)setLeftView:(UIView *)leftView {
//    _leftView = leftView;
//    CGRect frame = leftView.frame;
//    frame.origin.y += 44;
//    frame.size.height -= 44;
//    leftView.frame = frame;
//}


@end
