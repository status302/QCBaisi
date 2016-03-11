//
//  QCRecommendCategory.m
//  QCTabbarController
//
//  Created by 程庆春 on 16/3/10.
//  Copyright © 2016年 QC Inc. All rights reserved.
//

#import "QCRecommendCategory.h"


@interface QCRecommendCategory()



@end

@implementation QCRecommendCategory

// 懒加载,初始化users数组
- (NSMutableArray *)users {
    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}

@end
