//
//  QCRecommendCategory.h
//  QCTabbarController
//
//  Created by 程庆春 on 16/3/10.
//  Copyright © 2016年 QC Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QCRecommendCategory : NSObject


/**
 *  name:
 */
@property (copy, nonatomic) NSString* name;
/**
 *  count:
 */
@property (nonatomic, assign) NSInteger count;
/**
 *  id:
 */
@property (nonatomic, assign) NSInteger id;

@property (strong, nonatomic) NSMutableArray *users;

@property (nonatomic, assign) NSInteger total;

@property (nonatomic, assign) NSInteger currentPage;




@end
