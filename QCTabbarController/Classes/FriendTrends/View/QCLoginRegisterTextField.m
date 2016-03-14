//
//  QCLoginRegisterTextField.m
//  QCTabbarController
//
//  Created by 程庆春 on 16/3/14.
//  Copyright © 2016年 QC Inc. All rights reserved.
//

#import "QCLoginRegisterTextField.h"
#import <objc/runtime.h>

@implementation QCLoginRegisterTextField

+ (void)initialize {
    
//    // 利用runtime取出UITextField所有的成员变量的列表
//    unsigned int count = 0;
//    
//    Ivar *ivars = class_copyIvarList([UITextField class], &count);
//    
//    for (NSInteger i = 0; i< count; i++) {
//        Ivar ivar = *(ivars+i);
//        NSLog(@"-----------%s-----------", ivar_getName(ivar));
//    }
//    
//    free(ivars);
}
- (void)awakeFromNib {
    
    self.tintColor = [UIColor whiteColor];// 设置光标的颜色为白色
    
    [self resignFirstResponder];// 不成为第一响应者
}

- (BOOL)resignFirstResponder {
    [self setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    return [super resignFirstResponder];
}
- (BOOL)becomeFirstResponder {
    [self setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    return [super becomeFirstResponder];
}


@end
