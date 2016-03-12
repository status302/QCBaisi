//
//  QCRecommendTagsViewController.m
//  QCTabbarController
//
//  Created by 程庆春 on 16/3/12.
//  Copyright © 2016年 QC Inc. All rights reserved.
//

#import "QCRecommendTagsViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <AFNetworking.h>
#import "MJExtension.h"
#import <SDImageCache.h>
#import <MJRefresh.h>
#import "QCRecommendTag.h"
#import "QCRecommendTagsCell.h"

@interface QCRecommendTagsViewController ()

@property (strong, nonatomic) NSMutableArray *recommendTags;


@end

@implementation QCRecommendTagsViewController

static NSString * const RecommendTagCell = @"RecommendTagCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 70;
    self.navigationItem.title = @"推荐标签";
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([QCRecommendTagsCell class]) bundle:nil] forCellReuseIdentifier:RecommendTagCell];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    [[AFHTTPSessionManager manager]GET:URL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        // 打印出请求的结果
        NSLog(@"%@", responseObject);
        self.recommendTags = [QCRecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
        
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.recommendTags.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QCRecommendTagsCell *cell = [tableView dequeueReusableCellWithIdentifier:RecommendTagCell];
    
    cell.recommendTag = self.recommendTags[indexPath.row];
    return cell;
}

@end
