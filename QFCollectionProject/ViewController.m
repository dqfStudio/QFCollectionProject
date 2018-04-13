//
//  ViewController.m
//  QFCollectionProject
//
//  Created by dqf on 2018/3/30.
//  Copyright © 2018年 dqfStudio. All rights reserved.
//

#import "ViewController.h"
#import "QFCollectionView.h"
#import "QFBaseItem.h"
#import "QFTestItem.h"

@interface ViewController ()

@property (nonatomic) QFCollectionView *collection;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _collection = [[QFCollectionView alloc] initWithFrame:self.view.frame];
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
                     @"groupModel2<1>itemModel2"];


    [self.collection loadView:self withArr:arr];

}


- (void)groupModel:(id)sender {
    QFGroupModel *sectionModel = sender;
    sectionModel.marginX = 10;
    sectionModel.rowInterval = 10;
    sectionModel.colInterval = 10;
    sectionModel.marginTop = 22;
}

- (void)groupModel2:(id)sender {
    QFGroupModel *sectionModel = sender;
    sectionModel.marginX = 10;
    sectionModel.rowInterval = 10;
    sectionModel.colInterval = 10;
    sectionModel.marginTop = 10;
}

- (void)itemModel:(id)sender {
    QFItemModel *cellModel = sender;
    cellModel.itemSize = CGSizeMake(55, 55);
    cellModel.renderBlock = [self renderBlock];
    cellModel.selectionBlock = [self selectionBlock];
}

- (void)itemModel2:(id)sender {
    QFItemModel *cellModel = sender;
    cellModel.itemSize = CGSizeMake(55, 55);
    cellModel.renderBlock = [self renderBlock2];
    cellModel.selectionBlock = [self selectionBlock];
}

- (QFItemRenderBlock)renderBlock {
    return ^UICollectionViewCell *(NSIndexPath *indexPath, QFCollectionView *collection) {
        QFTestItem *cell = [collection registerCell:QFTestItem.class indexPath:indexPath initBlock:^(QFTestItem *cell) {
            [cell.titleLabel setText:@"hh"];
            [cell.titleLabel setTextAlignment:NSTextAlignmentLeft];
        }];
        [cell setBackgroundColor:[UIColor redColor]];
        
        return cell;
    };
}

- (QFItemRenderBlock)renderBlock2 {
    return ^UICollectionViewCell *(NSIndexPath *indexPath, QFCollectionView *collection) {
        QFTestItem *cell = [collection registerCell:QFTestItem.class indexPath:indexPath initBlock:^(QFTestItem *cell) {
            [cell.titleLabel setText:@"ww"];
            [cell.titleLabel setTextAlignment:NSTextAlignmentCenter];
        }];
        [cell setBackgroundColor:[UIColor blueColor]];
        
        return cell;
    };
}

- (QFItemSelectionBlock)selectionBlock {
    return ^(NSIndexPath *indexPath, UICollectionView *collection) {
        [collection deselectItemAtIndexPath:indexPath animated:YES];
    };
}

@end
