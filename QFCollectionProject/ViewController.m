//
//  ViewController.m
//  HCollectionProject
//
//  Created by dqf on 2018/3/30.
//  Copyright © 2018年 dqfStudio. All rights reserved.
//

#import "ViewController.h"
#import "HCollectionView.h"
#import "HBaseItem.h"
#import "HTestItem.h"

@interface ViewController ()

@property (nonatomic) HCollectionView *collection;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _collection = [[HCollectionView alloc] initWithFrame:self.view.frame];
    [_collection setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_collection];

    
    NSArray *arr = @[@"groupModel<0>itemModel",
                     @"groupModel<0>itemModel",
                     @"groupModel<0>itemModel",
                     @"groupModel<0>itemModel",
                     @"groupModel<0>itemModel",
                     @"groupModel<0>itemModel",
                     @"groupModel<0>itemModel",
                     @"groupModel<0>itemModel",
                     @"groupModel<0>itemModel",
                     @"groupModel2<1>itemModel2",
                     @"groupModel2<1>itemModel2",
                     @"groupModel2<1>itemModel2",
                     @"groupModel2<1>itemModel2",
                     @"groupModel2<1>itemModel2"];
    
//    NSArray *arr2 = @[@"itemModel",
//                     @"itemModel",
//                     @"itemModel",
//                     @"itemModel",
//                     @"itemModel",
//                     @"itemModel",
//                     @"itemModel",
//                     @"itemModel",
//                     @"itemModel"];
    
    NSArray *arr2 = @"itemModel".multiple(9);
    
//    NSArray *arr3 = @[@"itemModel2",
//                     @"itemModel2",
//                     @"itemModel2",
//                     @"itemModel2",
//                     @"itemModel2",
//                     @"itemModel2"];
    
    NSArray *arr3 = @"itemModel2".multiple(6);
    
    arr2.setGroupModel(0, @"groupModel");
    arr3.setGroupModel(1, @"groupModel2");

    [self.collection loadView:self withArr:arr];
//    [self.collection loadView:self withArr:arr2.linkItem(arr3)];

}


- (void)groupModel:(id)sender {
    HGroupModel *sectionModel = sender;
//    sectionModel.marginX = 10;
    sectionModel.rowInterval = 10;
    sectionModel.colInterval = 10;
    sectionModel.marginTop = 22;
    sectionModel.rowItems = 3;
}

- (void)groupModel2:(id)sender {
    HGroupModel *sectionModel = sender;
//    sectionModel.marginX = 10;
    sectionModel.rowInterval = 10;
    sectionModel.marginTop = 10;
    sectionModel.whFactor = 0.7;
    sectionModel.height = 100;
}

- (void)itemModel:(id)sender {
    HItemModel *cellModel = sender;
    cellModel.renderBlock = [self renderBlock];
    cellModel.selectionBlock = [self selectionBlock];
}

- (void)itemModel2:(id)sender {
    HItemModel *cellModel = sender;
    cellModel.renderBlock = [self renderBlock2];
    cellModel.selectionBlock = [self selectionBlock];
}

- (HItemRenderBlock)renderBlock {
    return ^UICollectionViewCell *(NSIndexPath *indexPath, HCollectionView *collection) {
        HTestItem *cell = [collection registerCell:HTestItem.class indexPath:indexPath initBlock:^(HTestItem *cell) {
            [cell.titleLabel setText:@"hh"];
            [cell.titleLabel setTextAlignment:NSTextAlignmentLeft];
        }];
        [cell setBackgroundColor:[UIColor redColor]];
        
        return cell;
    };
}

- (HItemRenderBlock)renderBlock2 {
    return ^UICollectionViewCell *(NSIndexPath *indexPath, HCollectionView *collection) {
        HTestItem *cell = [collection registerCell:HTestItem.class indexPath:indexPath initBlock:^(HTestItem *cell) {
            [cell.titleLabel setText:@"ww"];
            [cell.titleLabel setTextAlignment:NSTextAlignmentCenter];
        }];
        [cell setBackgroundColor:[UIColor blueColor]];
        return cell;
    };
}

- (HItemSelectionBlock)selectionBlock {
    return ^(NSIndexPath *indexPath, HCollectionView *collection) {
        [collection deselectItemAtIndexPath:indexPath animated:YES];
    };
}

@end
