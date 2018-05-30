//
//  HItemModel.h
//  HCollectionProject
//
//  Created by dqf on 2018/3/30.
//  Copyright © 2018年 dqfStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class HCollectionView;

typedef CGSize (^HItemSizeBlock)(NSIndexPath *indexPath, HCollectionView *collection);
typedef UICollectionViewCell *(^HItemRenderBlock)(NSIndexPath *indexPath, HCollectionView *collection);
typedef void (^HItemSelectionBlock)(NSIndexPath *indexPath, HCollectionView *collection);

@interface HItemModel : NSObject

#pragma -mark 允许外部设置
@property (nonatomic, copy) HItemRenderBlock renderBlock;            // optional
@property (nonatomic, copy) HItemSelectionBlock selectionBlock;      // optional

#pragma -mark 内部自动赋值
@property (nonatomic, copy) HItemSizeBlock itemSizeBlock;            // optional
@property (nonatomic, assign) CGSize itemSize;  // 内部自动计算赋值
@property (nonatomic, strong) NSString *selector; //cell对应的selector

@end
