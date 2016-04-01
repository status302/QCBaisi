//
//  QCTopicCell.m
//  QCTabbarController
//
//  Created by 程庆春 on 16/4/1.
//  Copyright © 2016年 QC Inc. All rights reserved.
//

#import "QCTopicCell.h"
#import "QCTopic.h"
#import <UIImageView+WebCache.h>

@interface QCTopicCell()


@end

@implementation QCTopicCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)setTopic:(QCTopic *)topic {
    _topic = topic;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:_topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    self.textLabel.text = _topic.text;
}


@end
