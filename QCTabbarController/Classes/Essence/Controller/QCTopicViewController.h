//
//  QCTopicViewController.h
//  QCTabbarController
//
//  Created by 程庆春 on 16/4/5.
//  Copyright © 2016年 QC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QCTopicViewController : UITableViewController



typedef enum {
    QCTopicTypeAll = 1,
    QCTopicTypePicture = 10,
    QCTopicTypeWord = 29,
    QCTopicTypeRecord = 31,
    QCTopicTypeVedio = 41
}QCTopicType;

@property (nonatomic, assign) QCTopicType type;


@end
