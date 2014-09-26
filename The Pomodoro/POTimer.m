//
//  POTimer.m
//  The Pomodoro
//
//  Created by Ben Norris on 9/23/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "POTimer.h"

#define timerDelay 0.05

NSString * const secondTickNotification = @"secondTick";
NSString * const timerCompleteNotification = @"timerComplete";
NSString * const newRoundNotification = @"newRound";

@interface POTimer()

@property (nonatomic, assign) BOOL isRunning;
@property (nonatomic, assign) CGFloat seconds;
@property (nonatomic, strong) UILocalNotification *sessionEndNotification;

@end

@implementation POTimer

+ (POTimer *)sharedInstance {
    static POTimer *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [POTimer new];
    });
    return sharedInstance;
}

- (id)init {
    self.sessionEndNotification = [UILocalNotification new];
    self.sessionEndNotification.repeatInterval = 0;
    self.sessionEndNotification.alertBody = @"Pomodoro Session Complete";
    self.sessionEndNotification.soundName = @"sms_alert_circles.caf";
    self.sessionEndNotification.applicationIconBadgeNumber = 1;
    
    return self;
}

- (void)startTimer {
    [[UIApplication sharedApplication] cancelAllLocalNotifications];

    self.sessionEndNotification.fireDate = [[NSDate date] dateByAddingTimeInterval:self.seconds];
    [[UIApplication sharedApplication] scheduleLocalNotification:self.sessionEndNotification];

    self.isRunning = YES;
    [self runTimer];
}

- (void)setStartingSeconds:(NSInteger)startingSeconds {
    if (startingSeconds > 0) {
        _startingSeconds = startingSeconds;
        _seconds = startingSeconds;
    }
}

- (void)runTimer {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    if (self.isRunning) {
        [self decreaseSecond];
        [self performSelector:@selector(runTimer) withObject:self afterDelay:timerDelay];
    }
}

- (void)endTimer {
    [[UIApplication sharedApplication] cancelAllLocalNotifications];

    self.isRunning = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:timerCompleteNotification object:nil];
}

- (void)stopTimer {
    self.isRunning = NO;
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    // QUESTION: Why would the selector of this be decreaseSecond?
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(decreaseSecond) object:nil];
}

- (void)decreaseSecond {
    if (self.seconds > 0) {
        self.seconds -= timerDelay;
        [[NSNotificationCenter defaultCenter] postNotificationName:secondTickNotification object:nil];
    } else if (self.seconds <= 0) {
        [self endTimer];
    }
}

@end
