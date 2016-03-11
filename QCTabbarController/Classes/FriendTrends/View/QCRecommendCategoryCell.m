//
//  QCRecommendCategoryCell.m
//  QCTabbarController
//
//  Created by 程庆春 on 16/3/10.
//  Copyright © 2016年 QC Inc. All rights reserved.
//

#import "QCRecommendCategoryCell.h"
#import "QCRecommendCategory.h"

@implementation QCRecommendCategoryCell

- (void)awakeFromNib {
    
}

-(void)setCategory:(QCRecommendCategory *)category {
    
#pragma mark - --------------------------有问题有问题有问题-------------------------
#warning --------------------------有问题有问题有问题-------------------------
    //
    // 这里的category不能用self.category，而是必须要用_category;;;;;
    // 为什么？？？？
    // 下划线与self有什么区别？？？
    // ————--------------------------------------------------------------
    
    self.category = category;
    /**
     *  设置textLabel的text为name
     */
    self.textLabel.text = category.name;
    
}
@end
