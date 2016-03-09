//
//  QCTabbarController.m
//  QCTabbarController
//
//  Created by 程庆春 on 16/3/9.
//  Copyright © 2016年 QC Inc. All rights reserved.
//

#import "QCTabbarController.h"
#import "QCTabBar.h"

@interface QCTabbarController ()

@end

@implementation QCTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIViewController *vc1 = [[UIViewController alloc]init];
    vc1.view.backgroundColor = [UIColor redColor];
    
    vc1.tabBarItem.title = @"主页";
    
    [self addChildViewController:vc1];
    
    UIViewController *vc2 = [[UIViewController alloc]init];
    vc2.view.backgroundColor = [UIColor blueColor];
    
    vc2.tabBarItem.title = @"关注";
    
    [self addChildViewController:vc2];
    
    UIViewController *vc3 = [[UIViewController alloc]init];
    vc3.view.backgroundColor = [UIColor greenColor];
    
    vc3.tabBarItem.title = @"收藏";
    
    [self addChildViewController:vc3];
    
    UIViewController *vc4 = [[UIViewController alloc]init];
    vc4.view.backgroundColor = [UIColor yellowColor];
    
    vc4.tabBarItem.title = @"我";
    
    [self addChildViewController:vc4];
    
    
    //    self.tabBar = [[QCTabBar alloc]init];
    // 可以通过KVC来解决这样的问题
    
    // KVC 是直接可以返回一个对象的
    [self setValue:[[QCTabBar alloc]init] forKey:@"tabBar"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
