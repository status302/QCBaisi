//
//  NSDate+QC.h
//  QCTabbarController
//
//  Created by 程庆春 on 16/4/4.
//  Copyright © 2016年 QC Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (QC)

- (NSDateComponents *) deltaFrom:(NSDate* )from;
/**
 *  是否为今年
 */
- (BOOL) isThisYear;
/**
 *  是否为本月
 */
//- (BOOL) isThisMonth;
/**
 *  是否为今天
 */
- (BOOL) isToday;
/**
 *  是否为昨天
 */
- (BOOL) isYesterday;

@end
