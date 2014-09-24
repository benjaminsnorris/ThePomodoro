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

@interface POTimer : NSObject

@property (nonatomic, assign) NSInteger seconds;

+ (POTimer *)sharedInstance;
- (void)startTimer;

@end
