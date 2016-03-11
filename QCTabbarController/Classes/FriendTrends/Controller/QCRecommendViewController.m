//
//  QCRecommendViewController.m
//  QCTabbarController
//
//  Created by 程庆春 on 16/3/10.
//  Copyright © 2016年 QC Inc. All rights reserved.
//

#import "QCRecommendViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <AFNetworking/AFNetworking.h>
#import "QCRecommendCategory.h"
#import "QCRecommendCategoryCell.h"
#import "QCRecommendUserCell.h"
#import "QCRecommendUser.h"
#import "MJExtension.h"

@interface QCRecommendViewController () <UITableViewDataSource, UITableViewDelegate>
// 左边的数据
@property (strong, nonatomic) NSMutableArray *categories;
@property (strong, nonatomic) NSMutableArray* users;
@property (weak, nonatomic) IBOutlet UITableView *userView;

@end

@implementation QCRecommendViewController

/**
 *  这里注意下objc下常量的写法
 */
static NSString * const QCCategoryCell = @"QCCategoryCell";
static NSString * const QCUserCell = @"userCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化view
    [self setupView];
    
//    _categories = [NSMutableArray array];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    // 菊花显示
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
    
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        // when the request is success
//        NSLog(@"%@", responseObject[@"list"]);
        
        /**
         *  在这里自己处理所得出的数据，而不用MJExtension
         */
/*
        // 下面注释里的是自己封装的模型，-----不过没有起到效果----- ！！！现在起作用了! ! !
        for (NSDictionary *dict in responseObject[@"list"]) {
            QCRecommendCategory *category = [[QCRecommendCategory alloc]init];
            category.name = dict[@"name"];
     
            // 调试所用
//            NSLog(@"category name is :%@",category.name);
            category.id = (int)dict[@"id"];
            NSLog(@"id 为：%d", category.id);
            category.count = (int)dict[@"count"];
            
            // 调试所用
//            NSLog(@"the count is %zd", category.count);
            
            [_categories addObject:category];
            // 这行代码在这里是没有执行的显示的结果为 ——categories的count一直为0; 而想要执行这行代码必须在前面初始化——categories。

        } */
        // 调试的时候用的，现在注释掉
//        NSLog(@"categories count is : %zd", _categories.count);
        /**
         *  想要的数据是：responseObject[@"list"]
         */
        self.categories = [QCRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        
        [self.categoryView reloadData];
        [self.categoryView selectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        // when the request is failure
        [SVProgressHUD showErrorWithStatus:@"加载失败~~"];
    }];
}


- (void) setupView {
    
    self.title = @"推荐关注";
    // 设置该控制器的背景颜色
    self.view.backgroundColor = [UIColor grayColor];
    /**
     *  注册CategoryView
     *  NSStringFromClass: 将类名装换成NSString类型的数据
     */
    [self.categoryView registerNib:[UINib nibWithNibName:NSStringFromClass([QCRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:QCCategoryCell];
    /**
     *   注册UserView
     */
    [self.userView registerNib:[UINib nibWithNibName:NSStringFromClass([QCRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:QCUserCell];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
    self.userView.rowHeight = 70;
}

#pragma mark - UITableView Datasource
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _categoryView) {
        return self.categories.count;
    } else {
        return self.users.count;
    }
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (tableView == _categoryView) {
        QCRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:QCCategoryCell];
        cell.category = self.categories[indexPath.row];
        return cell;
    } else {
        QCRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:QCUserCell];
        cell.user = self.users[indexPath.row];
        return cell;
    }
}

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _categoryView) {
        // 处理categoryTableView 的点击情况
        
        QCRecommendCategory *c = self.categories[indexPath.row];
        
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        
        params[@"a"] = @"list";
        params[@"c"] = @"subscribe";
        params[@"category_id"] = @(c.id);
        [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [SVProgressHUD dismiss];
            // 处理获得成功的responseObject
            //        NSLog(@"%@", responseObject[@"list"]);
            
            self.users = [QCRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            
            [self.userView reloadData];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [SVProgressHUD showErrorWithStatus:@"加载失败~"];
        }];

    } else {
        // 处理userTableView的点击情况
        
        
    }
}

@end
