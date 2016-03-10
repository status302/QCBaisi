//
//  UIBarButtonItem+QC.m
//  QCTabbarController
//
//  Created by 程庆春 on 16/3/10.
//  Copyright © 2016年 QC Inc. All rights reserved.
//

#import "UIBarButtonItem+QC.h"

@implementation UIBarButtonItem (QC)

+(instancetype) itemWithImage: (NSString *)imageName highlightedImage: (NSString *)highlightedImageName target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highlightedImageName] forState:UIControlStateHighlighted];
    button.size = button.currentBackgroundImage.size;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}
@end
