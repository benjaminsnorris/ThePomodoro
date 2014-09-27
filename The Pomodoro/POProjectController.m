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
