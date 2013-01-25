//
//  ViewController.m
//  FWTClock_Test
//
//  Created by Marco Meschini on 25/09/2012.
//  Copyright (c) 2012 Marco Meschini. All rights reserved.
//

#import "DefaultViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation DefaultViewController
@synthesize clock = _clock;

- (void)dealloc
{
    self.clock = nil;
    [super dealloc];
}

- (id)init
{
    if (self = [super init])
    {
        self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Start"
                                                                                   style:UIBarButtonItemStyleBordered
                                                                                  target:self
                                                                                  action:@selector(_doAction:)] autorelease];
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    //
    CGFloat min = sideWidthBlock(self.view.frame, 20.0f);
    self.clock.clockView.bounds = CGRectMake(0, 0, min, min);
    self.clock.clockView.center = self.view.center;
    [self.view addSubview:self.clock.clockView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    CGFloat min = sideWidthBlock(self.view.frame, 20.0f);
    if (min != CGRectGetWidth(self.clock.clockView.bounds))
        self.clock.clockView.bounds = CGRectMake(0, 0, min, min);
}

#pragma mark - Accessors
- (FWTClock *)clock
{
    if (!self->_clock)
    {
        self->_clock = [[FWTClock alloc] init];
        self->_clock.oscillatorType = FWTClockOscillatorTypeMechanical; // FWTClockOscillatorTypeQuartzSmallJump // FWTClockOscillatorTypeQuartz
        self->_clock.clockView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
    }
    
    return self->_clock;
}

#pragma mark - Private
- (void)_doAction:(id)sender
{
    [self.clock toggle];
    self.navigationItem.rightBarButtonItem.title = [self.clock isTicking] ? @"Stop" : @"Start";
}

@end
