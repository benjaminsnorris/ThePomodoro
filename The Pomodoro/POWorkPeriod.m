//
//  POWorkPeriod.m
//  The Pomodoro
//
//  Created by Ben Norris on 9/27/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "POWorkPeriod.h"

@implementation POWorkPeriod

- (id)init {
    return self;
}

- (id)initWithStartTime:(NSDate *)startTime {
    if (startTime) {
        self.startTime = startTime;
    }
    return self;
}

@end
