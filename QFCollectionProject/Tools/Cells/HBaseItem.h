//
//  HBaseItem.h
//  HCollectionProject
//
//  Created by dqf on 2018/3/30.
//  Copyright © 2018年 dqfStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HItemModel.h"

@interface HBaseItem : UICollectionViewCell
@property (nonatomic, weak) UICollectionView *collection;
@property (nonatomic) NSIndexPath *indexPath;
@property (nonatomic) HItemModel *model;
//子类覆盖
- (void)initUI;
@end
