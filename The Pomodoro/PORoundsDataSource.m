//
//  PORoundsDataSource.m
//  The Pomodoro
//
//  Created by Ben Norris on 9/23/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "PORoundsDataSource.h"

#define currentRoundKey @"currentRound"

@implementation PORoundsDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self times].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Round %ld - %@ min", indexPath.row + 1, [[self times][indexPath.row] stringValue]];
    
    return cell;
}

- (NSArray *)times {
    return @[@25, @5, @25, @5, @25, @5, @25, @15];
}

- (NSNumber *)roundAtIndex:(NSInteger) index {
    return [self times][index];
}

- (void)setCurrentRound:(NSInteger)currentRound {
    if (currentRound >= [self times].count) {
        _currentRound = 0;
    } else {
        _currentRound = currentRound;
    }
}

@end
