//
//  UIView+LMAdditions.h
//  LMFeedbackViewController
//
//  Created by Yangyang on 15/4/15.
//  Copyright (c) 2015年 itbox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LMAdditions)

/**
 *  添加边框
 *
 *  @param color  边框颜色
 *  @param width  边框宽度
 *  @param radius 边框圆角
 */
- (void)addBorderWithColor:(UIColor *)color width:(float)width radius:(float)radius;
@end
