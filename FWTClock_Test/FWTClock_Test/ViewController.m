//
//  ViewController.m
//  FWTClock_Test
//
//  Created by Marco Meschini on 25/09/2012.
//  Copyright (c) 2012 Marco Meschini. All rights reserved.
//

#import "ViewController.h"
#import "FWTClock.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@property (nonatomic, retain) FWTClock *clock;

@end

@implementation ViewController
@synthesize clock = _clock;

- (void)dealloc
{
    self.clock = nil;
    [super dealloc];
}

- (void)loadView
{
    [super loadView];
    
    CGRect frame = CGRectMake(.0f, .0f, 300.0f, 300.0f);
    self.clock.clockView.frame = frame;
    self.clock.clockView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
    self.clock.clockView.center = self.view.center;
    [self.view addSubview:self.clock.clockView];
    
    UIButton *b = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    b.frame = CGRectMake(10, 10, 60, 40);
    [b setTitle:@"I/O" forState:UIControlStateNormal];
    [b addTarget:self.clock action:@selector(toggle) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:b];
}

- (FWTClock *)clock
{
    if (!self->_clock)
    {
        self->_clock = [[FWTClock alloc] init];
        self->_clock.oscillatorType = FWTClockOscillatorTypeMechanical; // FWTClockOscillatorTypeQuartzSmallJump // FWTClockOscillatorTypeQuartz
//        self->_clock.clockView.subviewsMask = FWTClockSubviewBackground|FWTClockSubviewHandHour|FWTClockSubviewHandMinute|FWTClockSubviewRing;
    }
    
    return self->_clock;
}

@end
