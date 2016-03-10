//
//  UIBarButtonItem+QC.h
//  QCTabbarController
//
//  Created by 程庆春 on 16/3/10.
//  Copyright © 2016年 QC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (QC)
+(instancetype) itemWithImage: (NSString *)imageName highlightedImage: (NSString *)highlightedImageName target:(id)target action:(SEL)action;
@end
