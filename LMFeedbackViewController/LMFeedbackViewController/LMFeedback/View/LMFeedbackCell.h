//
//  LMFeedbackCell.h
//  LMFeedbackViewController
//
//  Created by Yangyang on 15/4/15.
//  Copyright (c) 2015年 itbox. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LMFeedbackFrame;
@interface LMFeedbackCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) LMFeedbackFrame *feedbackFrame;
@end
