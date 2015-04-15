//
//  UIImage+LMAdditions.h
//  LMFeedbackViewController
//
//  Created by Yangyang on 15/4/15.
//  Copyright (c) 2015年 itbox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LMAdditions)
/**
 *  返回一张自由拉伸的图片
 *
 *  @param name 图片的名字
 *
 *  @return 图片
 */
+ (UIImage *)resizedImageWithName:(NSString *)name;

/**
 *  返回一张自由拉伸的图片
 *
 *  @param name 图片的名字
 *  @param left 图片距离左边拉伸的比例
 *  @param top  图片距离顶部拉伸的比例
 *
 *  @return 图片
 */
+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;
@end
