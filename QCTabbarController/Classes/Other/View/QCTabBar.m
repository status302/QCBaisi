//
//  QCTabBar.m
//  QCTabbarController
//
//  Created by 程庆春 on 16/3/9.
//  Copyright © 2016年 QC Inc. All rights reserved.
//
// 仿写“百思不得其姐”的 tabbarController
//

#import "QCTabBar.h"


@interface QCTabBar()


@property (weak, nonatomic) UIButton *publishButton;
@end
@implementation QCTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化发布按钮
        UIButton *publishButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        
        
        [publishButton addTarget:self action:@selector(handlePublish) forControlEvents:UIControlEventTouchUpInside];
        
        self.publishButton = publishButton;
        [self addSubview:publishButton];
    }
    
    return self;
}

- (void) handlePublish {
    NSLog(@"pushlish click");
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // w：当前tabbar的五分之一宽度；h：当前tabbar的高度；y：当前tabbar的高度；i：
    CGFloat w = self.width/5.0;
    CGFloat h = self.height;
    CGFloat y = 0.0;
    NSInteger i = 0;
   
    //    设置发布按钮的frame
    self.publishButton.bounds = CGRectMake(0, 0, self.publishButton.currentBackgroundImage.size.width, self.publishButton.currentBackgroundImage.size.height);
    self.publishButton.center = CGPointMake(w*0.5*5, h*0.5);
   
    // 设置其他的几个按钮的frame
    for (UIView *view in self.subviews) {
//        if ([view isKindOfClass: NSClassFromString(@"UITabBarButton")] ) {
//            continue;
//        }
//        view.frame = CGRectMake(i*w, y, w, h);
//        i++;
        if (![view isKindOfClass:[UIControl class]] || view == self.publishButton) {
            continue;
        }
        CGFloat buttonX = w *((i > 1)? (i + 1): i);
        view.frame = CGRectMake(buttonX, y, w, h);
        i++;
    }
    
    
}
@end
