//
//  POProjectsViewController.m
//  The Pomodoro
//
//  Created by Ben Norris on 9/27/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "POProjectsViewController.h"
#import "POProjectsDataSource.h"

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
    [self.view addSubview: self.tableView];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add)];
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)add {
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
