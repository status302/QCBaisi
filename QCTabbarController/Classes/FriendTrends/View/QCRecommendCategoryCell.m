//
//  QCRecommendCategoryCell.m
//  QCTabbarController
//
//  Created by 程庆春 on 16/3/10.
//  Copyright © 2016年 QC Inc. All rights reserved.
//

#import "QCRecommendCategoryCell.h"
#import "QCRecommendCategory.h"

@interface QCRecommendCategoryCell()
@property (weak, nonatomic) IBOutlet UIView *categoryIndicatorView;


@end

@implementation QCRecommendCategoryCell

- (void)awakeFromNib {
    self.categoryIndicatorView.backgroundColor = QCRGBColor(219, 21, 26);
}

-(void)setCategory:(QCRecommendCategory *)category {
    
#warning --------------------------有问题有问题有问题-------------------------
    //
    // 这里的category不能用self.category，而是必须要用_category;;;;;
    // 为什么？？？？
    // 下划线与self有什么区别？？？
    // ————--------------------------------------------------------------
    
    _category = category;
    self.textLabel.text = category.name;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.categoryIndicatorView.hidden = !selected;
    
    self.textLabel.textColor = selected ? self.categoryIndicatorView.backgroundColor : QCRGBColor(77, 77, 77);
    
}
@end
