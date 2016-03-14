//
//  QCLoginRegisterViewController.m
//  QCTabbarController
//
//  Created by 程庆春 on 16/3/12.
//  Copyright © 2016年 QC Inc. All rights reserved.
//

#import "QCLoginRegisterViewController.h"

@interface QCLoginRegisterViewController ()
- (IBAction)closeButtonClicked;
- (IBAction)loginRegister:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeading;
@property (weak, nonatomic) IBOutlet UIButton *loginRegiterButtonClicked;

@end

@implementation QCLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //这是其中一种可以修改placeHolder内字体属性的方法。
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
//    attrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
//    
//    NSAttributedString *attrPlaceHolder = [[NSAttributedString alloc] initWithString:@"手机号" attributes:attrs];
//    
//    _phoneNumberTextField.attributedPlaceholder = [[NSAttributedString alloc]initWithAttributedString:attrPlaceHolder];
}

/**
 *  改变状态栏的style
 */

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (IBAction)closeButtonClicked {

    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)loginRegister:(id)sender {
    if (self.loginViewLeading.constant == 0) { // 切换到注册框
        
        [self.view endEditing:YES];
        
        [self.loginRegiterButtonClicked setTitle:@"已有账号?" forState:UIControlStateNormal];
        self.loginViewLeading.constant = - self.view.width;
    } else { // 切换到登录框
        [self.loginRegiterButtonClicked setTitle:@"点击注册" forState:UIControlStateNormal];
        self.loginViewLeading.constant = 0;
    }
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}
@end
