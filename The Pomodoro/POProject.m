//
//  POProject.m
//  The Pomodoro
//
//  Created by Ben Norris on 9/27/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "POProject.h"
#import "POWorkPeriod.h"

#define titleKey @"title"
#define timeSpentKey @"timeSpent"
#define workPeriodsKey @"workPeriods"

@implementation POProject

- (NSDictionary *)projectDictionary {
    
    NSMutableDictionary *mutableDictionary = [NSMutableDictionary new];
    if (self.title) [mutableDictionary setValue:self.title forKey:titleKey];
    [mutableDictionary setValue:@(self.timeSpent) forKey:timeSpentKey];
    if (self.workPeriods) {
        NSMutableArray *mutableWorkPeriods = [NSMutableArray new];
        for (POWorkPeriod *workPeriod in self.workPeriods) {
            [mutableWorkPeriods addObject:[workPeriod workPeriodDictionary]];
        }
        [mutableDictionary setValue:mutableWorkPeriods forKey:workPeriodsKey];
    }
    
    return mutableDictionary;
}

- (id)initWithDictionary: (NSDictionary *)dictionary {
    
    self.title = [dictionary objectForKey:titleKey];
    self.timeSpent = [[dictionary objectForKey:timeSpentKey] doubleValue];
    NSMutableArray *mutableWorkPeriods = [NSMutableArray new];
    NSArray *workPeriodsFromDictionary = [dictionary objectForKey:workPeriodsKey];
    for (NSDictionary *workPeriodDictionary in workPeriodsFromDictionary) {
        [mutableWorkPeriods addObject:[[POWorkPeriod alloc] initWithDictionary:workPeriodDictionary]];
    }
    self.workPeriods = mutableWorkPeriods;
    
    return self;
}

@end
