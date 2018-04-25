//
//  QFCollectionView.m
//  QFCollectionProject
//
//  Created by dqf on 2018/3/30.
//  Copyright © 2018年 dqfStudio. All rights reserved.
//

#import "QFCollectionView.h"
#import <objc/runtime.h>

#define KDefaultPageSize 20

@interface NSString (util)
- (NSString *(^)(id))append;
- (NSArray<NSString *> *(^)(NSString *))componentsBySetString;
@end

@interface QFCollectionView ()
@property (nonatomic, weak)   id objc;
@property (nonatomic, strong) QFCollectionModel *collectionModel;
@end

@implementation QFCollectionView

#pragma --mark init

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame collectionViewLayout:[UICollectionViewLeftAlignedLayout new]];
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(nonnull UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.alwaysBounceVertical = YES;
        self.backgroundColor = [UIColor clearColor];
        self.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        self.collectionModel = [[QFCollectionModel alloc] init];
        self.delegate = self.collectionModel;
        self.dataSource = self.collectionModel;
        self.allReuseCells = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma --mark register cell

- (id)registerCell:(Class)cellClass indexPath:(NSIndexPath *)indexPath {
    return [self registerCell:cellClass indexPath:indexPath reuseIdentifier:NSStringFromClass(cellClass) initBlock:nil];
}
- (id)registerCell:(Class)cellClass indexPath:(NSIndexPath *)indexPath reuseIdentifier:(NSString *)reuseIdentifier {
    return [self registerCell:cellClass indexPath:indexPath reuseIdentifier:reuseIdentifier initBlock:nil];
}
- (id)registerCell:(Class)cellClass indexPath:(NSIndexPath *)indexPath initBlock:(QFItemInitBlock)block {
    return [self registerCell:cellClass indexPath:indexPath reuseIdentifier:NSStringFromClass(cellClass) initBlock:block];
}
- (id)registerCell:(Class)cellClass indexPath:(NSIndexPath *)indexPath reuseIdentifier:(NSString *)reuseIdentifier initBlock:(QFItemInitBlock)block {
    UICollectionViewCell *cell = nil;
    if (reuseIdentifier.length > 0) {
        if (![self.allReuseCells containsObject:reuseIdentifier]) {
            [self registerClass:cellClass forCellWithReuseIdentifier:reuseIdentifier];
            cell = [self dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
            if (block) {
                block(cell);
            }
        }else {
            cell = [self dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        }
    }
    return cell;
}

#pragma --mark other methods

//add QFGroupModel
- (void)addModel:(QFGroupModel *)anObject {
    [self.collectionModel addModel:anObject];
}

- (QFGroupModel *)groupAtIndex:(NSUInteger)index {
    return [self.collectionModel groupAtIndex:index];
}

- (NSUInteger)indexOfGroup:(QFGroupModel  *)anObject {
    return [self.collectionModel indexOfGroup:anObject];
}

- (QFItemModel *)itemAtIndexPath:(NSIndexPath *)indexPath {
    QFGroupModel *groupModel = [self groupAtIndex:indexPath.section];
    return [groupModel itemAtIndex:indexPath.row];
}

- (void)reloadModel {
    for (int i=0; i<[self.collectionModel groups]; i++) {
        QFGroupModel *groupModel = [self.collectionModel groupAtIndex:i];
        NSString *groupSelector = groupModel.selector;
        if (groupSelector.length > 0 && groupModel) {
            SEL sel = NSSelectorFromString(groupModel.selector);
            if([self.objc respondsToSelector:sel]){
                [self.objc performSelector:sel withObjects:@[groupModel]];
            }
            
            for (int j=0; j<[groupModel items]; j++) {
                QFItemModel *itemModel = [groupModel itemAtIndex:j];
                NSString *itemSelector = itemModel.selector;
                if (itemSelector.length > 0 && itemModel) {
                    SEL sel = NSSelectorFromString(itemModel.selector);
                    if([self.objc respondsToSelector:sel]){
                        [self.objc performSelector:sel withObjects:@[itemModel]];
                    }
                }
            }
        }
    }
    //刷新列表
    [self reloadData];
}

//clear all model
- (void)clearModel {
    [self.collectionModel clearModel];
    //刷新列表
    [self reloadData];
}

- (void)refreshView:(id)object withArr:(NSArray *)arr {
    //先清除数据
    [self clearModel];
    [self loadView:object withArr:arr];
}

- (void)loadView:(id)object withArr:(NSArray *)arr {
    
    if (!self.objc || self.objc != object) self.objc = object;
    
    for (NSString *url in arr) {
        
        NSArray<NSString *> *tmpArr = url.componentsBySetString(@"<>");
        
        NSString *groupSelector = tmpArr[0].append(@":");
        NSString *group = tmpArr[1];
        NSString *itemSelector = tmpArr[2].append(@":");
        
        QFGroupModel *groupModel = [self groupAtIndex:group.integerValue];
        if (!groupModel) {
            groupModel = [QFGroupModel new];
            [groupModel setSelector:groupSelector];
            [self addModel:groupModel];
            
            if([object respondsToSelector:NSSelectorFromString(groupSelector)]){
                [object performSelector:NSSelectorFromString(groupSelector) withObjects:@[groupModel]];
            }
        }
        
        QFItemModel *itemModel = [QFItemModel new];
        [itemModel setSelector:itemSelector];
        [groupModel addModel:itemModel];
        
        if([object respondsToSelector:NSSelectorFromString(itemSelector)]){
            [object performSelector:NSSelectorFromString(itemSelector) withObjects:@[itemModel]];
            if (!itemModel.renderBlock) {
                itemModel.renderBlock = [self renderBlock];
            }
            if (!itemModel.selectionBlock) {
                itemModel.selectionBlock = [self selectionBlock];
            }
        }else {
            itemModel.renderBlock = [self renderBlock];
            itemModel.selectionBlock = [self selectionBlock];
        }
        //设置item size
        CGFloat screenWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
        CGFloat width  = (screenWidth - groupModel.marginX*2 - groupModel.colInterval*(groupModel.rowItems-1))/groupModel.rowItems;
        CGFloat height = width * groupModel.whFactor;
        if (groupModel.height > 0) {
            height = groupModel.height;
        }
        itemModel.itemSize = CGSizeMake(width, height);
    }
    
    //刷新列表
    [self reloadData];
    [self endRefresh];
}

- (QFItemRenderBlock)renderBlock {
    return ^UICollectionViewCell *(NSIndexPath *indexPath, QFCollectionView *collection) {
        UICollectionViewCell *cell = [self registerCell:UICollectionViewCell.class indexPath:indexPath];
        return cell;
    };
}

- (QFItemSelectionBlock)selectionBlock {
    return ^(NSIndexPath *indexPath, QFCollectionView *collection) {
        [collection deselectItemAtIndexPath:indexPath animated:YES];
    };
}

- (NSUInteger)pageNo {
    NSNumber *page = objc_getAssociatedObject(self, _cmd);
    if (!page) {
        [self setPageNo:1];
    }
    return [objc_getAssociatedObject(self, _cmd) unsignedIntegerValue];
}

- (void)setPageNo:(NSUInteger)pageNo {
    objc_setAssociatedObject(self, @selector(pageNo), @(pageNo), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSUInteger)pageSize {
    NSNumber *pageSize = objc_getAssociatedObject(self, _cmd);
    if (!pageSize) {
        return KDefaultPageSize;
    }
    return [pageSize unsignedIntegerValue];
}

- (void)setPageSize:(NSUInteger)pageSize {
    objc_setAssociatedObject(self, @selector(pageSize), @(pageSize), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)beginRefresh {
    if (_refreshBlock) {
        [self setPageNo:1];
        [self.mj_header beginRefreshing];
    }
}

//stop refresh
-(void)endRefresh {
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
}

- (void)setRefreshBlock:(QFRefreshBlock)refreshBlock {
    _refreshBlock = refreshBlock;
    if (_refreshBlock) {
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self setPageNo:1];
            _refreshBlock();
        }];
    }else {
        self.mj_header = nil;
    }
}

- (void)setLoadMoreBlock:(QFLoadMoreBlock)loadMoreBlock {
    _loadMoreBlock = loadMoreBlock;
    if (_loadMoreBlock) {
        [self setPageNo:1];
        self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            self.pageNo += 1;
            _loadMoreBlock();
        }];
    }else {
        self.mj_footer = nil;
    }
}

