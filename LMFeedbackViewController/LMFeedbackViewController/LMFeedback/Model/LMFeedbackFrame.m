//
//  LMFeedbackFrame.m
//  LMFeedbackViewController
//
//  Created by Yangyang on 15/4/15.
//  Copyright (c) 2015年 itbox. All rights reserved.
//

#import "LMFeedbackFrame.h"
#import "LMFeedback.h"
#import "NSString+LMAdditions.h"
@implementation LMFeedbackFrame
- (void)setFeedback:(LMFeedback *)feedback {
    _feedback = feedback;
    
    // 间距
    CGFloat padding = 15;
    
    // 1.头像
    CGFloat iconY = 15;
    CGFloat iconW = 40;
    CGFloat iconH = 40;
    CGFloat iconX;
    if (feedback.type == LMFeedbackTypeServer) {// 客服
        iconX = padding;
    } else { // 自己的发的
        iconX = [UIScreen mainScreen].bounds.size.width - padding - iconW;
    }
    _iconF = CGRectMake(iconX, iconY, iconW, iconH);
    
    // 2.正文
    CGFloat textY = iconY;
    // 文字计算的最大尺寸
    CGSize textMaxSize = CGSizeMake(200, MAXFLOAT);
    // 文字计算出来的真实尺寸(按钮内部label的尺寸)
    CGSize textRealSize = [feedback.text sizeWithFont:LMTextFont maxSize:textMaxSize];
    // 按钮最终的真实尺寸
    CGSize textBtnSize = CGSizeMake(textRealSize.width + LMTextPadding * 2, textRealSize.height + LMTextPadding * 2);
    CGFloat textX;
    if (feedback.type == LMFeedbackTypeServer) {// 客服
        textX = CGRectGetMaxX(_iconF) + 8;
    } else {// 自己的发的
        textX = iconX - 8 - textBtnSize.width;
    }

    _textF = (CGRect){{textX, textY}, textBtnSize};
    
    // 3.cell的高度
    CGFloat textMaxY = CGRectGetMaxY(_textF);
    CGFloat iconMaxY = CGRectGetMaxY(_iconF);
    _cellHeight = MAX(textMaxY, iconMaxY) + padding;
}
@end
