//
//  LMFeedbackViewController.m
//  LMFeedbackViewController
//
//  Created by Yangyang on 15/4/15.
//  Copyright (c) 2015年 itbox. All rights reserved.
//

#import "LMFeedbackViewController.h"
#import "LMContactWayViewController.h"
#import "LMFeedbackFrame.h"
#import "LMFeedback.h"
#import "UMFeedback.h"
#import "LMFeedbackField.h"
#import "LMFeedbackCell.h"

#define LMScreenW [UIScreen mainScreen].bounds.size.width
#define LMScreenH [UIScreen mainScreen].bounds.size.height

#define kNavigationBarH 64

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

static UITapGestureRecognizer *tapRecognizer;

static const CGFloat bottomViewH = 50;
static const CGFloat dividerH = 0.5;

@interface LMFeedbackViewController ()<UITableViewDataSource,UITableViewDelegate,UMFeedbackDataDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *feedbackFrames;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) LMFeedbackField *feedbackField;

@property (nonatomic, strong) UMFeedback *feedback;

@property (nonatomic, assign) BOOL shouldScrollToBottom;

@property (nonatomic, strong) NSTimer *timer;
@end

@implementation LMFeedbackViewController
- (NSMutableArray *)feedbackFrames {
    if (!_feedbackFrames) {
        _feedbackFrames = [NSMutableArray array];
    }
    return _feedbackFrames;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.timer invalidate];
    self.timer = nil;
    [self.feedback stopRecordAndPlayback];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    self.view.backgroundColor = UIColorFromRGB(0xefeff4);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(postUserInfo:) name:@"MFContactWay" object:nil];
    
    // 1.监听键盘的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAnywhere:)];
    
    // 初始化tableview
    [self setupTableView];
    
    // 初始化联系方式
    [self setupContactWay];
    
    // 初始化BottomView
    [self setupBottomView];
    
    // 友盟获取数据
    self.feedback = [UMFeedback sharedInstance];
    self.feedback.delegate = self;
    
    self.shouldScrollToBottom = YES;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(getDatas) userInfo:nil repeats:YES];
    [self.timer fire];
  
}

- (void)setupBottomView{
    
    self.bottomView = [[UIView alloc] init];
    self.bottomView.frame = CGRectMake(0, LMScreenH - bottomViewH, LMScreenW, bottomViewH);
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bottomView];
    
    
    UIView *topDivider = [[UIView alloc] init];
    topDivider.backgroundColor = UIColorFromRGB(0xcccccc);
    [self.bottomView addSubview:topDivider];
    topDivider.frame = CGRectMake(0, 0, LMScreenW, dividerH);
    
    self.feedbackField = [[LMFeedbackField alloc] init];
    self.feedbackField.frame = CGRectMake(12, 7, 228, 36);
    self.feedbackField.placeholder = @"意见反馈";
    [self.bottomView addSubview:self.feedbackField];
    self.feedbackField.delegate = (id<UITextFieldDelegate>)self;
    self.feedbackField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.feedbackField.textAlignment = NSTextAlignmentLeft;
    self.feedbackField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    UIButton *sendBtn = [[UIButton alloc] init];
    sendBtn.frame = CGRectMake(250, 0, 60, bottomViewH);
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [sendBtn setTitleColor:UIColorFromRGB(0x000000) forState:UIControlStateNormal];
    sendBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [sendBtn addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:sendBtn];
}

- (void)setupContactWay{
    CGFloat contactWayBtnH = 44;
    
    UIView *contactView = [[UIView alloc] init];
    contactView.frame = CGRectMake(0, kNavigationBarH, LMScreenW, contactWayBtnH + 15);
    contactView.backgroundColor = UIColorFromRGB(0xefeff4);
    [self.view addSubview:contactView];
    
    UIButton *contactWayBtn = [[UIButton alloc] init];
    contactWayBtn.backgroundColor = [UIColor whiteColor];
    contactWayBtn.frame = CGRectMake(0, 15, LMScreenW, contactWayBtnH);
    [contactView addSubview:contactWayBtn];
    [contactWayBtn addTarget:self action:@selector(openContactVC) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *topDivider = [[UIView alloc] init];
    topDivider.backgroundColor = UIColorFromRGB(0xcccccc);
    [contactWayBtn addSubview:topDivider];
    topDivider.frame = CGRectMake(0, 0, LMScreenW, dividerH);
    
    UIView *bottomDivider = [[UIView alloc] init];
    bottomDivider.backgroundColor = UIColorFromRGB(0xcccccc);
    [contactWayBtn addSubview:bottomDivider];
    bottomDivider.frame = CGRectMake(0, contactWayBtnH - dividerH, LMScreenW, dividerH);
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(20, 0, 200, contactWayBtnH);
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.textColor = UIColorFromRGB(0x000000);
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.text = @"您可以留下具体联系方式";
    [contactWayBtn addSubview:titleLabel];
    
    UIImageView *arrowIcon = [[UIImageView alloc] init];
    arrowIcon.frame = CGRectMake(280, 15, 8.5, 15);
    arrowIcon.image = [UIImage imageNamed:@"mine_investRight"];
    [contactWayBtn addSubview:arrowIcon];
}

- (void)setupTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,LMScreenW, LMScreenH - 64 - bottomViewH)];
    self.tableView.backgroundColor = UIColorFromRGB(0xefeff4);
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.contentInset = UIEdgeInsetsMake(59, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidekeyboard)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
}

