//
//  HCollectionModel.h
//  HCollectionProject
//
//  Created by dqf on 2018/3/30.
//  Copyright © 2018年 dqfStudio. All rights reserved.
//

#import "HGroupModel.h"

@class HCollectionView;

@interface HCollectionModel : NSObject
<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

//向model添加对象数据
- (void)addModel:(HGroupModel *)anObject;

- (HGroupModel *)groupAtIndex:(NSUInteger)index;

- (NSUInteger)indexOfGroup:(HGroupModel *)anObject;

- (NSUInteger)groups;

//clear all model
- (void)clearModel;

@end
