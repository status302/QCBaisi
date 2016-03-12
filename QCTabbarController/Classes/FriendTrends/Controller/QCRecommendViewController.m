//
//  QCRecommendViewController.m
//  QCTabbarController
//
//  Created by 程庆春 on 16/3/10.
//  Copyright © 2016年 QC Inc. All rights reserved.
//

#import <SVProgressHUD/SVProgressHUD.h>
#import <AFNetworking/AFNetworking.h>
#import "QCRecommendViewController.h"
#import "QCRecommendCategoryCell.h"
#import "QCRecommendCategory.h"
#import "QCRecommendUserCell.h"
#import "QCRecommendUser.h"
#import "MJExtension.h"
#import "MJRefresh.h"

#define recommendCategory self.categories[_categoryView.indexPathForSelectedRow.row]

@interface QCRecommendViewController () <UITableViewDataSource, UITableViewDelegate>
// 左边的数据
@property (strong, nonatomic) NSMutableArray *categories;
//@property (strong, nonatomic) NSMutableArray* users;
@property (weak, nonatomic) IBOutlet UITableView *userView;

@property (strong, nonatomic) AFHTTPSessionManager *manager;

@property (strong, nonatomic) NSMutableDictionary *params;

@end

@implementation QCRecommendViewController

/**
 *  这里注意下objc下常量的写法
 */
static NSString * const QCCategoryCell = @"QCCategoryCell";
static NSString * const QCUserCell = @"userCell";

// 懒加载manager数据、、、、所有的请求都归它来管理
- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化view
    [self setupView];
    // 加载category里的数据
    [self loadCategories];
    [self loadRefreshView];
}

- (void) loadRefreshView {
    self.userView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];

    self.userView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    self.userView.mj_footer.hidden = NO;
}

-(void) loadNewUsers {
    // 在这里刷新数据，也就是说要重新获取第一页的数据
    QCRecommendCategory *c = recommendCategory;
    c.currentPage = 1;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(c.id);
    params[@"page"] = @(c.currentPage);
    self.params = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
         // block 里的params 是上次的params，这是block的特征之一，调用外部变量时。
        if (self.params != params) return ;
        // 先清除users所有的数据，刷新只要新的数据
        [c.users removeAllObjects];
        // 处理获得成功的responseObject
        
        c.total = [responseObject[@"total"]integerValue];
        
        NSArray *array = [QCRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [c.users addObjectsFromArray:array];
        
        [self.userView reloadData];
        
        
        [self.userView.mj_header endRefreshing];
        
        [self checkFootState];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) {
            return ;
        }
        [SVProgressHUD showErrorWithStatus:@"数据加载失败~"];
        [self.userView.mj_header endRefreshing];
    }];
    
    
}

- (void) loadMoreUsers {
    NSLog(@"load more users");
    // 底部加载更多数据
    QCRecommendCategory *category = recommendCategory;
    // 刷新表格：为了切换的时候马上显示当前userView的数据
    [self.userView reloadData];
    // 处理categoryTableView 的点击情况
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(category.id);
    
    self.params = params;
    params[@"page"] = @(++category.currentPage);
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.params != params) {
            return ;
        }
        NSArray *array = [QCRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [category.users addObjectsFromArray:array];
        
        [self.userView reloadData];
        //检查foot的状态
        [self checkFootState];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) {
            return ;
        }
        [SVProgressHUD showErrorWithStatus:@"数据加载失败~"];
        [self.userView.mj_footer endRefreshing];
    }];
}

- (void) checkFootState {
    QCRecommendCategory *category = recommendCategory;
    // 实时改变Foot的状态
    self.userView.mj_footer.hidden = (category.users.count == 0); // 根据users的数目来确定userView.footer Refresh是否显示
    
    if (category.users.count == category.total) {
        [self.userView.mj_footer endRefreshingWithNoMoreData];
    } else {
        [self.userView.mj_footer endRefreshing];
    }
}
- (void) loadCategories {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    // 菊花显示
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];

    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
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
        // 进入这个界面就显示相关的第一行的users
        [self.userView.mj_header beginRefreshing];
        
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
    if (tableView == _categoryView) return self.categories.count;

    [self checkFootState];
    return [recommendCategory users].count;
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
        QCRecommendCategory *c = self.categories[self.categoryView.indexPathForSelectedRow.row];
        cell.user = c.users[indexPath.row];
        return cell;
    }
}

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QCRecommendCategory *c = recommendCategory;
    
    //避免点击这个category的时候，其他category还在刷新ing
    [self.userView.mj_header endRefreshing];
    [self.userView.mj_footer endRefreshing];
    if (c.users.count) {
        [self.userView reloadData];
    } else {
        // 刷新表格：为了切换的时候马上显示当前userView的数据
        [self.userView reloadData];
        // 处理categoryTableView 的点击情况
        
        [self.userView.mj_header beginRefreshing];
    }
}
#pragma mark - 控制器的销毁
- (void)dealloc {
    // 停止所有的请求操作
    [self.manager.operationQueue cancelAllOperations];
}

@end
