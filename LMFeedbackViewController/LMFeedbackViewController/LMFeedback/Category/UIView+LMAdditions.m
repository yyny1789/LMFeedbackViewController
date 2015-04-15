//
//  UIView+LMAdditions.m
//  LMFeedbackViewController
//
//  Created by Yangyang on 15/4/15.
//  Copyright (c) 2015年 itbox. All rights reserved.
//

#import "UIView+LMAdditions.h"

@implementation UIView (LMAdditions)
- (void)addBorderWithColor:(UIColor *)color width:(float)width radius:(float)radius{
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}
@end
