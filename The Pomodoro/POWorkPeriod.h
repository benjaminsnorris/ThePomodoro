//
//  POWorkPeriod.h
//  The Pomodoro
//
//  Created by Ben Norris on 9/27/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface POWorkPeriod : NSObject

@property (nonatomic, strong) NSDate *startTime;
@property (nonatomic, strong) NSDate *endTime;

@end
