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
#import "MJExtension.h"

@interface QCRecommendViewController () <UITableViewDataSource, UITableViewDelegate>
// 左边的数据
@property (strong, nonatomic) NSMutableArray *categories;

@end

@implementation QCRecommendViewController

/**
 *  这里注意下objc下常量的写法
 */
static NSString * const QCCategoryCell = @"QCCategoryCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _categories = [NSMutableArray array];
    self.title = @"推荐关注";
    // 设置该控制器的背景颜色
    self.view.backgroundColor = [UIColor grayColor];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    /**
     *  注册CategoryView
     *  NSStringFromClass: 将类名装换成NSString类型的数据
     */
    [self.categoryView registerNib:[UINib nibWithNibName:NSStringFromClass([QCRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:QCCategoryCell];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
    
    // 菊花显示
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
    
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        // when the request is success
        NSLog(@"%@", responseObject[@"list"]);
        
        /**
         *  在这里自己处理所得出的数据，而不用MJExtension
         */

        // 下面注释里的是自己封装的模型，-----不过没有起到效果----- ！！！现在起作用了! ! !
        for (NSDictionary *dict in responseObject[@"list"]) {
            QCRecommendCategory *category = [[QCRecommendCategory alloc]init];
            category.name = dict[@"name"];
           
            // 调试所用
//            NSLog(@"category name is :%@",category.name);
            category.id = (NSInteger)dict[@"id"];
            category.count = (NSInteger)dict[@"count"];
            
            // 调试所用
//            NSLog(@"the count is %zd", category.count);
            
            [_categories addObject:category];
            // 这行代码在这里是没有执行的显示的结果为 ——categories的count一直为0; 而想要执行这行代码必须在前面初始化——categories。

        }
        // 调试的时候用的，现在注释掉
//        NSLog(@"categories count is : %zd", _categories.count);
        /**
         *  想要的数据是：responseObject[@"list"]
         */
//        self.categories = [QCRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.categoryView reloadData];

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        // when the request is failure
        [SVProgressHUD showErrorWithStatus:@"加载失败~~"];
    }];
}

#pragma mark - UITableView Datasource
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.categories.count;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QCRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:QCCategoryCell];
    cell.category = self.categories[indexPath.row];
    return cell;
    
}

#pragma mark - UITableView Delegate




@end
