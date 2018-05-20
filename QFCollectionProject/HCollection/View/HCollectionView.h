//
//  HCollectionView.h
//  HCollectionProject
//
//  Created by dqf on 2018/3/30.
//  Copyright © 2018年 dqfStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSObject+selector.h"
#import "HCollectionModel.h"
#import "HGroupModel.h"
#import "UICollectionViewLeftAlignedLayout.h"
#import "MJRefresh.h"

typedef void (^HRefreshBlock)(void);
typedef void (^HLoadMoreBlock)(void);
typedef void(^HItemInitBlock)(id cell);

@interface HCollectionView : UICollectionView

@property (nonatomic, strong) NSMutableSet *allReuseCells;

@property (nonatomic, assign) NSUInteger pageNo;    // page number, default 1
@property (nonatomic, assign) NSUInteger pageSize;  // page size, default 20

@property (nonatomic, copy) HRefreshBlock  refreshBlock;   // block to refresh data
@property (nonatomic, copy) HLoadMoreBlock loadMoreBlock;  // block to load more data

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
- (id)registerCell:(Class)cellClass indexPath:(NSIndexPath *)indexPath initBlock:(HItemInitBlock)block;
- (id)registerCell:(Class)cellClass indexPath:(NSIndexPath *)indexPath reuseIdentifier:(NSString *)reuseIdentifier initBlock:(HItemInitBlock)block;

#pragma --mark register cell

- (void)refreshView:(id)object withArr:(NSArray *)arr;

- (void)loadView:(id)object withArr:(NSArray *)arr;

@end

@interface NSArray (HCollectionView)
- (NSArray *(^)(NSArray *))linkItem;
- (void (^)(NSUInteger group, NSString *groupModel))setGroupModel;
@end

@interface NSString (HCollectionView)
- (NSArray *(^)(NSUInteger))multiple;
@end
