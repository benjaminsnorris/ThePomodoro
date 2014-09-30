//
//  POProjectController.m
//  The Pomodoro
//
//  Created by Ben Norris on 9/27/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "POProjectController.h"

#define projectListKey @"projects"

@interface POProjectController()

@property (nonatomic, strong) NSArray *projects;
@property (nonatomic, strong) POWorkPeriod *currentWorkPeriod;

@end

@implementation POProjectController

+ (POProjectController *)sharedInstance {
    static POProjectController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [POProjectController new];
        [sharedInstance loadFromDefaults];
    });
    return sharedInstance;
}

- (void)startNewWorkPeriod:(POProject *)project {
    if (!project) {
        return;
    }
    NSMutableArray *mutableWorkPeriods = [[NSMutableArray alloc] initWithArray:project.workPeriods.mutableCopy];
    POWorkPeriod *workPeriod = [POWorkPeriod new];
    workPeriod.startTime = [NSDate date];
    [mutableWorkPeriods addObject:workPeriod];
    self.currentWorkPeriod = workPeriod;
    project.workPeriods = mutableWorkPeriods;
    [self synchronize];
}

- (void)endCurrentWorkPeriod:(POProject *)project {
    if (!project) {
        return;
    }
    NSMutableArray *mutableWorkPeriods = [[NSMutableArray alloc] initWithArray:project.workPeriods.mutableCopy];
    self.currentWorkPeriod.endTime = [NSDate date];
    mutableWorkPeriods[[mutableWorkPeriods indexOfObject:self.currentWorkPeriod]] = self.currentWorkPeriod;
    project.workPeriods = mutableWorkPeriods;
    project.timeSpent += [self.currentWorkPeriod.endTime timeIntervalSinceDate:self.currentWorkPeriod.startTime] / 60 / 60;
    self.currentWorkPeriod = nil;
    [self synchronize];
}

- (void)addProject:(POProject *)project {
    if (!project) {
        return;
    }
    
    NSMutableArray *mutableProjects = self.projects.mutableCopy;
    [mutableProjects addObject:project];
    
    self.projects = mutableProjects;
    [self synchronize];
}

- (void)removeProject:(POProject *)project {
    if (!project) {
        return;
    }
    NSMutableArray *mutableProjects = self.projects.mutableCopy;
    if ([mutableProjects containsObject:project]) {
        [mutableProjects removeObject:project];
    }
    self.projects = mutableProjects;
    [self synchronize];
}

- (void)replaceProject:(POProject *)oldProject withProject:(POProject *)newProject {
    if ((!oldProject) || (!newProject)) {
        return;
    }
    NSMutableArray *mutableProjects = self.projects.mutableCopy;
    if ([mutableProjects containsObject:oldProject]) {
        [mutableProjects replaceObjectAtIndex:[mutableProjects indexOfObject:oldProject] withObject:newProject];
    }
    self.projects = mutableProjects;
    [self synchronize];
}

- (void)addWorkPeriod:(POWorkPeriod *)workPeriod toProject:(POProject *)project{
    if (!workPeriod) {
        return;
    }
    
    NSMutableArray *mutableWorkPeriods = project.workPeriods.mutableCopy;
    [mutableWorkPeriods addObject:workPeriod];
    project.workPeriods = mutableWorkPeriods;
    project.timeSpent += [workPeriod.endTime timeIntervalSinceDate:workPeriod.startTime] / 60 / 60;
    [self synchronize];
}

- (void)synchronize {
    NSMutableArray *projectDictionaries = [NSMutableArray new];
    for (POProject *project in self.projects) {
        [projectDictionaries addObject:[project projectDictionary]];
    }
    [[NSUserDefaults standardUserDefaults] setObject:projectDictionaries forKey:projectListKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)loadFromDefaults {
    NSArray *projectDictionaries = [[NSUserDefaults standardUserDefaults] objectForKey:projectListKey];
    NSMutableArray *mutableProjects = [NSMutableArray new];
    for (NSDictionary *dictionary in projectDictionaries) {
        POProject *project = [[POProject alloc] initWithDictionary:dictionary];
        [mutableProjects addObject:project];
    }
    self.projects = mutableProjects;
}

@end
