//
//  QCTopic.h
//  QCTabbarController
//
//  Created by 程庆春 on 16/4/1.
//  Copyright © 2016年 QC Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QCTopic : NSObject
/**
 * 用户头像
 */
@property (nonatomic, strong) NSString *profile_image;
/**
 *  帖子的内容
 */
@property (strong, nonatomic) NSString* text;



@end
