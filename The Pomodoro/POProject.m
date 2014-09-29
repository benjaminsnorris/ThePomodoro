//
//  POProject.m
//  The Pomodoro
//
//  Created by Ben Norris on 9/27/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "POProject.h"

#define titleKey @"title"
#define timeSpentKey @"timeSpent"
#define workPeriodsKey @"workPeriods"

@implementation POProject

- (NSDictionary *)projectDictionary {
    
    NSMutableDictionary *mutableDictionary = [NSMutableDictionary new];
    if (self.title) [mutableDictionary setValue:self.title forKey:titleKey];
    [mutableDictionary setValue:@(self.timeSpent) forKey:timeSpentKey];
    if (self.workPeriods) [mutableDictionary setValue:self.workPeriods forKey:workPeriodsKey];
    
    return mutableDictionary;
}

- (id)initWithDictionary: (NSDictionary *)dictionary {
    
    self.title = [dictionary objectForKey:titleKey];
    self.timeSpent = [[dictionary objectForKey:timeSpentKey] doubleValue];
    self.workPeriods = [dictionary objectForKey:workPeriodsKey];
    
    return self;
}

@end
