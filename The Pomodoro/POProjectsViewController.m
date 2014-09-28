//
//  POProjectsViewController.m
//  The Pomodoro
//
//  Created by Ben Norris on 9/27/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "POProjectsViewController.h"
#import "POProjectsDataSource.h"
#import "POProjectDetailViewController.h"

@interface POProjectsViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) POProjectsDataSource *dataSource;

@end

@implementation POProjectsViewController

- (id)init {
    self = [super init];
    
    if (self) {
        self.dataSource = [POProjectsDataSource new];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Projects";
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self;
    [self.view addSubview: self.tableView];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add)];
    self.navigationItem.rightBarButtonItem = addButton;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}

- (void)add {
    POProjectDetailViewController *detailViewController = [POProjectDetailViewController new];
    detailViewController.title = @"New Project";
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    POProjectDetailViewController *detailViewController = [POProjectDetailViewController new];
    detailViewController.title = [self.dataSource tableView:tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    [detailViewController updateWithProject:[POProjectController sharedInstance].projects[indexPath.row]];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
