//
//  PODetailTableViewDataSource.m
//  The Pomodoro
//
//  Created by Ben Norris on 9/27/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "PODetailTableViewDataSource.h"
#import "POWorkPeriod.h"

@implementation PODetailTableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.project.workPeriods.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    POWorkPeriod *workPeriod = self.project.workPeriods[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"Start: %@ End: %@", workPeriod.startTime, workPeriod.endTime];
    
    return cell;
}

@end
