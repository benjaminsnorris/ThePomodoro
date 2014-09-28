//
//  POProjectDetailViewController.m
//  The Pomodoro
//
//  Created by Ben Norris on 9/27/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "POProjectDetailViewController.h"

#define margin 15.0

@interface POProjectDetailViewController ()

@property (nonatomic, strong) UITextField *titleField;
@property (nonatomic, strong) POProject *project;

@end

@implementation POProjectDetailViewController

- (id)init {
    self = [super init];
    if (self) {
        self.titleField = [UITextField new];
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
    [self.view addSubview:self.titleField];
    [self.titleField addTarget:self action:@selector(saveProject) forControlEvents:UIControlEventEditingChanged];
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
