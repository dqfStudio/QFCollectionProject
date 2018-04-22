//
//  QFItemModel.h
//  QFCollectionProject
//
//  Created by dqf on 2018/3/30.
//  Copyright © 2018年 dqfStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class QFCollectionView;

typedef CGSize (^QFItemSizeBlock)(NSIndexPath *indexPath, QFCollectionView *collection);
typedef UICollectionViewCell * (^QFItemRenderBlock)(NSIndexPath *indexPath, QFCollectionView *collection);
typedef void (^QFItemSelectionBlock)(NSIndexPath *indexPath, QFCollectionView *collection);

@interface QFItemModel : NSObject

@property (nonatomic, copy) QFItemSizeBlock itemSizeBlock;            // optional
@property (nonatomic, copy) QFItemRenderBlock renderBlock;            // required
@property (nonatomic, copy) QFItemSelectionBlock selectionBlock;      // optional
@property (nonatomic, assign) CGSize itemSize;  // optional
@property (nonatomic, strong) NSString *selector; //cell对应的selector

@end
