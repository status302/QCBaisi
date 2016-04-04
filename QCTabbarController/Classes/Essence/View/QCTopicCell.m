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
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
- (IBAction)dingbuttonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
- (IBAction)caiButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;

@property (weak, nonatomic) IBOutlet UIImageView *profile_image_view;
@property (weak, nonatomic) IBOutlet UILabel *screen_name_label;
@property (weak, nonatomic) IBOutlet UILabel *passtime_label;

@end

@implementation QCTopicCell

- (void)awakeFromNib {

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)setTopic:(QCTopic *)topic {
    _topic = topic;
    
    
    [self.profile_image_view sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:_topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] options:SDWebImageContinueInBackground progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    [self.screen_name_label setText:_topic.screen_name];
    [self.passtime_label setText:_topic.passtime];
    [self.dingButton setTitle:_topic.ding forState:UIControlStateNormal];
    [self.caiButton setTitle:_topic.cai forState:UIControlStateNormal];
    [self.shareButton setTitle:_topic.repost forState:UIControlStateNormal];
    [self.commentButton setTitle:_topic.comment forState:UIControlStateNormal];
}


- (IBAction)dingbuttonClicked:(id)sender {
}
- (IBAction)caiButtonClicked:(id)sender {
}
@end
