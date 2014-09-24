//
//  POTimer.m
//  The Pomodoro
//
//  Created by Ben Norris on 9/23/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "POTimer.h"

NSString * const secondTickNotification = @"secondTick";
NSString * const timerCompleteNotification = @"timerComplete";

@interface POTimer()

@property (nonatomic, assign) BOOL isRunning;

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

- (void)startTimer {
    self.seconds = 10;
    self.isRunning = YES;
    [self runTimer];
}

- (void)runTimer {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    if (self.isRunning) {
        [self decreaseSecond];
        [self performSelector:@selector(runTimer) withObject:self afterDelay:1.0];
    }
}

- (void)endTimer {
    self.isRunning = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:timerCompleteNotification object:nil];
}

- (void)decreaseSecond {
    if (self.seconds > 0) {
        self.seconds--;
        [[NSNotificationCenter defaultCenter] postNotificationName:secondTickNotification object:nil];
    } else if (self.seconds == 0) {
        [self endTimer];
    }
}

@end
