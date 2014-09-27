//
//  POProjectController.m
//  The Pomodoro
//
//  Created by Ben Norris on 9/27/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "POProjectController.h"

@interface POProjectController()

@property (nonatomic, strong) NSArray *projects;

@end

@implementation POProjectController

+ (POProjectController *)sharedInstance {
    static POProjectController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [POProjectController new];
        sharedInstance.projects = @[[POProject new], [POProject new]];
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
    [self synthesize];
}

- (void)removeProject:(POProject *)project {
    
}

- (void)replaceProject:(POProject *)oldProject withProject:(POProject *)newProject {
    
}

- (void)synthesize {
    
}

@end
