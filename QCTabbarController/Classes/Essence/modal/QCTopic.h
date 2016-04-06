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
@property (nonatomic, assign) NSInteger cai;
/**
 *  顶的数目
 */
@property (nonatomic, assign)  NSInteger ding;
/**
 *  评论的数目
 */
@property (assign, nonatomic) NSInteger comment;
/**
 *  分享的数目
 */
@property (assign, nonatomic) NSInteger repost;
/**
 *  昵称
 */
@property (copy, nonatomic) NSString* screen_name;
/**
 *  发帖子的时间
 */
@property (copy, nonatomic) NSString* passtime;
/**
 *  cell的高度
 */
@property (nonatomic, assign) CGFloat cellHeight;
/**
 *  图片的高度
 */
@property (nonatomic, assign) NSInteger height;
/**
 *  图片的宽度
 */
@property (nonatomic, assign) NSInteger width;
/**
 *  帖子的类型
 */
@property (nonatomic, assign) QCTopicType type;
/**
 * 小尺寸图片
 */
@property (copy, nonatomic) NSString *image0;
/**
 *  中尺寸图片
 */
@property (copy, nonatomic) NSString *image1;
/**
 *  大尺寸图片
 */
@property (copy, nonatomic) NSString *image2;

@end
