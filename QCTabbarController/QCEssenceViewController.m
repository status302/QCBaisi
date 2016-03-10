//
//  QCEssenceViewController.m
//  QCTabbarController
//
//  Created by 程庆春 on 16/3/9.
//  Copyright © 2016年 QC Inc. All rights reserved.
//

#import "QCEssenceViewController.h"

@interface QCEssenceViewController ()

@end

@implementation QCEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加左按钮
    UIButton *leftItemView = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftItemView setBackgroundImage:[UIImage imageNamed:@"MainTagSubIcon"] forState:UIControlStateNormal];
    [leftItemView setBackgroundImage:[UIImage imageNamed:@"MainTagSubIconClick"] forState:UIControlStateHighlighted];
    CGRect f = leftItemView.frame;
    f.size = leftItemView.currentBackgroundImage.size;
    leftItemView.frame = f;
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftItemView];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
