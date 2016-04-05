//
//  QCEssenceViewController.m
//  QCTabbarController
//
//  Created by 程庆春 on 16/3/9.
//  Copyright © 2016年 QC Inc. All rights reserved.
//

#import "QCEssenceViewController.h"
#import "QCRecommendTagsViewController.h"
#import "QCTopicViewController.h"

@interface QCEssenceViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) UIButton *selectedButton;
@property (weak, nonatomic) UIView *headerView;
@property (weak, nonatomic) UIView *redIndicatorView;

@property (weak, nonatomic) UIScrollView *scrollView;

@end

@implementation QCEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor  =QCRGBColor(40, 50, 60);

    [self setupNav];
    
    [self setupHeaderView];
    
    // 添加childVC
    [self setupChildVC];
    
    // 添加scrollView
    [self setupContentView];
    
    
}

-(void) setupChildVC {
 
    QCTopicViewController *all = [[QCTopicViewController alloc]init];
    all.type = 1;
    [self addChildViewController:all];
    
    QCTopicViewController *video = [[QCTopicViewController alloc] init];
    video.type = 41;
    [self addChildViewController:video];
    
    QCTopicViewController *voice = [[QCTopicViewController alloc] init];
    voice.type = 31;
    [self addChildViewController:voice];
    
    QCTopicViewController *picture = [[QCTopicViewController alloc] init];
    picture.type = 10;
    [self addChildViewController:picture];
    
    QCTopicViewController *word = [[QCTopicViewController alloc] init];
    word.type = 29;
    [self addChildViewController:word];
    
}

- (void) setupHeaderView {
    // 添加背景View到self.view
    UIView *headerBackgroundView = [[UIView alloc] init];
    
    headerBackgroundView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.8];
    headerBackgroundView.x = 0.0;
    headerBackgroundView.y = 64.0;
    headerBackgroundView.width = self.view.width;
    headerBackgroundView.height = 35.0;
    
    [self.view addSubview:headerBackgroundView];
    
    self.headerView = headerBackgroundView;
    
    // 在点击button底部添加red标识
    UIView *indicatorView = [[UIView alloc]init];
    
    indicatorView.height = 2.0;
    indicatorView.y = headerBackgroundView.height - indicatorView.height;
    indicatorView.backgroundColor = [UIColor redColor];
    
    [headerBackgroundView addSubview:indicatorView];


    
    // 添加按钮
    NSArray *buttonsArray = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    
    CGFloat width = headerBackgroundView.width / 5.0;
    CGFloat height = headerBackgroundView.height;
    CGFloat y = 0.0;
    for (NSInteger i=0; i<buttonsArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        button.tag = i*1000;
        [button setTag:i * 1000];
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
    
    self.redIndicatorView = indicatorView;
    
}
- (void) handleHeaderButton: (UIButton *)button {
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.redIndicatorView.width = button.titleLabel.width;
         self.redIndicatorView.centerX  = button.centerX;
    }];
    
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = self.scrollView.width * button.tag/1000;
    [self.scrollView setContentOffset:offset animated:YES];
}
/**
 *  设置导航栏
 */
- (void) setupNav {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highlightedImage:@"MainTagSubIconClick" target:self action:@selector(mainTagClick)];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
}
/**
 *  设置中间的ScrollView方法
 */
-(void) setupContentView {
    // 不让系统自己设置scrollView的Insets
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc]init];
    
    contentView.frame = self.view.bounds;
    contentView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.9];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    button.frame = CGRectMake(0, 0, 100, 40);
    [contentView addSubview:button];
    
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    // 设置contentView的课滑动的尺寸，0表示height方向不可滑动
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    
    [self.view insertSubview:contentView atIndex:0];
    self.scrollView = contentView;
    
    // 添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentView];
    
}
- (void) mainTagClick {
    
    QCRecommendTagsViewController *recommendTagsVC = [[QCRecommendTagsViewController alloc] init];
    [self.navigationController pushViewController:recommendTagsVC animated:YES];
    
}

#pragma mark - UIScrollView Delegate 
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    UITableViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0; //默认为20， 在这里将其改为0
    vc.view.height = scrollView.height;
    vc.view.width = scrollView.width;
    vc.tableView.contentInset = UIEdgeInsetsMake(99.0, 0, 49, 0);
    vc.tableView.scrollIndicatorInsets = vc.tableView.contentInset;
    
    [scrollView addSubview:vc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    NSMutableArray *buttons = [NSMutableArray array];
    for (UIView *button in self.headerView.subviews) {
        if ([button isKindOfClass:[UIControl class]]) {
            [buttons addObject:button];
        }
    }
    [self handleHeaderButton:buttons[index]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
