//
//  LMFeedback.h
//  LMFeedbackViewController
//
//  Created by Yangyang on 15/4/15.
//  Copyright (c) 2015年 itbox. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,LMFeedbackType) {
    LMFeedbackTypeServer = 0, // 客服人员
    LMFeedbackTypeUser = 1,  // 用户
};

@interface LMFeedback : NSObject
/**
 *  聊天内容
 */
@property (nonatomic, copy) NSString *text;
/**
 *  信息的类型
 */
@property (nonatomic, assign) LMFeedbackType type;
@end
