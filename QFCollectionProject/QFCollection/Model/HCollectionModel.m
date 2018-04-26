//
//  HCollectionModel.m
//  HCollectionProject
//
//  Created by dqf on 2018/3/30.
//  Copyright © 2018年 dqfStudio. All rights reserved.
//

#import "HCollectionModel.h"

@interface HCollectionModel ()
@property (nonatomic) NSMutableArray<HGroupModel *> *groupModelArray;
@end

@implementation HCollectionModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _groupModelArray = [NSMutableArray array];
    }
    return self;
}

- (void)addModel:(HGroupModel *)anObject {
    if ([anObject isKindOfClass:[HGroupModel class]]) {
        if (![self.groupModelArray containsObject:anObject]) {
            [self.groupModelArray addObject:anObject];
        }
    }
}

- (HGroupModel *)groupAtIndex:(NSUInteger)index {
    if (index < self.groupModelArray.count) {
        return self.groupModelArray[index];
    }
    return nil;
}

- (NSUInteger)indexOfGroup:(HGroupModel *)anObject {
    if ([anObject isKindOfClass:[HGroupModel class]]) {
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

- (HGroupModel*)groupModelAtSection:(NSInteger)section {
    @try {
        HGroupModel *groupModel = self.groupModelArray[section];
        return groupModel;
    }
    @catch (NSException *exception) {
        return nil;
    }
}

- (HItemModel*)itemModelAtIndexPath:(NSIndexPath *)indexPath {
    @try {
        HGroupModel *groupModel = self.groupModelArray[indexPath.section];
        HItemModel *itemModel = [groupModel itemAtIndex:indexPath.row];
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
    HGroupModel *groupModel = [self groupModelAtSection:section];
    return [groupModel items];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HItemModel *itemModel = [self itemModelAtIndexPath:indexPath];
    UICollectionViewCell *cell = nil;
    HItemRenderBlock renderBlock = itemModel.renderBlock;
    if (renderBlock) {
        cell = renderBlock(indexPath, (HCollectionView *)collectionView);
    }
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    HItemModel *itemModel = [self itemModelAtIndexPath:indexPath];
    HItemSizeBlock itemSizeBlock = itemModel.itemSizeBlock;
    if (itemSizeBlock) {
        return itemSizeBlock(indexPath, (HCollectionView *)collectionView);
    } else {
        return itemModel.itemSize;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    HGroupModel *groupModel = [self groupModelAtSection:section];
    HHeaderViewSizeBlock headerSizeBlock = groupModel.headerSizeBlock;
    if (headerSizeBlock) {
        return headerSizeBlock(section, (HCollectionView *)collectionView);
    } else {
        return groupModel.headerSize;
    }
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        HGroupModel *groupModel = [self groupModelAtSection:indexPath.section];
        HViewRenderBlock headerViewRenderBlock = groupModel.headerViewRenderBlock;
        if (headerViewRenderBlock) {
            return headerViewRenderBlock(indexPath.section, (HCollectionView *)collectionView);
        } else {
            return groupModel.headerView;
        }
    }
    return nil;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HItemModel *itemModel = [self itemModelAtIndexPath:indexPath];
    HItemSelectionBlock selectionBlock = itemModel.selectionBlock;
    if (selectionBlock) {
        selectionBlock(indexPath, (HCollectionView *)collectionView);
    }
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    HGroupModel *groupModel = [self groupModelAtSection:section];
    return groupModel.rowInterval;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    HGroupModel *groupModel = [self groupModelAtSection:section];
    return groupModel.colInterval;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    HGroupModel *groupModel = [self groupModelAtSection:section];
    return UIEdgeInsetsMake(groupModel.marginTop, groupModel.marginX, 0, groupModel.marginX);
}

@end


