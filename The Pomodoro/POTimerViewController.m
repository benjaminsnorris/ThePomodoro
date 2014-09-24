//
//  POTimerViewController.m
//  The Pomodoro
//
//  Created by Ben Norris on 9/23/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "POTimerViewController.h"
#import "POTimer.h"

#define margin 15

@interface POTimerViewController ()

@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIButton *timerButton;

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
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, 100, self.view.bounds.size.width - (margin * 2), 100)];
    self.timeLabel.textColor = [UIColor whiteColor];
    self.timeLabel.font = [UIFont fontWithName:@"Avenir Next" size:100];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    [self updateLabel];
    
    [self.view addSubview:self.timeLabel];
    
    self.timerButton = [[UIButton alloc] initWithFrame:CGRectMake(margin, 250, self.view.bounds.size.width - (margin * 2), 30)];
    [self.timerButton setTitle:@"Start round" forState:UIControlStateNormal];
    [self.timerButton addTarget:self action:@selector(startSession) forControlEvents:UIControlEventTouchUpInside];
    
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
    NSInteger seconds = [POTimer sharedInstance].seconds % 60;
    
    if (seconds > 9) {
        self.timeLabel.text = [NSString stringWithFormat:@"%ld:%ld", minutes, seconds];
    } else {
        self.timeLabel.text = [NSString stringWithFormat:@"%ld:0%ld",minutes, seconds];
    }
}

- (void)updateButton {
    self.timerButton.enabled = YES;
    [self.timerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (void)startSession {
    [[POTimer sharedInstance] startTimer];
    self.timerButton.enabled = NO;
    [self.timerButton setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.4] forState:UIControlStateNormal];
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
