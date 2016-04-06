//
//  QCTopicPictureView.h
//  QCTabbarController
//
//  Created by 程庆春 on 16/4/6.
//  Copyright © 2016年 QC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QCTopic;
@interface QCTopicPictureView : UIView

+ (instancetype)pictureView;

@property (strong, nonatomic) QCTopic *topic;
@end
