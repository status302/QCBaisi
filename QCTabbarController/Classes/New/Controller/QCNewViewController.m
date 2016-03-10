//
//  QCNewViewController.m
//  QCTabbarController
//
//  Created by 程庆春 on 16/3/9.
//  Copyright © 2016年 QC Inc. All rights reserved.
//

#import "QCNewViewController.h"

@interface QCNewViewController ()

@end

@implementation QCNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highlightedImage:@"MainTagSubIconClick" target:self action:@selector(mainTagClick)];
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
}

-(void) mainTagClick {
    NSLog(@"QCNewViewController MainTagClick");
}

@end
