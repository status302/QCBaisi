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
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)save:(id)sender;

@end

@implementation QCShowPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:_topic.large_image];
    [self.imageView sd_setImageWithURL:url];
    
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
