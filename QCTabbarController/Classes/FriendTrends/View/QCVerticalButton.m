//
//  QCVerticalButton.m
//  QCTabbarController
//
//  Created by 程庆春 on 16/3/12.
//  Copyright © 2016年 QC Inc. All rights reserved.
//

#import "QCVerticalButton.h"

@implementation QCVerticalButton

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        // 待初始化的操作
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 设置imageView的frame
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;

    // 设置titleLabel的frame
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.imageView.width;
    self.titleLabel.height = self.height - self.imageView.height - 10;
}

@end
