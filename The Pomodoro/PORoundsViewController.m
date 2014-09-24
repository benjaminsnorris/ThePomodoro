//
//  PORoundsViewController.m
//  The Pomodoro
//
//  Created by Ben Norris on 9/23/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "PORoundsViewController.h"
#import "PORoundsDataSource.h"

@interface PORoundsViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) PORoundsDataSource *dataSource;

@end

@implementation PORoundsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Rounds";

    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.dataSource = [PORoundsDataSource new];
    self.tableView.dataSource = self.dataSource;
    
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
