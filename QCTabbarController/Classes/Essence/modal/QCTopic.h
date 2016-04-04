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
@property (nonatomic, copy) NSString *profile_image;
/**
 *  帖子的内容
 */
@property (strong, nonatomic) NSString* text;
/**
 *  踩的人数
 */
@property (nonatomic, copy) NSString *cai;
/**
 *  顶的数目
 */
@property (nonatomic, copy)  NSString *ding;
/**
 *  评论的数目
 */
@property (copy, nonatomic) NSString* comment;
/**
 *  分享的数目
 */
@property (copy, nonatomic) NSString* repost;
/**
 *  昵称
 */
@property (copy, nonatomic) NSString* screen_name;
/**
 *  发帖子的时间
 */
@property (copy, nonatomic) NSString* passtime;

@end
