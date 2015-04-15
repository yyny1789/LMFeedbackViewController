//
//  MBProgressHUD+MJ.h
//  appDemo2.0
//
//  Created by Yangyang on 14/12/1.
//  Copyright (c) 2014年 9fbank. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (MJ)
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;


+ (void)showSuccess:(NSString *)success;
//+ (void)showError:(NSString *)error;

+ (MBProgressHUD *)showMessage:(NSString *)message;

+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;

+ (void)showError:(NSString *)error toView:(UIView *)view time:(CGFloat)time;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view time:(CGFloat)time;

+ (void)showSuccess:(NSString *)success time:(CGFloat)time;

+ (void)showError:(NSString *)error time:(CGFloat)time;
+ (void)showError:(NSString *)error;
@end
