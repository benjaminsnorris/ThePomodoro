//
//  POTimerViewController.m
//  The Pomodoro
//
//  Created by Ben Norris on 9/23/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "POTimerViewController.h"
#import "POTimer.h"
#import "POCircleProgressView.h"

#define margin 15

@interface POTimerViewController ()

@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIButton *timerButton;
@property (nonatomic, strong) POCircleProgressView *progressView;

@end

@implementation POTimerViewController

- (id)init {
    self = [super init];
    
    if (self) {
        [self registerForNotifications];
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Timer";
    self.view.backgroundColor = [UIColor redColor];
    
    self.progressView = [[POCircleProgressView alloc] initWithFrame:CGRectMake(margin, margin * 2, self.view.bounds.size.width - (margin * 2), self.view.bounds.size.width - (margin * 2))];
    self.progressView.fillColor = [UIColor whiteColor];
    self.progressView.fillBackgroundColor = nil;
    self.progressView.borderColor = nil;
    [self.view addSubview:self.progressView];
    
    CGFloat progressBorder = 5;
    POCircleProgressView *blockingCircle = [[POCircleProgressView alloc] initWithFrame:CGRectMake(self.progressView.frame.origin.x + progressBorder, self.progressView.frame.origin.y + progressBorder, self.progressView.frame.size.width - (progressBorder * 2), self.progressView.frame.size.height - (progressBorder * 2))];
    blockingCircle.fillBackgroundColor = [UIColor redColor];
    blockingCircle.borderColor = nil;
    [self.view addSubview:blockingCircle];
    
    CGFloat labelHeight = 90;
    CGFloat labelVerticalPosition = self.progressView.frame.origin.y + (self.progressView.bounds.size.height / 2) - (labelHeight / 2);
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, labelVerticalPosition, self.view.bounds.size.width - (margin * 2), labelHeight)];
    self.timeLabel.textColor = [UIColor whiteColor];
    self.timeLabel.font = [UIFont fontWithName:@"Avenir Next" size:labelHeight];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    [self updateLabel];
    [self.view addSubview:self.timeLabel];
    
    CGFloat buttonVerticalPosition = self.progressView.frame.origin.y + self.progressView.bounds.size.height + margin;
    self.timerButton = [[UIButton alloc] initWithFrame:CGRectMake(margin, buttonVerticalPosition, self.view.bounds.size.width - (margin * 2), 30)];
    [self.timerButton addTarget:self action:@selector(startPauseSession) forControlEvents:UIControlEventTouchUpInside];
    [self.timerButton setTitle:@"Start round" forState:UIControlStateNormal];
    [self.timerButton setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.4] forState:UIControlStateHighlighted];
    [self.view addSubview:self.timerButton];
}

- (void)registerForNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLabel) name:secondTickNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateButton) name:timerCompleteNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newSession) name:newRoundNotification object:nil];
}

- (void)unregisterForNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)updateLabel {
    NSInteger minutes = floor([POTimer sharedInstance].seconds / 60);
    NSInteger seconds = floorf([POTimer sharedInstance].seconds  - (minutes * 60));
    
    if (seconds > 9) {
        self.timeLabel.text = [NSString stringWithFormat:@"%ld:%ld", minutes, seconds];
    } else {
        self.timeLabel.text = [NSString stringWithFormat:@"%ld:0%ld",minutes, seconds];
    }
    
    if (([POTimer sharedInstance].seconds > 0) && ([POTimer sharedInstance].startingSeconds != [POTimer sharedInstance].seconds)) {
        self.progressView.progress = 1 - ([POTimer sharedInstance].seconds / (CGFloat)[POTimer sharedInstance].startingSeconds);
    } else {
        self.progressView.progress = 0;
    }
}

- (void)updateButton {
    [self.timerButton setTitle:@"Start round" forState:UIControlStateNormal];
}

- (void)startPauseSession {
    if ([POTimer sharedInstance].isRunning) {
        [[POTimer sharedInstance] stopTimer];
        [self.timerButton setTitle:@"Resume round" forState:UIControlStateNormal];
    } else {
        [[POTimer sharedInstance] startTimer];
        [self.timerButton setTitle:@"Pause round" forState:UIControlStateNormal];
    }
}

- (void)newSession {
    [self updateLabel];
    [self updateButton];
}

- (void)dealloc {
    [self unregisterForNotifications];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
