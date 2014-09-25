//
//  PORoundsViewController.m
//  The Pomodoro
//
//  Created by Ben Norris on 9/23/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "PORoundsViewController.h"
#import "PORoundsDataSource.h"
#import "POTimer.h"
#import "PORoundsTableViewCell.h"

@interface PORoundsViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) PORoundsDataSource *dataSource;

@end

@implementation PORoundsViewController

- (id)init {
    self = [super init];
    
    if (self) {
        [self registerForNotifications];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Rounds";

    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.dataSource = [PORoundsDataSource new];
    self.tableView.dataSource = self.dataSource;
    self.tableView.rowHeight = 50.0;
    self.tableView.autoresizingMask = (UIViewAutoresizingFlexibleWidth);
    
    [self.view addSubview:self.tableView];
    
    [self getCurrentRound];
    [self updateTimer];
}

- (void)updateTimer {
    [[POTimer sharedInstance] stopTimer];
    [POTimer sharedInstance].startingSeconds = [[self.dataSource roundAtIndex:self.dataSource.currentRound] integerValue] * 60;
    [[NSNotificationCenter defaultCenter] postNotificationName:newRoundNotification object:nil];
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PORoundsTableViewCell *currentCell = (PORoundsTableViewCell *)[self.tableView cellForRowAtIndexPath:[self.tableView indexPathForSelectedRow]];
    currentCell.progressView.progress = 0;
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.dataSource.currentRound = indexPath.row;
    [self updateTimer];
}

- (void)updateProgress {
    PORoundsTableViewCell *currentCell = (PORoundsTableViewCell *)[self.tableView cellForRowAtIndexPath:[self.tableView indexPathForSelectedRow]];
    if (([POTimer sharedInstance].seconds > 0) && ([POTimer sharedInstance].startingSeconds != [POTimer sharedInstance].seconds)) {
        currentCell.progressView.progress = ([POTimer sharedInstance].seconds / (CGFloat)[POTimer sharedInstance].startingSeconds);
    } else {
        currentCell.progressView.progress = 0;
    }
}

- (void)endSession:(NSNotification *) notification {
    self.dataSource.currentRound++;
    [self getCurrentRound];
    [self updateTimer];
}

- (void)getCurrentRound {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.dataSource.currentRound inSection:0];
    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
}

- (void)registerForNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endSession:) name:timerCompleteNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateProgress) name:secondTickNotification object:nil];
}

- (void)unregisterForNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)dealloc {
    [self unregisterForNotifications];
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
