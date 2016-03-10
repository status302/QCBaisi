//
//  UIView+QC.h
//  QCTabbarController
//
//  Created by 程庆春 on 16/3/10.
//  Copyright © 2016年 QC Inc. All rights reserved.
//


/**
 *  说明：
 *  对UIView的封装;
 *  以后使用的时候直接使用width, height, x, y,size,origin即可
 */

#import <UIKit/UIKit.h>

@interface UIView (QC)

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;


@end
