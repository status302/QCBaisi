//
//  NSDate+QC.m
//  QCTabbarController
//
//  Created by 程庆春 on 16/4/4.
//  Copyright © 2016年 QC Inc. All rights reserved.
//

#import "NSDate+QC.h"

@implementation NSDate (QC)

- (NSDateComponents *)deltaFrom:(NSDate *)from {
    NSCalendar *curCalendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    return [curCalendar components: unit fromDate:from];
}

- (BOOL)isThisYear {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    
    return nowYear == selfYear;
    
}
- (BOOL)isToday {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *nowStr = [formatter stringFromDate:[NSDate date]];
    NSString *selfStr = [formatter stringFromDate:self];
    
    return [nowStr isEqualToString:selfStr];
    
}
- (BOOL)isYesterday {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSDate *nowDate = [formatter dateFromString:[formatter stringFromDate:[NSDate date]]];
    NSDate *selfDate = [formatter dateFromString:[formatter stringFromDate:self]];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    
    return comps.year == 0 && comps.month == 0 && comps.day == 1;
    

}
@end
