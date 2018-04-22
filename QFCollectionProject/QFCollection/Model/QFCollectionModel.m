//
//  QFCollectionModel.m
//  QFCollectionProject
//
//  Created by dqf on 2018/3/30.
//  Copyright © 2018年 dqfStudio. All rights reserved.
//

#import "QFCollectionModel.h"

@interface QFCollectionModel ()
@property (nonatomic) NSMutableArray<QFGroupModel *> *groupModelArray;
@end

@implementation QFCollectionModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _groupModelArray = [NSMutableArray array];
    }
    return self;
}

- (void)addModel:(QFGroupModel *)anObject {
    if ([anObject isKindOfClass:[QFGroupModel class]]) {
        if (![self.groupModelArray containsObject:anObject]) {
            [self.groupModelArray addObject:anObject];
        }
    }
}

- (QFGroupModel *)groupAtIndex:(NSUInteger)index {
    if (index < self.groupModelArray.count) {
        return self.groupModelArray[index];
    }
    return nil;
}

- (NSUInteger)indexOfGroup:(QFGroupModel *)anObject {
    if ([anObject isKindOfClass:[QFGroupModel class]]) {
        return [self.groupModelArray indexOfObject:anObject];
    }
    return -1;
}

- (NSUInteger)groups {
    return self.groupModelArray.count;
}

- (void)clearModel {
    if (self.groupModelArray.count > 0) {
        [self.groupModelArray removeAllObjects];
    }
}

- (QFGroupModel*)groupModelAtSection:(NSInteger)section {
    @try {
        QFGroupModel *groupModel = self.groupModelArray[section];
        return groupModel;
    }
    @catch (NSException *exception) {
        return nil;
    }
}

- (QFItemModel*)itemModelAtIndexPath:(NSIndexPath *)indexPath {
    @try {
        QFGroupModel *groupModel = self.groupModelArray[indexPath.section];
        QFItemModel *itemModel = [groupModel itemAtIndex:indexPath.row];
        return itemModel;
    }
    @catch (NSException *exception) {
        return nil;
    }
}

#pragma mark - UICollectionViewDatasource  & delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self groups];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    QFGroupModel *groupModel = [self groupModelAtSection:section];
    return [groupModel items];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    QFItemModel *itemModel = [self itemModelAtIndexPath:indexPath];
    UICollectionViewCell *cell = nil;
    QFItemRenderBlock renderBlock = itemModel.renderBlock;
    if (renderBlock) {
        cell = renderBlock(indexPath, (QFCollectionView *)collectionView);
    }
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    QFItemModel *itemModel = [self itemModelAtIndexPath:indexPath];
    QFItemSizeBlock itemSizeBlock = itemModel.itemSizeBlock;
    if (itemSizeBlock) {
        return itemSizeBlock(indexPath, (QFCollectionView *)collectionView);
    } else {
        return itemModel.itemSize;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    QFGroupModel *groupModel = [self groupModelAtSection:section];
    QFHeaderViewSizeBlock headerSizeBlock = groupModel.headerSizeBlock;
    if (headerSizeBlock) {
        return headerSizeBlock(section, (QFCollectionView *)collectionView);
    } else {
        return groupModel.headerSize;
    }
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        QFGroupModel *groupModel = [self groupModelAtSection:indexPath.section];
        QFViewRenderBlock headerViewRenderBlock = groupModel.headerViewRenderBlock;
        if (headerViewRenderBlock) {
            return headerViewRenderBlock(indexPath.section, (QFCollectionView *)collectionView);
        } else {
            return groupModel.headerView;
        }
    }
    return nil;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    QFItemModel *itemModel = [self itemModelAtIndexPath:indexPath];
    QFItemSelectionBlock selectionBlock = itemModel.selectionBlock;
    if (selectionBlock) {
        selectionBlock(indexPath, (QFCollectionView *)collectionView);
    }
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    QFGroupModel *groupModel = [self groupModelAtSection:section];
    return groupModel.rowInterval;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    QFGroupModel *groupModel = [self groupModelAtSection:section];
    return groupModel.colInterval;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    QFGroupModel *groupModel = [self groupModelAtSection:section];
    return UIEdgeInsetsMake(groupModel.marginTop, groupModel.marginX, 0, groupModel.marginX);
}

@end


