//
//  POWorkPeriod.m
//  The Pomodoro
//
//  Created by Ben Norris on 9/27/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "POWorkPeriod.h"

#define startTimeKey @"startTime"
#define endTimeKey @"endTime"

@implementation POWorkPeriod

- (NSDictionary *)workPeriodDictionary {
    NSMutableDictionary *mutableDictionary = [NSMutableDictionary new];
    if (self.startTime) [mutableDictionary setValue:self.startTime forKey:startTimeKey];
    if (self.endTime) [mutableDictionary setValue:self.endTime forKey:endTimeKey];
    
    return mutableDictionary;
}

- (id)initWithDictionary: (NSDictionary *)dictionary {
    self.startTime = [dictionary objectForKey:startTimeKey];
    self.endTime = [dictionary objectForKey:endTimeKey];
    
    return self;
}

@end
