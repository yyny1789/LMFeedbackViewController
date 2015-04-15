//
//  LMContactWayViewController.m
//  LMFeedbackViewController
//
//  Created by Yangyang on 15/4/15.
//  Copyright (c) 2015年 itbox. All rights reserved.
//

#import "LMContactWayViewController.h"
#import "LMContactField.h"
#import "NSString+LMAdditions.h"
#import "MBProgressHUD+LM.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define LMScreenW [UIScreen mainScreen].bounds.size.width
#define LMScreenH [UIScreen mainScreen].bounds.size.height

#define kNavigationBarH 64

@interface LMContactWayViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) LMContactField *textField;
@end

@implementation LMContactWayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"填写联系方式";
    self.view.backgroundColor = UIColorFromRGB(0xefeff4);
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.exclusiveTouch = YES;
    button.frame = CGRectMake(0, kNavigationBarH, 44, 44) ;
    [button setTitle:@"完成" forState:UIControlStateNormal];
    [button setTitleColor:UIColorFromRGB(0x000000) forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightBarButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.textField = [[LMContactField alloc] init];
    self.textField.frame = CGRectMake(10, 15 + kNavigationBarH, LMScreenW - 20, 44);
    self.textField.placeholder = @"QQ、邮件或电话";
    [self.view addSubview:self.textField];
    self.textField.backgroundColor = [UIColor whiteColor];
    [self.textField setReturnKeyType:UIReturnKeyDone];
    self.textField.delegate = self;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(10, CGRectGetMaxY(self.textField.frame) + 10, LMScreenW, 12);
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont systemFontOfSize:11];
    titleLabel.textColor = UIColorFromRGB(0x000000);
    titleLabel.text = @"您的联系方式有助于我们沟通和解决问题，仅客服人员可见";
    [self.view addSubview:titleLabel];
}

- (void)rightBarButtonClick {
    [self.view endEditing:YES];
    
    if (self.textField.text.length == 0) {
        [MBProgressHUD showError:@"请填写联系方式嘛，么么哒"];
    }else if ([self.textField.text isEmail] || [self.textField.text isQQNumber] || [self.textField.text isTelephone]){
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MFContactWay" object:self.textField.text];
        
        [MBProgressHUD showSuccess:@"提交成功" time:1.3f];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
            
        });
    }else{
        [MBProgressHUD showError:@"请正确填写呢，亲~"];
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
