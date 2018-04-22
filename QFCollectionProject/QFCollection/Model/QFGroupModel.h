//
//  QFGroupModel.h
//  QFCollectionProject
//
//  Created by dqf on 2018/3/30.
//  Copyright © 2018年 dqfStudio. All rights reserved.
//

#import "QFItemModel.h"

@class QFCollectionView;

typedef UICollectionReusableView *(^QFViewRenderBlock)(NSInteger section, QFCollectionView *collection);
typedef CGSize (^QFHeaderViewSizeBlock)(NSInteger section, QFCollectionView *collection);

@interface QFGroupModel : NSObject

@property (nonatomic, assign) CGFloat rowInterval;  // optional
@property (nonatomic, assign) CGFloat colInterval;  // optional
@property (nonatomic, assign) CGFloat marginX;      // optional
@property (nonatomic, assign) CGFloat marginTop;    // optional

@property (nonatomic, copy) QFHeaderViewSizeBlock headerSizeBlock;            // optional

@property (nonatomic, copy) QFViewRenderBlock headerViewRenderBlock;  // block to render header view
//@property (nonatomic, copy) QFViewRenderBlock footerViewRenderBlock;  // block to render footer view
@property (nonatomic, strong) UICollectionReusableView *headerView;  // section header view
//@property (nonatomic, strong) UICollectionReusableView *footerView;  // section footer view

@property (nonatomic, assign) CGSize headerSize;  // optional
@property (nonatomic, strong) NSString *selector;  //section对应的selector

//向model添加对象数据
- (void)addModel:(QFItemModel *)anObject;

- (QFItemModel *)itemAtIndex:(NSUInteger)index;

- (NSUInteger)indexOfItem:(QFItemModel *)anObject;

- (NSUInteger)items;

//clear all model
- (void)clearModel;

@end
