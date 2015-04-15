//
//  LMFeedbackCell.m
//  LMFeedbackViewController
//
//  Created by Yangyang on 15/4/15.
//  Copyright (c) 2015年 itbox. All rights reserved.
//

#import "LMFeedbackCell.h"
#import "LMFeedback.h"
#import "LMFeedbackFrame.h"
#import "UIImage+LMAdditions.h"

@interface LMFeedbackCell ()
/**
 *  头像
 */
@property (nonatomic, strong) UIImageView *iconView;
/**
 *  正文
 */
@property (nonatomic, strong) UIButton *textView;
@end

@implementation LMFeedbackCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"feedback";
    LMFeedbackCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[LMFeedbackCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 设置cell的背景色
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 1.头像
        self.iconView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.iconView];
        
        // 2.正文
        self.textView = [[UIButton alloc] init];
        self.textView.titleLabel.numberOfLines = 0; // 自动换行
        self.textView.titleLabel.font = LMTextFont;
        self.textView.contentEdgeInsets = UIEdgeInsetsMake(LMTextPadding, LMTextPadding, LMTextPadding, LMTextPadding);
        [self.textView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.contentView addSubview:self.textView];
        self.textView.adjustsImageWhenHighlighted = NO;
        
    }
    return self;
}

- (void)setFeedbackFrame:(LMFeedbackFrame *)feedbackFrame {
    _feedbackFrame = feedbackFrame;
    
    LMFeedback *feedBack = feedbackFrame.feedback;
    
    // 1.头像
    NSString *icon = (feedBack.type == LMFeedbackTypeServer) ? @"mine_contact_sever" : @"mine_contact_user";
    self.iconView.image = [UIImage imageNamed:icon];
    self.iconView.frame = feedbackFrame.iconF;
    
    // 2.正文
    [self.textView setTitle:feedBack.text forState:UIControlStateNormal];
    self.textView.frame = feedbackFrame.textF;
    
    // 3.正文的背景
    if (feedBack.type == LMFeedbackTypeUser) { // 用户发的,蓝色
        [self.textView setBackgroundImage:[UIImage resizedImageWithName:@"feed_user_nor"] forState:UIControlStateNormal];
    } else { // 客服发的,白色
        [self.textView setBackgroundImage:[UIImage resizedImageWithName:@"feed_sever_nor"] forState:UIControlStateNormal];
    }
    
}
@end