@end

@implementation NSString (util)
- (NSString *(^)(id))append {
    return ^NSString *(id obj) {
        return [NSString stringWithFormat:@"%@%@", self,obj];
    };
}
- (NSArray<NSString *> *(^)(NSString *))componentsBySetString {
    return ^NSArray<NSString *> *(NSString *separator) {
        NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:separator];
        NSCharacterSet *charSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSArray *arr = [self componentsSeparatedByCharactersInSet:characterSet];
        NSMutableArray *mutablerArr = [NSMutableArray new];
        //过滤掉为空的字符串
        for (int i=0; i<arr.count; i++) {
            NSString *str = arr[i];
            if (str.length > 0) {
                //过滤掉字符串两端为空的字符
                NSString *trimStr = [str stringByTrimmingCharactersInSet:charSet];
                if (trimStr.length > 0) {
                    [mutablerArr addObject:trimStr];
                }
            }
        }
        return mutablerArr;
    };
}
@end

@interface NSArray ()
@property (nonatomic) NSInteger group;
@property (nonatomic) NSString *groupModel;
@end

@implementation NSArray (QFCollectionView)
- (NSInteger)group {
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}
- (void)setGroup:(NSInteger)group {
    objc_setAssociatedObject(self, @selector(group), @(group), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)groupModel {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setGroupModel:(NSString *)groupModel {
    objc_setAssociatedObject(self, @selector(groupModel), groupModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray *(^)(NSArray *))linkItem {
    return ^NSArray *(NSArray *obj) {
        NSMutableArray *mutableArr = [[NSMutableArray alloc] init];
        for (int i=0; i<self.count; i++) {
            NSString *model = self.groupModel.append(@"<").append(@(self.group)).append(@">").append(self[i]);
            [mutableArr addObject:model];
        }
        for (int i=0; i<obj.count; i++) {
            NSString *model = obj.groupModel.append(@"<").append(@(obj.group)).append(@">").append(obj[i]);
            [mutableArr addObject:model];
        }
        return mutableArr;
    };
}
- (void (^)(NSUInteger group, NSString *groupModel))setGroupModel {
    return ^void (NSUInteger group, NSString *groupModel) {
        self.group = group;
        self.groupModel = groupModel;
    };
}
@end
