//
//  QCProgressView.m
//  QCTabbarController
//
//  Created by 程庆春 on 16/5/6.
//  Copyright © 2016年 QC Inc. All rights reserved.
//

#import "QCProgressView.h"

@implementation QCProgressView

- (void)awakeFromNib {
    self.progressLabel.textColor = [UIColor whiteColor];
    self.roundedCorners = 3;
}
- (void)setProgress:(CGFloat)progress animated:(BOOL)animated {
    [super setProgress:progress animated:animated];
    
    NSString *text = [NSString stringWithFormat:@"%.0f%%",progress * 100];
    
    self.progressLabel.text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
}
@end
