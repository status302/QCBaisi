//
//  QCConstant.h
//  QCTabbarController
//
//  Created by 程庆春 on 16/4/6.
//  Copyright © 2016年 QC Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QCConstant : NSObject

#define cellWidth [UIScreen mainScreen].bounds.size.width - 16.0

#define topicCellMargin 12.0
#define topicCellBottomHeight 44.0
#define topicCellTextY 56.0
#define topicCellMaxPictureHeight 800.0
#define topicCellPictureBreakHeight 250.0

typedef enum {
    QCTopicTypeAll = 1,
    QCTopicTypePicture = 10,
    QCTopicTypeWord = 29,
    QCTopicTypeRecord = 31,
    QCTopicTypeVedio = 41
}QCTopicType;

@end
