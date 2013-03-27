//
//  ViewController.m
//  FWTClock_Test
//
//  Created by Marco Meschini on 25/09/2012.
//  Copyright (c) 2012 Marco Meschini. All rights reserved.
//

#import "DefaultViewController.h"

@implementation DefaultViewController

- (void)dealloc
{
    self.clock = nil;
    [super dealloc];
}

- (void)loadView
{
    [super loadView];
    
    //
    UIEdgeInsets insets = UIEdgeInsetsMake(35.0f, 25.0f, 50.0f, 25.0f);
    CGRect frame = CGRectMake(.0f, .0f, 270.0f, 270.0f);
    self.clock.clockView.frame = frame;
    [self setTableHeaderView:self.clock.clockView insets:insets];

    //
    NSMethodSignature *signature = [FWTClock instanceMethodSignatureForSelector:@selector(toggle)];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:self.clock];
    [invocation setSelector:@selector(toggle)];
    self.items = @[invocation];
    
    //
    self.configureCellBlock = ^(RistrettoTableViewController *vc, UITableViewCell *cell, NSIndexPath *indexPath, id item){
        cell.textLabel.text = @"start/stop";
    };
    
    self.didSelectCellBlock = ^(RistrettoTableViewController *vc, UITableViewCell *cell, NSIndexPath *indexPath, id item){
        [item invoke];
        [vc.tableView deselectRowAtIndexPath:indexPath animated:YES];
    };
}

#pragma mark - Accessors
- (FWTClock *)clock
{
    if (!self->_clock)
    {
        self->_clock = [[FWTClock alloc] init];
        self->_clock.oscillatorType = FWTClockOscillatorTypeMechanical;
    }
    
    return self->_clock;
}

@end
