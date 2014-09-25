//
//  POTimer.h
//  The Pomodoro
//
//  Created by Ben Norris on 9/23/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const secondTickNotification;
extern NSString * const timerCompleteNotification;
extern NSString * const newRoundNotification;

@interface POTimer : NSObject

@property (nonatomic, assign, readonly) BOOL isRunning;
@property (nonatomic, assign) NSInteger startingSeconds;
@property (nonatomic, assign, readonly) CGFloat seconds;

+ (POTimer *)sharedInstance;
- (void)startTimer;
- (void)stopTimer;
- (void)endTimer;

@end
