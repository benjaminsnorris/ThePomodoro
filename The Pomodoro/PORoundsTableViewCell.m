//
//  PORoundsTableViewCell.m
//  The Pomodoro
//
//  Created by Ben Norris on 9/25/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "PORoundsTableViewCell.h"

#define margin 5

@implementation PORoundsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    [self.textLabel setFont:[UIFont fontWithName:@"Avenir Next" size:18]];

    UIView *selectedView = [UIView new];
    selectedView.backgroundColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.2];
    
    CGFloat progressSize = self.bounds.size.height - (margin * 1);
    self.progressView = [[POCircleProgressView alloc] initWithFrame:CGRectMake(self.bounds.size.width - progressSize - margin, margin, progressSize, progressSize)];
    self.progressView.fillColor = [UIColor redColor];
    self.progressView.fillBackgroundColor = nil;
    self.progressView.borderColor = nil;
    [selectedView addSubview:self.progressView];
    
    [self setSelectedBackgroundView:selectedView];

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
