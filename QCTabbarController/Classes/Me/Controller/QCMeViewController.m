//
//  QCMeViewController.m
//  QCTabbarController
//
//  Created by 程庆春 on 16/3/9.
//  Copyright © 2016年 QC Inc. All rights reserved.
//

#import "QCMeViewController.h"

@interface QCMeViewController ()

@end

@implementation QCMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的";
    UIBarButtonItem *item1 = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highlightedImage:@"mine-moon-icon-click" target:self action:@selector(mineMoonCick)];
    UIBarButtonItem *item2 = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highlightedImage:@"mine-setting-icon-click" target:self action:@selector(mineSettingClick)];
    
    self.navigationItem.rightBarButtonItems = @[item2, item1];
    
    self.view.backgroundColor = QCRGBColor(10, 201, 20);
}
- (void) mineMoonCick {
    NSLog(@"mineMoonClick");
}
-(void) mineSettingClick {
    NSLog(@"mineSettingClick");
}
@end
