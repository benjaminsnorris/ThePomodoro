//
//  POAppDelegate.m
//  The Pomodoro
//
//  Created by Joshua Howland on 6/3/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "POAppDelegate.h"
#import "POTimerViewController.h"
#import "PORoundsViewController.h"
#import "POProjectsViewController.h"

@interface POAppDelegate()

@property (nonatomic, strong) POTimerViewController *timerViewController;

@end

@implementation POAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    UIUserNotificationSettings *notificationSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
    [application registerUserNotificationSettings:notificationSettings];
    
    UITabBarController *tabBarController = [UITabBarController new];
    
    POProjectsViewController *projectsViewController = [POProjectsViewController new];
    projectsViewController.tabBarItem.title = @"Projects";
    projectsViewController.tabBarItem.image = [UIImage imageNamed:@"rounds"];
    UINavigationController *projectsNavController = [[UINavigationController alloc] initWithRootViewController:projectsViewController];
    projectsNavController.navigationBar.translucent = NO;
    
    PORoundsViewController *roundsViewController = [PORoundsViewController new];
    roundsViewController.tabBarItem.title = @"Rounds";
    roundsViewController.tabBarItem.image = [UIImage imageNamed:@"rounds"];
    UINavigationController *roundsNavController = [[UINavigationController alloc] initWithRootViewController:roundsViewController];
    roundsNavController.navigationBar.translucent = NO;
    
    self.timerViewController = [POTimerViewController new];
    self.timerViewController.tabBarItem.title = @"Timer";
    self.timerViewController.tabBarItem.image = [UIImage imageNamed:@"clock"];
    UINavigationController *timerNavController =[[UINavigationController alloc] initWithRootViewController:self.timerViewController];
    timerNavController.navigationBar.translucent = NO;

    tabBarController.viewControllers = @[projectsNavController, roundsNavController, timerNavController];
//    tabBarController.viewControllers = @[timerNavController, roundsNavController];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    [[UINavigationBar appearance] setBarTintColor:[UIColor redColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: [UIFont fontWithName:@"Avenir Next" size:20]}];
    tabBarController.tabBar.tintColor = [UIColor redColor];
    
    self.window.rootViewController = tabBarController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:notification.alertBody message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Not yet" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        // Dismiss for now
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Start next session" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self.timerViewController startPauseSession];
    }]];
    
    [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
    
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"An Alert" message:notification.alertBody delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [alertView show];
    application.applicationIconBadgeNumber = 0;
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    application.applicationIconBadgeNumber = 0;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
