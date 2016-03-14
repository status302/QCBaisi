//
//  QCEssenceViewController.m
//  QCTabbarController
//
//  Created by 程庆春 on 16/3/9.
//  Copyright © 2016年 QC Inc. All rights reserved.
//

#import "QCEssenceViewController.h"
#import "QCRecommendTagsViewController.h"


@interface QCEssenceViewController ()

@property (weak, nonatomic) UIButton *selectedButton;
@property (weak, nonatomic) UIView *headerView;
@property (weak, nonatomic) UIView *redIndicatorView;

@end

@implementation QCEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor  =QCRGBColor(40, 50, 60);

    [self setupNav];
    
    [self setupHeaderView];
    
}

- (void) setupHeaderView {
    // 添加背景View到self.view
    UIView *headerBackgroundView = [[UIView alloc] init];
    
    headerBackgroundView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.8];
    headerBackgroundView.x = 0.0;
    headerBackgroundView.y = 64.0;
    headerBackgroundView.width = self.view.width;
    headerBackgroundView.height = 45.0;
    
    [self.view addSubview:headerBackgroundView];
    
    self.headerView = headerBackgroundView;
    
    // 在点击button底部添加red标识
    UIView *indicatorView = [[UIView alloc]init];
    
    indicatorView.height = 2.0;
    indicatorView.y = headerBackgroundView.height - indicatorView.height;
    indicatorView.backgroundColor = [UIColor redColor];
    
    [headerBackgroundView addSubview:indicatorView];
    
    self.redIndicatorView = indicatorView;

    
    // 添加按钮
    NSArray *buttonsArray = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    
    CGFloat width = headerBackgroundView.width / 5.0;
    CGFloat height = headerBackgroundView.height;
    CGFloat y = 0.0;
    for (NSInteger i=0; i<buttonsArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(width*i, y, width, height);
        
        [button setTitle:buttonsArray[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        [headerBackgroundView addSubview:button];
        [button setNeedsLayout];

        [button addTarget:self action:@selector(handleHeaderButton:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;
            
            [button.titleLabel sizeToFit];
            self.redIndicatorView.width = button.titleLabel.width;
            self.redIndicatorView.centerX  = button.centerX;

        }
    }
    
    
}
- (void) handleHeaderButton: (UIButton *)button {
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.redIndicatorView.width = button.titleLabel.width;
         self.redIndicatorView.centerX  = button.centerX;
    }];
}

- (void) setupNav {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highlightedImage:@"MainTagSubIconClick" target:self action:@selector(mainTagClick)];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
}

- (void) mainTagClick {
    
    QCRecommendTagsViewController *recommendTagsVC = [[QCRecommendTagsViewController alloc] init];
    [self.navigationController pushViewController:recommendTagsVC animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
