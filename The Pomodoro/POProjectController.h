//
//  POProjectController.h
//  The Pomodoro
//
//  Created by Ben Norris on 9/27/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "POProject.h"
#import "POWorkPeriod.h"

@interface POProjectController : NSObject

@property (nonatomic, strong, readonly) NSArray *projects;

+ (POProjectController *)sharedInstance;

- (void)addProject:(POProject *)project;
- (void)removeProject:(POProject *)project;
- (void)replaceProject:(POProject *)oldProject withProject:(POProject *)newProject;
- (void)startNewWorkPeriod:(POProject *)project;
- (void)endCurrentWorkPeriod:(POProject *)project;
- (void)addWorkPeriod:(POWorkPeriod *)workPeriod toProject:(POProject *)project;

@end
