//
//  POProject.h
//  The Pomodoro
//
//  Created by Ben Norris on 9/27/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface POProject : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) double timeSpent;
@property (nonatomic, strong) NSArray *workPeriods;

- (NSDictionary *)projectDictionary;
- (id)initWithDictionary: (NSDictionary *)dictionary;

@end
