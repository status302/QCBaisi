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
#import "QCTopicPictureView.h"

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
@property (weak, nonatomic) IBOutlet UILabel *mainTextLabel;

@property (weak, nonatomic) QCTopicPictureView *pictureView;
@property (weak, nonatomic) IBOutlet UIImageView *weiboV;

@end

@implementation QCTopicCell

- (QCTopicPictureView *)pictureView {
    if (!_pictureView) {
       QCTopicPictureView *pictureView = [QCTopicPictureView pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (void)awakeFromNib {
    /**
     * 给cell添加背景图片
     */
    [self.contentView setAutoresizingMask:UIViewAutoresizingNone];
    UIImageView *backImageView = [[UIImageView alloc]init];
    backImageView.image = [UIImage imageNamed:@"mainCellBackground"];
    [self setBackgroundView:backImageView];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setFrame:(CGRect)frame {
    
    frame.origin.x = 3.0;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 3.0;
    // 设置完了之后再调用父类的这个方法该方法才会生效
    [super setFrame:frame];
}

- (void)setTopic:(QCTopic *)topic {
    _topic = topic;
    
//    [self.profile_image_view sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:_topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] options:SDWebImageContinueInBackground progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//        
//    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        
//    }];
    [self.profile_image_view sd_setImageWithURL:[NSURL URLWithString:_topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    [self.screen_name_label setText:_topic.screen_name];
    [self.passtime_label setText:_topic.passtime];
    
    [self.dingButton setTitle:[self changeTitleWithCount:_topic.ding] forState:UIControlStateNormal];
    [self.caiButton setTitle:[self changeTitleWithCount:_topic.cai] forState:UIControlStateNormal];
    [self.shareButton setTitle:[self changeTitleWithCount:_topic.repost] forState:UIControlStateNormal];
    [self.commentButton setTitle:[self changeTitleWithCount:_topic.comment] forState:UIControlStateNormal];
    [self.mainTextLabel setText:_topic.text];
  
    /**
     *  判断该用户是否为新浪加V用户
     */
    if (!_topic.sina_v) { // 当是新浪V时
        [self.weiboV setHidden:YES];
    } else { // 不是新浪V时
        [self.weiboV setHidden:NO];
    }
    
    if (_topic.type == QCTopicTypePicture){
        self.pictureView.topic = self.topic;
        self.pictureView.frame = self.topic.imageFrame; // 设置显示图片的frame
    }
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
