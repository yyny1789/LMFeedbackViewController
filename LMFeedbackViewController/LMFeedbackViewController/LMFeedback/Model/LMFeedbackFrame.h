//
//  LMFeedbackFrame.h
//  LMFeedbackViewController
//
//  Created by Yangyang on 15/4/15.
//  Copyright (c) 2015年 itbox. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LMFeedback;
// 正文的字体
#define LMTextFont [UIFont systemFontOfSize:14]

// 正文的内边距
#define LMTextPadding 20


@interface LMFeedbackFrame : NSObject

/**
 *  头像的frame
 */
@property (nonatomic, assign, readonly) CGRect iconF;
/**
 *  正文的frame
 */
@property (nonatomic, assign, readonly) CGRect textF;
/**
 *  cell的高度
 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;

@property(nonatomic, strong)LMFeedback *feedback;
@end
