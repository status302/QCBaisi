//
//  QCTopicCell.h
//  QCTabbarController
//
//  Created by 程庆春 on 16/4/1.
//  Copyright © 2016年 QC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QCTopic;
@interface QCTopicCell : UITableViewCell
/**
 *  topic
 */
@property (strong, nonatomic) QCTopic *topic;
@end
