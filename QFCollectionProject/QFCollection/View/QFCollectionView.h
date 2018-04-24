//
//  QFCollectionView.h
//  QFCollectionProject
//
//  Created by dqf on 2018/3/30.
//  Copyright © 2018年 dqfStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSObject+selector.h"
#import "QFCollectionModel.h"
#import "QFGroupModel.h"
#import "UICollectionViewLeftAlignedLayout.h"
#import "MJRefresh.h"

typedef void (^QFRefreshBlock)(void);
typedef void (^QFLoadMoreBlock)(void);
typedef void(^QFItemInitBlock)(id cell);

@interface QFCollectionView : UICollectionView

@property (nonatomic, strong) NSMutableArray *allReuseCells;

@property (nonatomic, assign) NSUInteger pageNo;    // page number, default 1
@property (nonatomic, assign) NSUInteger pageSize;  // page size, default 20

@property (nonatomic, copy) QFRefreshBlock  refreshBlock;   // block to refresh data
@property (nonatomic, copy) QFLoadMoreBlock loadMoreBlock;  // block to load more data

- (void)reloadModel;

//clear all model
- (void)clearModel;

//begin refresh
- (void)beginRefresh;

//stop refresh
- (void)endRefresh;

#pragma --mark register cell

- (id)registerCell:(Class)cellClass indexPath:(NSIndexPath *)indexPath;
- (id)registerCell:(Class)cellClass indexPath:(NSIndexPath *)indexPath reuseIdentifier:(NSString *)reuseIdentifier;
- (id)registerCell:(Class)cellClass indexPath:(NSIndexPath *)indexPath initBlock:(QFItemInitBlock)block;
- (id)registerCell:(Class)cellClass indexPath:(NSIndexPath *)indexPath reuseIdentifier:(NSString *)reuseIdentifier initBlock:(QFItemInitBlock)block;

#pragma --mark register cell

- (void)refreshView:(id)object withArr:(NSArray *)arr;

- (void)loadView:(id)object withArr:(NSArray *)arr;

- (void)itemAtIndexPath:(NSIndexPath *)indexPath resetSize:(CGSize)size;

@end

