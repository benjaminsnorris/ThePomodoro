//
//  POProjectDetailViewController.m
//  The Pomodoro
//
//  Created by Ben Norris on 9/27/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "POProjectDetailViewController.h"
#import <MessageUI/MessageUI.h>
#import "PODetailTableViewDataSource.h"

#define margin 15.0
#define titleHeight 30.0
#define labelHeight 20.0

@interface POProjectDetailViewController () <MFMailComposeViewControllerDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UITextField *titleField;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) POProject *project;
@property (nonatomic, strong) PODetailTableViewDataSource *dataSource;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger currentWorkPeriod;
@property (nonatomic, strong) UIDatePicker *startTimePicker;
@property (nonatomic, strong) UIDatePicker *endTimePicker;

@end

@implementation POProjectDetailViewController

- (id)init {
    self = [super init];
    if (self) {
        self.titleField = [UITextField new];
        self.tableView = [UITableView new];
        self.dataSource = [PODetailTableViewDataSource new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.currentWorkPeriod = -1;
    
    CGFloat top = margin;
    
    self.titleField.frame = CGRectMake(margin, top, self.view.bounds.size.width - (margin * 2), titleHeight);
    self.titleField.placeholder = @"Project Title";
    self.titleField.borderStyle = UITextBorderStyleRoundedRect;
    self.titleField.delegate = self;
    [self.view addSubview:self.titleField];
    [self.titleField addTarget:self action:@selector(saveProject) forControlEvents:UIControlEventEditingChanged];
    top += titleHeight + margin;
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, top, self.view.bounds.size.width - (margin * 2), titleHeight)];
    self.timeLabel.text = [NSString stringWithFormat:@"Time spent: %0.1f", self.project.timeSpent];
    self.timeLabel.font = [UIFont systemFontOfSize:24];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.timeLabel];
    top += titleHeight + margin;
    
    UIToolbar *toolbar = [UIToolbar new];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addWorkPeriod)];
    UIBarButtonItem *clockInButton = [[UIBarButtonItem alloc] initWithTitle:@"Clock In" style:UIBarButtonItemStylePlain target:self action:@selector(clockIn)];
    UIBarButtonItem *clockOutButton = [[UIBarButtonItem alloc] initWithTitle:@"Clock Out" style:UIBarButtonItemStylePlain target:self action:@selector(clockOut)];
//    UIBarButtonItem *reportButton = [[UIBarButtonItem alloc] initWithTitle:@"Report" style:UIBarButtonItemStylePlain target:self action:@selector(sendReport)];
    UIBarButtonItem *reportButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(sendReport)];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    CGSize toolbarSize = [toolbar sizeThatFits:self.view.bounds.size];
    [toolbar setItems:@[addButton, spaceItem, clockInButton, spaceItem, clockOutButton, spaceItem, reportButton]];
    toolbar.frame = CGRectMake(0, self.view.bounds.size.height - self.navAndStatusBarHeight - toolbarSize.height - self.tabBarController.tabBar.frame.size.height, toolbarSize.width, toolbarSize.height);
    [self.view addSubview:toolbar];
    
    self.tableView.frame = CGRectMake(0, top, self.view.bounds.size.width, self.view.bounds.size.height - top - self.tabBarController.tabBar.frame.size.height - toolbarSize.height - self.navAndStatusBarHeight);
    self.dataSource.project = self.project;
    self.tableView.dataSource = self.dataSource;
    [self.view addSubview:self.tableView];
}

- (void)saveProject {
    POProject *project = [POProject new];
    self.title = project.title = self.titleField.text;
    
    if (self.project) {
        [[POProjectController sharedInstance] replaceProject:self.project withProject:project];
    } else {
        [[POProjectController sharedInstance] addProject:project];
    }
    
    [self updateWithProject:project];
    
}

- (void)updateWithProject:(POProject *)project {
    self.project = project;
    
    self.titleField.text = project.title;
}

- (void)addWorkPeriod {
    UIViewController *addWorkPeriodViewController = [UIViewController new];
    UINavigationController *addWorkPeriodNavController = [[UINavigationController alloc] initWithRootViewController:addWorkPeriodViewController];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelAddWorkPeriod)];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveNewWorkPeriod)];
    addWorkPeriodNavController.view.backgroundColor = [UIColor whiteColor];
    addWorkPeriodViewController.title = @"Add Work Period";
    addWorkPeriodViewController.navigationItem.leftBarButtonItem = cancelButton;
    addWorkPeriodViewController.navigationItem.rightBarButtonItem = saveButton;
    [addWorkPeriodNavController.navigationBar setTintColor:[UIColor whiteColor]];
    
    CGFloat top = margin + self.navAndStatusBarHeight;
    UILabel *startTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, top, self.view.frame.size.width - (margin * 2), labelHeight)];
    startTimeLabel.text = @"Start Time";
    startTimeLabel.font = [UIFont boldSystemFontOfSize:17];
    [addWorkPeriodViewController.view addSubview:startTimeLabel];
    top += labelHeight;
    
    self.startTimePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, top, 0, 0)];
    [addWorkPeriodViewController.view addSubview:self.startTimePicker];
    top += self.startTimePicker.frame.size.height + margin;
    
    UILabel *endTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, top, self.view.frame.size.width - (margin * 2), labelHeight)];
    endTimeLabel.text = @"End Time";
    endTimeLabel.font = [UIFont boldSystemFontOfSize:17];
    [addWorkPeriodViewController.view addSubview:endTimeLabel];
    top += labelHeight;

    self.endTimePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, top, 0, 0)];
    [addWorkPeriodViewController.view addSubview:self.endTimePicker];
    top += self.endTimePicker.frame.size.height + margin;
    
    [self presentViewController:addWorkPeriodNavController animated:YES completion:nil];
}

- (void)cancelAddWorkPeriod {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveNewWorkPeriod {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)clockIn {
    [[POProjectController sharedInstance] startNewWorkPeriod:self.project];
    [self.tableView reloadData];
}

- (void)clockOut {
    [[POProjectController sharedInstance] endCurrentWorkPeriod:self.project];
    [self.tableView reloadData];
    self.timeLabel.text = [NSString stringWithFormat:@"Time spent: %0.1f", self.project.timeSpent];
}

- (void)sendReport {
    MFMailComposeViewController *mailController = [MFMailComposeViewController new];
    mailController.mailComposeDelegate = self;
    [mailController setSubject:[NSString stringWithFormat:@"Report for project: %@",self.titleField.text]];
    [mailController setMessageBody:@"This is a test body." isHTML:NO];
    [mailController.navigationBar setTintColor:[UIColor whiteColor]];
    
    if ([MFMailComposeViewController canSendMail]) {
        [self presentViewController:mailController animated:YES completion:nil];
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (CGFloat)navAndStatusBarHeight {
    return self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height;
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
