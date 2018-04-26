//
//  HGroupModel.h
//  HCollectionProject
//
//  Created by dqf on 2018/3/30.
//  Copyright © 2018年 dqfStudio. All rights reserved.
//

#import "HItemModel.h"

@class HCollectionView;

typedef UICollectionReusableView *(^HViewRenderBlock)(NSInteger section, HCollectionView *collection);
typedef CGSize (^HHeaderViewSizeBlock)(NSInteger section, HCollectionView *collection);

@interface HGroupModel : NSObject

#pragma -mark 允许外部设置
@property (nonatomic, assign) CGFloat rowInterval;  // optional
@property (nonatomic, assign) CGFloat colInterval;  // optional
@property (nonatomic, assign) CGFloat marginX;      // optional
@property (nonatomic, assign) CGFloat marginTop;    // optional
@property (nonatomic, assign) CGFloat rowItems;     // optional,默认1

#pragma -mark 内部自动赋值，也允许外部设置
@property (nonatomic, assign) CGFloat whFactor;     // =h/w,默认1
@property (nonatomic, assign) CGFloat height;       // 设置item的固定高度，与whFactor只能二选一，优先级高于whFactor

@property (nonatomic, copy) HHeaderViewSizeBlock headerSizeBlock;            // optional

@property (nonatomic, copy) HViewRenderBlock headerViewRenderBlock;  // block to render header view
//@property (nonatomic, copy) HViewRenderBlock footerViewRenderBlock;  // block to render footer view
@property (nonatomic, strong) UICollectionReusableView *headerView;  // section header view
//@property (nonatomic, strong) UICollectionReusableView *footerView;  // section footer view

@property (nonatomic, assign) CGSize headerSize;  // optional
@property (nonatomic, strong) NSString *selector;  //section对应的selector

//向model添加对象数据
- (void)addModel:(HItemModel *)anObject;

- (HItemModel *)itemAtIndex:(NSUInteger)index;

- (NSUInteger)indexOfItem:(HItemModel *)anObject;

- (NSUInteger)items;

//clear all model
- (void)clearModel;

@end
