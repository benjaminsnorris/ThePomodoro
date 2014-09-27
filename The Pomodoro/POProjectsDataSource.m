//
//  POProjectsDataSource.m
//  The Pomodoro
//
//  Created by Ben Norris on 9/27/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "POProjectsDataSource.h"
#import "POProjectController.h"

@implementation POProjectsDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [POProjectController sharedInstance].projects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    POProject *project = [POProjectController sharedInstance].projects[indexPath.row];
    cell.textLabel.text = project.title;
    
    // Appearance stuff
    [cell.textLabel setFont:[UIFont fontWithName:@"Avenir Next" size:18]];
    UIView *selectedView = [[UIView alloc] initWithFrame:cell.frame];
    selectedView.backgroundColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.2];
    [cell setSelectedBackgroundView:selectedView];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

@end