#pragma mark - tableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.feedbackFrames.count;
}

#pragma mark - tableView delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LMFeedbackCell *cell = [LMFeedbackCell cellWithTableView:tableView];
    
    cell.feedbackFrame = self.feedbackFrames[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    LMFeedbackFrame *feedbackFrame = self.feedbackFrames[indexPath.row];
    return feedbackFrame.cellHeight;
}

#pragma mark - Actoin

- (void)sendMessage {
    if (self.feedbackField.text.length == 0) {
        return;
    }
    
    LMFeedback *feedback = [[LMFeedback alloc] init];
    feedback.type = LMFeedbackTypeUser;
    feedback.text = self.feedbackField.text;
    
    LMFeedbackFrame *feedbackFrame = [[LMFeedbackFrame alloc] init];
    feedbackFrame.feedback = feedback;
    
    [self.feedbackFrames addObject:feedbackFrame];
    
    [self.tableView reloadData];
    
    [self.feedback post:[NSDictionary dictionaryWithObject:self.feedbackField.text forKey:@"content"]];
    self.feedbackField.text = @"";
    
    self.shouldScrollToBottom = YES;
    
    [self scrollToBottom];
}



#pragma mark -
#pragma mark UIScrollViewDelegate Methods
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

- (void)scrollToBottom {
    if ([self.tableView numberOfRowsInSection:0] > 1) {
        NSInteger lastRowNumber = [self.tableView numberOfRowsInSection:0] - 1;
        NSIndexPath *ip = [NSIndexPath indexPathForRow:lastRowNumber inSection:0];
        [self.tableView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

#pragma mark keyboard notification
- (void)keyboardWillShow:(NSNotification *)notification {
    CGFloat animationDuration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGFloat keyboardHeight = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    [UIView animateWithDuration:animationDuration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         CGRect bottomViewFrame = self.bottomView.frame;
                         bottomViewFrame.origin.y = self.view.bounds.size.height - keyboardHeight - bottomViewFrame.size.height;
                         self.bottomView.frame = bottomViewFrame;
                         
                         CGRect tableViewFrame = self.tableView.frame;
                         tableViewFrame.size.height = self.view.bounds.size.height - self.navigationController.navigationBar.frame.size.height - keyboardHeight;
                         self.tableView.frame = tableViewFrame;
                     }
                     completion:^(BOOL finished) {
                         if (self.shouldScrollToBottom) {
                             [self scrollToBottom];
                         }
                     }
     ];
    
    [self.view addGestureRecognizer:tapRecognizer];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    CGFloat animationDuration = [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView beginAnimations:@"bottomBarDown" context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    CGRect bottomViewFrame = self.bottomView.frame;
    bottomViewFrame.origin.y = self.view.bounds.size.height - bottomViewFrame.size.height;
    self.bottomView.frame = bottomViewFrame;
    
    CGRect tableViewFrame = self.tableView.frame;
    tableViewFrame.size.height = self.view.bounds.size.height - self.navigationController.navigationBar.frame.size.height;
    self.tableView.frame = tableViewFrame;
    
    [UIView commitAnimations];
    
    [self.view removeGestureRecognizer:tapRecognizer];
}

#pragma mark - UMFeedbackDataDelegate Methods
- (void)getFinishedWithError:(NSError *)error {
    
    if (error != nil) {
        return;
    }
    
    NSMutableArray *arr = self.feedback.topicAndReplies;
    
    
    if (arr.count <= self.feedbackFrames.count) {
        return;
    }
    
    for (NSInteger i = self.feedbackFrames.count; i < arr.count; i++) {
        
        NSDictionary *dic = arr[i];
        
        LMFeedback *feedback = [[LMFeedback alloc] init];
        
        feedback.type = [dic[@"type"] isEqualToString:@"dev_reply"] ? LMFeedbackTypeServer : LMFeedbackTypeUser;
        
        feedback.text = dic[@"content"];
        
        LMFeedbackFrame *feedbackFrame = [[LMFeedbackFrame alloc] init];
        feedbackFrame.feedback = feedback;
        
        [self.feedbackFrames addObject:feedbackFrame];
        
        [self.tableView reloadData];
    }
    
    if (self.shouldScrollToBottom) {
        [self scrollToBottom];
    }
}

- (void)postFinishedWithError:(NSError *)error {
    if (error == nil) {
        NSLog(@"发送成功");
    }
}

#pragma mark UITextField Delegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - Action Methods
- (void)getDatas {
    [self.feedback get];
}

- (void)didTapAnywhere:(UITapGestureRecognizer *)recognizer {
    [self.feedbackField resignFirstResponder];
}

- (void)postUserInfo:(NSNotification *)info {
    NSString *contactWay = info.object;
    
    NSMutableDictionary *contact = [NSMutableDictionary dictionary];
    contact[@"email"] = contactWay;
    contact[@"phone"] = contactWay;
    contact[@"qq"] = contactWay;
    
    NSMutableDictionary *payload = [NSMutableDictionary dictionary];
    payload[@"contact"] = contact;
    
    [self.feedback updateUserInfo:payload];
}

- (void)openContactVC {
    LMContactWayViewController *vc = [[LMContactWayViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)hidekeyboard {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
