//
//  QCTabbarController.m
//  QCTabbarController
//
//  Created by 程庆春 on 16/3/9.
//  Copyright © 2016年 QC Inc. All rights reserved.
//

#import "QCTabbarController.h"
#import "QCTabBar.h"
#import "QCEssenceViewController.h"
#import "QCFriendViewController.h"
#import "QCMeViewController.h"
#import "QCNewViewController.h"
#import "QCNavigationController.h"

@interface QCTabbarController ()

@end

@implementation QCTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableDictionary *arrts = [[NSMutableDictionary alloc] init];
    arrts[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    arrts[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    
    NSMutableDictionary *selectedArrts = [[NSMutableDictionary alloc] init];
    selectedArrts[NSFontAttributeName] = [UIFont systemFontOfSize: 15];
    selectedArrts[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:arrts forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedArrts forState:UIControlStateSelected];
    
    QCEssenceViewController *essenceVC = [[QCEssenceViewController alloc] init];
    QCNewViewController *newVC = [[QCNewViewController alloc] init];
    QCMeViewController *meVC = [[QCMeViewController alloc] init];
    QCFriendViewController *friendVC = [[QCFriendViewController alloc] init];
    
    [self addChildVCWithVC:essenceVC Title:@"精华" image:[UIImage imageNamed:@"tabBar_essence_icon"] selectedImage:[UIImage imageNamed:@"tabBar_essence_click_icon"]];
    [self addChildVCWithVC:newVC Title:@"最新" image:[UIImage imageNamed:@"tabBar_new_icon"] selectedImage:[UIImage imageNamed:@"tabBar_new_click_icon"]];
    [self addChildVCWithVC:friendVC Title:@"朋友" image:[UIImage imageNamed:@"tabBar_friendTrends_icon"] selectedImage:[UIImage imageNamed:@"tabBar_friendTrends_click_icon"]];
    [self addChildVCWithVC:meVC Title:@"我" image:[UIImage imageNamed:@"tabBar_me_icon"] selectedImage:[UIImage imageNamed:@"tabBar_me_click_icon"]];
    
    //    self.tabBar = [[QCTabBar alloc]init];
    // 可以通过KVC来解决这样的问题
    
    // KVC 是直接可以返回一个对象的
    [self setValue:[[QCTabBar alloc]init] forKey:@"tabBar"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) addChildVCWithVC:(UIViewController *)viewController Title:(NSString *)title image:(UIImage *)image selectedImage: (UIImage *)selectedImage {
    viewController.tabBarItem.title = title;
    [viewController.tabBarItem setImage:image];
    [viewController.tabBarItem setSelectedImage:selectedImage];
    // 使用随机的颜色来设置viewController.view 的背景颜色
    viewController.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(100)/100.0 green:arc4random_uniform(100)/100.0 blue:arc4random_uniform(100)/100.0 alpha:1.0];
    // 围着四个控制器添加导航栏
    QCNavigationController *nav = [[QCNavigationController alloc] initWithRootViewController:viewController];
    
    [self addChildViewController:nav];
}


@end
