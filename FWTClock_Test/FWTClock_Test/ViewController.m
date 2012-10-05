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
    
    //
    UIButton *b = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    b.frame = CGRectMake(10, 10, 60, 40);
    [b addTarget:self.clock action:@selector(toggle) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:b];
    
}

- (FWTClock *)clock
{
    if (!self->_clock)
    {
        self->_clock = [[FWTClock alloc] init];
        self->_clock.oscillatorType = FWTClockOscillatorTypeMechanical;
        
//        self->_clock.clockView.style = FWTClockViewStyleNight;
     
//        UIView *backgroundView = [[[BackgroundView alloc] init] autorelease];
//        self->_clock.clockView.backgroundView = backgroundView;
        
//        HandView *handHourView = [[[HandView alloc] init] autorelease];
//        handHourView.layer.anchorPoint = CGPointMake(.5f , 1.0f);
//        handHourView.relativeSize = CGSizeMake(.051020f, .204082f);
//        handHourView.relativeSize = CGSizeMake(.051020f, 1.0f);
//        handHourView.shapeLayer.strokeColor = [UIColor colorWithWhite:.5f alpha:.5f].CGColor;
//        self->_clock.clockView.handHourView = handHourView;
//        
//        HandView *handMinuteView = [[[HandView alloc] init] autorelease];
//        handMinuteView.layer.anchorPoint = CGPointMake(.5f , 1.0f);
//        handMinuteView.relativeSize = CGSizeMake(.040816f, .357143f);
//        handMinuteView.shapeLayer.strokeColor = [UIColor colorWithWhite:.5f alpha:.5f].CGColor;
//        self->_clock.clockView.handMinuteView = handMinuteView;
//        
//        HandView *handSecondView = [[[HandView alloc] init] autorelease];
//        handSecondView.layer.anchorPoint = CGPointMake(.5f , 1.0f);
//        handSecondView.relativeSize = CGSizeMake(.033510f, .438163f);
//        handSecondView.shapeLayer.fillColor = [UIColor redColor].CGColor;
//        self->_clock.clockView.handSecondView = handSecondView;
//        
//        UIView *ringView = [[[UIView alloc] initWithFrame:CGRectMake(.0f, .0f, 8.0f, 8.0f)] autorelease];
//        ringView.backgroundColor = [UIColor colorWithWhite:.9f alpha:1.0f];
//        ringView.layer.cornerRadius = CGRectGetWidth(ringView.frame)*.5f;
//        ringView.layer.borderWidth = 1.0f;
//        self->_clock.clockView.ringView = ringView;
        
//        UIView *handMinuteView = [[[UIView alloc] initWithFrame:CGRectMake(.0f, .0f, .040816f, .357143f)] autorelease];
//        handMinuteView.backgroundColor = [UIColor greenColor];
//        handMinuteView.layer.anchorPoint = CGPointMake(.5f , 1.0f);
//        self->_clock.clockView.handMinuteView = handMinuteView;
    }
    
    return self->_clock;
}

@end
