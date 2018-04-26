//
//  HBaseItem.m
//  HCollectionProject
//
//  Created by dqf on 2018/3/30.
//  Copyright © 2018年 dqfStudio. All rights reserved.
//

#import "HBaseItem.h"

@implementation HBaseItem

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

//子类覆盖
- (void)initUI {}

@end

