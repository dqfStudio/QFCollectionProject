//
//  HGroupModel.m
//  HCollectionProject
//
//  Created by dqf on 2018/3/30.
//  Copyright © 2018年 dqfStudio. All rights reserved.
//

#import "HGroupModel.h"

@interface HGroupModel ()
@property (nonatomic) NSMutableArray<HItemModel *> *itemModelArray;
@end

@implementation HGroupModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _itemModelArray = [NSMutableArray array];
        _rowItems  = 1;
        _whFactor  = 1;
    }
    return self;
}

- (void)addModel:(HItemModel *)anObject {
    if ([anObject isKindOfClass:[HItemModel class]]) {
        if (![self.itemModelArray containsObject:anObject]) {
            [self.itemModelArray addObject:anObject];
        }
    }
}

- (HItemModel *)itemAtIndex:(NSUInteger)index {
    if (index < self.itemModelArray.count) {
        return self.itemModelArray[index];
    }
    return nil;
}

- (NSUInteger)indexOfItem:(HItemModel *)anObject {
    if ([anObject isKindOfClass:[HItemModel class]]) {
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

