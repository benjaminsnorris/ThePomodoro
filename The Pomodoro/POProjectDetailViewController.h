//
//  POProjectDetailViewController.h
//  The Pomodoro
//
//  Created by Ben Norris on 9/27/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "POProjectController.h"

@interface POProjectDetailViewController : UIViewController

- (void)updateWithProject:(POProject *)project;

@end
