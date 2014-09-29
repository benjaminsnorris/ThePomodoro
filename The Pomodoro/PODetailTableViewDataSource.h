//
//  PODetailTableViewDataSource.h
//  The Pomodoro
//
//  Created by Ben Norris on 9/27/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "POProjectController.h"

@interface PODetailTableViewDataSource : NSObject <UITableViewDataSource>

@property (nonatomic, strong) POProject *project;

@end
