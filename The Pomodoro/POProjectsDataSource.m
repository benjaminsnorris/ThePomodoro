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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    
    POProject *project = [POProjectController sharedInstance].projects[indexPath.row];
    cell.textLabel.text = project.title;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Hours worked: %0.1f", project.timeSpent];
    
    // Appearance stuff
    [cell.textLabel setFont:[UIFont fontWithName:@"Avenir Next" size:18]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[POProjectController sharedInstance] removeProject:[POProjectController sharedInstance].projects[indexPath.row]];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationBottom];
    }
}

@end
