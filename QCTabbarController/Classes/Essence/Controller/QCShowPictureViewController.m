//
//  QCShowPictureViewController.m
//  QCTabbarController
//
//  Created by 程庆春 on 16/4/16.
//  Copyright © 2016年 QC Inc. All rights reserved.
//

#import "QCShowPictureViewController.h"
#import "QCTopic.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>

@interface QCShowPictureViewController ()
- (IBAction)back:(id)sender;
@property (weak, nonatomic) UIImageView *imageView;
- (IBAction)save:(id)sender;

@end

@implementation QCShowPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc]init];
    [self.scrollView addSubview:imageView];
    imageView.userInteractionEnabled = YES;
    
    self.imageView = imageView;
    CGFloat imageW = [UIScreen mainScreen].bounds.size.width;
    CGFloat imageH = imageW * self.topic.height / self.topic.width;
    if (imageH > [UIScreen mainScreen].bounds.size.height) {
        _scrollView.contentSize = CGSizeMake(0, imageH);
        imageView.frame = CGRectMake(0, 0, imageW, imageH);
    } else {
        imageView.size = CGSizeMake(imageW, imageH);
        imageView.centerY = [UIScreen mainScreen].bounds.size.height * 0.5;
    }
    
    NSURL *url = [NSURL URLWithString:_topic.large_image];
    [imageView sd_setImageWithURL:url];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back:)];
    [self.imageView addGestureRecognizer:tapGesture];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)save:(id)sender {
    
    if (!_imageView.image) {
        [SVProgressHUD showErrorWithStatus:@"图片未下载"];
        return;
    }
    UIImageWriteToSavedPhotosAlbum(_imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (!error) {
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    } else {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }
}
@end
