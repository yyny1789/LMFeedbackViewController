//
//  LMFeedbackField.m
//  LMFeedbackViewController
//
//  Created by Yangyang on 15/4/15.
//  Copyright (c) 2015年 itbox. All rights reserved.
//

#import "LMFeedbackField.h"
#import "UIView+LMAdditions.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation LMFeedbackField
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if((self = [super initWithCoder:aDecoder])) {
        [self setup];
    }
    return self;
}

- (void)setup {
    [self addBorderWithColor:UIColorFromRGB(0xcccccc) width:0.5 radius:3];
}

// 控制placeHolder的位置，左右缩20
- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    CGRect inset = CGRectMake(bounds.origin.x + 10, bounds.origin.y + 11, bounds.size.width -10, bounds.size.height);
    return inset;
}

// 控制显示文本的位置
- (CGRect)textRectForBounds:(CGRect)bounds {
    CGRect inset = CGRectMake(bounds.origin.x + 10, bounds.origin.y, bounds.size.width - 15, bounds.size.height);
    
    return inset;
}

// 控制编辑文本的位置
- (CGRect)editingRectForBounds:(CGRect)bounds {
    CGRect inset = CGRectMake(bounds.origin.x + 10, bounds.origin.y, bounds.size.width - 15, bounds.size.height);
    return inset;
}

- (void)drawPlaceholderInRect:(CGRect)rect {
    [self.placeholder drawInRect:rect withAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14],NSFontAttributeName,UIColorFromRGB(0x808080),NSForegroundColorAttributeName, nil]];
}
@end
