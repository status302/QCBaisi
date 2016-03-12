//
//  QCRecommendTag.h
//  QCTabbarController
//
//  Created by 程庆春 on 16/3/12.
//  Copyright © 2016年 QC Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QCRecommendTag : NSObject

/**
 *  标签名称
 */
@property (copy, nonatomic) NSString *theme_name;
/**
 *  推荐标签的图片url地址
 */
@property (copy, nonatomic) NSString *image_list;
/**
 *  此标签的订阅量
 */
@property (nonatomic, assign) NSUInteger sub_number;


@end
