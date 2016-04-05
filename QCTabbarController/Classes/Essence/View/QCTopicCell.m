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
    /**
     * 给cell添加背景图片
     */
    UIImageView *backImageView = [[UIImageView alloc]init];
    backImageView.image = [UIImage imageNamed:@"mainCellBackground"];
    [self setBackgroundView:backImageView];
    
    
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
    
    [self.dingButton setTitle:[self changeTitleWithCount:_topic.ding] forState:UIControlStateNormal];
    [self.caiButton setTitle:[self changeTitleWithCount:_topic.cai] forState:UIControlStateNormal];
    [self.shareButton setTitle:[self changeTitleWithCount:_topic.repost] forState:UIControlStateNormal];
    [self.commentButton setTitle:[self changeTitleWithCount:_topic.comment] forState:UIControlStateNormal];
    
}

/**
 *  处理cell涉及到的数字
 *
 */
- (NSString *) changeTitleWithCount:(NSInteger)count{

    NSString *result = [NSString string];
    if (count > 10000) {
        result = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    } else {
       result = [NSString stringWithFormat:@"%zd", count];
    }
    return result;
}

- (IBAction)dingbuttonClicked:(id)sender {
}
- (IBAction)caiButtonClicked:(id)sender {
}
@end
