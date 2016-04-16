//
//  QCTopicViewController.m
//  QCTabbarController
//
//  Created by 程庆春 on 16/4/5.
//  Copyright © 2016年 QC Inc. All rights reserved.
//

#import "QCTopicViewController.h"
#import "QCTopicCell.h"
#import <MJRefresh.h>
#import <AFNetworking.h>
#import <MJExtension.h>
#import "QCTopic.h"



@interface QCTopicViewController ()

@property (strong, nonatomic) NSMutableArray *topics;
@property (copy, nonatomic) NSString* maxtime;

@property (strong, nonatomic) NSMutableArray *moreTopics;

@end

@implementation QCTopicViewController
/**
 *  cell ID
 */
static NSString * const topicCellId = @"topicCell";
/**
 *  懒加载获取数据
 */
- (NSMutableArray *)topics {
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     *  添加头部刷新控件
     */
    self.tableView.mj_header =[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    /**
     *  设置进入该view就开始刷新
     */
    [self.tableView.mj_header beginRefreshing];
    /**
     *  设置自动改变header的透明度
     */
    [self.tableView.mj_header setAutomaticallyChangeAlpha:YES];
    /**
     *  添加上拉刷新控件
     */
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    /**
     *  注册nib
     */
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([QCTopicCell class]) bundle:nil] forCellReuseIdentifier:topicCellId];
    
    [QCTopic mj_replacedKeyFromPropertyName];
}

/**
 *  加载新的数据
 */
- (void )refreshData {
    // 先将topics数组置空，在执行相应的操作
    self.topics = nil;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.topics = [QCTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];
}
/**
 *  加载更多的数据
 */
- (void) loadMoreData {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.moreTopics = [QCTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        [self.topics addObjectsFromArray:self.moreTopics];
        [self.tableView reloadData];
        
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_footer endRefreshing];
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
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QCTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:topicCellId forIndexPath:indexPath];
    cell.topic = self.topics[indexPath.row];
    
    return cell;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    QCTopic *topic = self.topics[indexPath.row];
    return topic.cellHeight;
}
@end
