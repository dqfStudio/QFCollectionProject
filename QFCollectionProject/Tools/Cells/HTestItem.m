//
//  HTestItem.m
//  HCollectionProject
//
//  Created by dqf on 2018/4/13.
//  Copyright © 2018年 dqfStudio. All rights reserved.
//

#import "HTestItem.h"

@implementation HTestItem

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setFrame:self.bounds];
        [_titleLabel setTextColor:[UIColor blackColor]];
    }
    return _titleLabel;
}

- (void)initUI {
    [self addSubview:self.titleLabel];
}

@end
