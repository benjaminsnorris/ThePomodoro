//
//  PORoundsDataSource.h
//  The Pomodoro
//
//  Created by Ben Norris on 9/23/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PORoundsDataSource : NSObject <UITableViewDataSource>

@property (nonatomic, assign) NSInteger currentRound;

- (NSNumber *)roundAtIndex:(NSInteger) index;

@end
