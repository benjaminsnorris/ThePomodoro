//
//  PORoundsTableViewCell.m
//  The Pomodoro
//
//  Created by Ben Norris on 9/25/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "PORoundsTableViewCell.h"

@implementation PORoundsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    UIView *selectedView = [UIView new];
    selectedView.backgroundColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.2];
    [self setSelectedBackgroundView:selectedView];
    
    [self.textLabel setFont:[UIFont fontWithName:@"Avenir Next" size:18]];
    
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
