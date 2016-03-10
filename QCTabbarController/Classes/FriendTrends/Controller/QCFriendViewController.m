//
//  QCFriendViewController.m
//  QCTabbarController
//
//  Created by 程庆春 on 16/3/9.
//  Copyright © 2016年 QC Inc. All rights reserved.
//

#import "QCFriendViewController.h"

@interface QCFriendViewController ()

@end

@implementation QCFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的关注";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highlightedImage:@"friendsRecommentIcon-click" target:self action:@selector(friendRecommendClick)];
}
-(void)friendRecommendClick {
    NSLog(@"friendRecommendClick");
}

@end
