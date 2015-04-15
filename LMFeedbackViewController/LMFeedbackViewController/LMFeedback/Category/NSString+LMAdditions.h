//
//  NSString+LMAdditions.h
//  LMFeedbackViewController
//
//  Created by Yangyang on 15/4/15.
//  Copyright (c) 2015年 itbox. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LMAdditions)
/**
 *  返回字符串所占用的尺寸
 *
 *  @param font    字体
 *  @param maxSize 最大尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;


- (BOOL)isEmail;

- (BOOL)isTelephone;

- (BOOL)isQQNumber;

@end
