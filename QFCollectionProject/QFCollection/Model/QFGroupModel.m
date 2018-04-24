//
//  QFGroupModel.m
//  QFCollectionProject
//
//  Created by dqf on 2018/3/30.
//  Copyright © 2018年 dqfStudio. All rights reserved.
//

#import "QFGroupModel.h"

@interface QFGroupModel ()
@property (nonatomic) NSMutableArray<QFItemModel *> *itemModelArray;
@end

@implementation QFGroupModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _itemModelArray = [NSMutableArray array];
        _rowItems  = 1;
        _whFactor  = 1;
        _autoFitWH = YES;
    }
    return self;
}

- (void)addModel:(QFItemModel *)anObject {
    if ([anObject isKindOfClass:[QFItemModel class]]) {
        if (![self.itemModelArray containsObject:anObject]) {
            [self.itemModelArray addObject:anObject];
        }
    }
}

- (QFItemModel *)itemAtIndex:(NSUInteger)index {
    if (index < self.itemModelArray.count) {
        return self.itemModelArray[index];
    }
    return nil;
}

- (NSUInteger)indexOfItem:(QFItemModel *)anObject {
    if ([anObject isKindOfClass:[QFItemModel class]]) {
        return [self.itemModelArray indexOfObject:anObject];
    }
    return -1;
}

- (NSUInteger)items {
    return self.itemModelArray.count;
}

- (void)clearModel {
    if (self.itemModelArray.count > 0) {
        [self.itemModelArray removeAllObjects];
    }
}

@end

