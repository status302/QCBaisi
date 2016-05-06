//
//  QCTopicPictureView.m
//  QCTabbarController
//
//  Created by 程庆春 on 16/4/6.
//  Copyright © 2016年 QC Inc. All rights reserved.
//

#import "QCTopicPictureView.h"
#import "QCTopic.h"
#import "QCShowPictureViewController.h"
#import <UIImageView+WebCache.h>
#import "QCProgressView.h"

@interface QCTopicPictureView()

@property (weak, nonatomic) IBOutlet UIImageView *pictureImageView;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigPictureButton;

@property (weak, nonatomic) IBOutlet QCProgressView *progressView;

@end
@implementation QCTopicPictureView

+(instancetype)pictureView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

- (void)awakeFromNib {
    _pictureImageView.backgroundColor = [UIColor colorWithWhite:0.6 alpha:1.0];
    
    self.autoresizingMask = UIViewAutoresizingNone;
    
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigPicture)];
    [self.pictureImageView addGestureRecognizer:tapGesture];
}
- (void) showBigPicture {
    QCShowPictureViewController *showBigPictureVC = [[QCShowPictureViewController alloc]init];
    showBigPictureVC.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showBigPictureVC animated:YES completion:^{
//        showBigPictureVC.topic = self.topic;
    }];
    
    
}
- (void)setTopic:(QCTopic *)topic {
    _topic = topic;
    
    [self.progressView setProgress:_topic.currentProgress animated:NO];
    
    NSURL *imageURL = [NSURL URLWithString:_topic.small_image];
    [self.pictureImageView sd_setImageWithPreviousCachedImageWithURL:imageURL placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        self.progressView.hidden = NO;
        _topic.currentProgress = 1.0 * receivedSize / expectedSize;
        [self.progressView setProgress:_topic.currentProgress animated:NO];
        
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
    /**
     *  判断该图片是否为gif图片
     */
    if (!_topic.is_gif) {
        [self.gifView setHidden:YES];
    } else {
        [self.gifView setHidden:NO];
    }
    
    /**
     *  判断该图片是否为长图
     */
    if ([_topic isBigPicture]) { // 是大图
        self.seeBigPictureButton.hidden = NO;
        self.pictureImageView.contentMode = UIViewContentModeScaleAspectFill;
        
    } else { // 不是大图
        self.seeBigPictureButton.hidden = YES;
        self.pictureImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
}
/**
 *  在这里显示大图
 */
- (void)seePictureClicked:(id)sender {
    
}
@end
