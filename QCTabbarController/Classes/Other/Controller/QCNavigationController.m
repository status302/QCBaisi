//
//  QCNavigationController.m
//  QCTabbarController
//
//  Created by 程庆春 on 16/3/10.
//  Copyright © 2016年 QC Inc. All rights reserved.
//

#import "QCNavigationController.h"

@interface QCNavigationController ()

@end

@implementation QCNavigationController

/**
 *  该方法表示当该类第一次被调用的时候调用该方法。而且之调用一次
 */
+ (void)initialize {
    // 这里说明一下，bar background只被调用了一次。没有只要重复调用。
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 下面设置导航栏背景色的方式是不准确的，没有效果
//    self.navigationBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"]];

    // 正确的设置导航栏背景色的方式
    // 方法一：
//    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"MainTagSubIconClick"] forBarMetrics:UIBarMetricsDefault];
    // 方法二：
//    UINavigationBar *bar = [UINavigationBar appearance];
//    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}

/**
 *  可以在这个方法里拦截所有进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {

    
    // OK : 成功了添加了返回按钮，并改变了其背景色
    if (self.childViewControllers.count > 0) {
        // 重写返回按钮，改变其长按是的颜色
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        button.size = CGSizeMake(70, 30);
//        [button sizeToFit];
        //        button.contentMode = UIViewContentModeLeft;// 这个是用来专门设置imageView的
        // 这个专门是用来设置UIControl的
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        button.backgroundColor = [UIColor redColor];// 设置颜色是用来观察其位置变化
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        // 将自定义的返回按钮添加到navigationBar
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        // 当push的时候隐藏tabbar
//        viewController.hidesBottomBarWhenPushed = YES;
    }
    

    
    // 调用父类的push方法，实现push步骤。
    [super pushViewController:viewController animated:animated];

    
}

-(void) back {
    [self popViewControllerAnimated:YES];
}


@end
