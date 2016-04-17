//
//  QCShowPictureViewController.h
//  QCTabbarController
//
//  Created by 程庆春 on 16/4/16.
//  Copyright © 2016年 QC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@class QCTopic;
@interface QCShowPictureViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) QCTopic *topic;

@end
