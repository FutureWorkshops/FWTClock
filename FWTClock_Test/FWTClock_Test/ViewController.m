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

@interface ViewController () <FWTClockViewAppearance>

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
    
    //
    self.clock.clockView.center = self.view.center;
    [self.view addSubview:self.clock.clockView];
    
    //
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
        self->_clock.clockView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
        self->_clock.clockView.frame = CGRectMake(.0f, .0f, 300.0f, 300.0f);
        
//        //  change the bitmask
//        self->_clock.clockView.subviewsMask = FWTClockSubviewHandHour|FWTClockSubviewHandMinute|FWTClockSubviewHandSecond;
        
//        //  override appearance
//        self->_clock.clockView.appearanceClass = [self class];
    }
    
    return self->_clock;
}

#pragma mark - FWTClockViewAppearance
+ (UIView *)clockView:(FWTClockView *)clockView viewForClockSubview:(FWTClockSubview)clockSubview
{
    if (clockSubview == FWTClockSubviewBackground)
    {
        UIView *v = [[[UIView alloc] initWithFrame:CGRectMake(.0f, .0f, 150, 130)] autorelease];
        v.backgroundColor = [UIColor colorWithWhite:.9f alpha:.5f];
        v.layer.borderWidth = 1.0f;
        
        return v;
    }
    else
        return [[FWTClockView defaultAppearanceClass] clockView:clockView viewForClockSubview:clockSubview];
}

@end
