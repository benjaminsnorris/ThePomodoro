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

@interface POProjectDetailViewController () <MFMailComposeViewControllerDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UITextField *titleField;
@property (nonatomic, strong) POProject *project;
@property (nonatomic, strong) PODetailTableViewDataSource *dataSource;
@property (nonatomic, strong) UITableView *tableView;

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
    
    self.titleField.frame = CGRectMake(margin, margin, self.view.bounds.size.width - (margin * 2), 30);
    self.titleField.placeholder = @"Project Title";
    self.titleField.borderStyle = UITextBorderStyleRoundedRect;
    self.titleField.delegate = self;
    [self.view addSubview:self.titleField];
    [self.titleField addTarget:self action:@selector(saveProject) forControlEvents:UIControlEventEditingChanged];
    
    self.tableView.frame = CGRectMake(0, 100, self.view.frame.size.width, 300);
//    self.tableView.dataSource = self.dataSource;
    [self.view addSubview:self.tableView];

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
    
}

- (void)clockIn {
    
}

- (void)clockOut {
    
}

- (void)sendReport {
    MFMailComposeViewController *mailController = [MFMailComposeViewController new];
    mailController.mailComposeDelegate = self;
    [mailController setSubject:[NSString stringWithFormat:@"Report for project: %@",self.titleField.text]];
    [mailController setMessageBody:@"This is a test body." isHTML:NO];
    
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
