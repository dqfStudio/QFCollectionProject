//
//  QFCollectionModel.h
//  QFCollectionProject
//
//  Created by dqf on 2018/3/30.
//  Copyright © 2018年 dqfStudio. All rights reserved.
//

#import "QFGroupModel.h"

@interface QFCollectionModel : NSObject
<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

//向model添加对象数据
- (void)addModel:(QFGroupModel *)anObject;

- (QFGroupModel *)groupAtIndex:(NSUInteger)index;

- (NSUInteger)indexOfGroup:(QFGroupModel *)anObject;

- (NSUInteger)groups;

//clear all model
- (void)clearModel;

@end
