//
//  QCTopicPictureView.m
//  QCTabbarController
//
//  Created by 程庆春 on 16/4/6.
//  Copyright © 2016年 QC Inc. All rights reserved.
//

#import "QCTopicPictureView.h"
#import "QCTopic.h"
#import <UIImageView+WebCache.h>

@interface QCTopicPictureView()

@property (weak, nonatomic) IBOutlet UIImageView *pictureImageView;
@property (weak, nonatomic) IBOutlet UIImageView *gitView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigPictureButton;
- (IBAction)seePictureClicked:(id)sender;

@end
@implementation QCTopicPictureView

+(instancetype)pictureView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

- (void)awakeFromNib {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(seePictureClicked:)];
    [self.pictureImageView addGestureRecognizer:tapGesture];
}

- (void)setTopic:(QCTopic *)topic {
    _topic = topic;
    
    NSURL *imageURL = [NSURL URLWithString:_topic.image0];
    [self.pictureImageView sd_setImageWithPreviousCachedImageWithURL:imageURL placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
}
/**
 *  在这里显示大图
 */
- (IBAction)seePictureClicked:(id)sender {
    
}
@end
