//
//  FWTClock.m
//  FWTClock
//
//  Created by Marco Meschini on 25/09/2012.
//  Copyright (c) 2012 Marco Meschini. All rights reserved.
//

#import "FWTClock.h"
#import <QuartzCore/QuartzCore.h>

float FWTDegrees2Radians(float degrees) { return degrees * M_PI / 180; }

NSString *const keySecondHandAnimation = @"keySecondHandAnimation";

@interface FWTClock ()
@property (nonatomic, readwrite, retain) FWTClockView *clockView;
@property (nonatomic, retain) NSOperationQueue *queue;
@end

@implementation FWTClock
@synthesize clockView = _clockView;
@synthesize date = _date;
@synthesize calendar = _calendar;

- (void)dealloc
{
    [self.queue cancelAllOperations];
    self.queue = nil;
    self.calendar = nil;
    self.date = nil;
    self.clockView = nil;
    [super dealloc];
}

#pragma mark - Getters
- (FWTClockView *)clockView
{
    if (!self->_clockView)
        self->_clockView = [[FWTClockView alloc] init];
    
    return self->_clockView;
}

- (NSCalendar *)calendar
{
    if (!self->_calendar)
        self->_calendar = [[NSCalendar currentCalendar] retain];
    
    return self->_calendar;
}

#pragma mark - Private
- (void)_tick
{
    __block typeof(self) myself = self;
    NSOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        [myself setDate:[NSDate date] animated:YES];
        [NSThread sleepForTimeInterval:1];
    }];
    op.completionBlock = ^{[self _tick];};
    [self.queue addOperation:op];
}

#pragma mark - Public
- (struct FWTClockDateComponents)dateComponentsFromDate:(NSDate *)date
{
    NSUInteger unitFlags = NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit;
    NSDateComponents *dateComponents = [self.calendar components:unitFlags fromDate:date];
    
    struct FWTClockDateComponents toReturn = {
        .hours   = [dateComponents hour],
        .minutes = [dateComponents minute],
        .seconds = [dateComponents second],
    };
    
    return toReturn;
}

- (void)setDate:(NSDate *)date
{
    [self setDate:date animated:NO];
}

- (void)setDate:(NSDate *)date animated:(BOOL)animated
{
    if (self->_date != date)
    {
        [self->_date release];
        self->_date = nil;
        
        self->_date = [date retain];
        
        if (self->_date)
        {
            __block typeof(self) myself = self;
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                CGFloat(^normalizeAngle)(CGFloat) = ^(CGFloat angle){
                    return angle > 360 ? angle - 360 : angle;
                };
                
                struct FWTClockDateComponents dateComponents = [self dateComponentsFromDate:self->_date];
                CGFloat newHourAngle = normalizeAngle(0.5f * ((dateComponents.hours * 60.0f) + dateComponents.minutes));
                CGFloat newMinuteAngle = normalizeAngle(6.0f * dateComponents.minutes);
                CGFloat newSecondAngle = normalizeAngle(6.0f * dateComponents.seconds);
                
                void(^rotateHourAndMinuteHands)() = ^(void) {
                    myself.clockView.handHourView.transform = CGAffineTransformMakeRotation(FWTDegrees2Radians(newHourAngle));
                    myself.clockView.handMinuteView.transform = CGAffineTransformMakeRotation(FWTDegrees2Radians(newMinuteAngle));
                    
                    if (myself.oscillatorType == FWTClockOscillatorTypeQuartz)
                        myself.clockView.handSecondView.transform = CGAffineTransformMakeRotation(FWTDegrees2Radians(newSecondAngle));
                };
                
                if (animated)
                {
                    [UIView animateWithDuration:.2f animations:rotateHourAndMinuteHands];
                    
                    if (![myself.clockView.handSecondView.layer animationForKey:keySecondHandAnimation] && myself.oscillatorType == FWTClockOscillatorTypeMechanical)
                    {
                        CGFloat radians = FWTDegrees2Radians(newSecondAngle);
                        myself.clockView.handSecondView.transform = CGAffineTransformMakeRotation(radians);
                        
                        CGFloat circleAngle = 2*M_PI+FWTDegrees2Radians(newSecondAngle);
                        circleAngle = radians > M_PI ? circleAngle - 2*M_PI : circleAngle;
                        
                        CABasicAnimation* spinAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
                        spinAnimation.toValue = [NSNumber numberWithFloat:circleAngle];
                        spinAnimation.duration = 60.0f;
                        spinAnimation.repeatCount = INFINITY;
                        [myself.clockView.handSecondView.layer addAnimation:spinAnimation forKey:keySecondHandAnimation];
                    }
                }
                else
                {
                    rotateHourAndMinuteHands();
                    
                    myself.clockView.handSecondView.transform = CGAffineTransformMakeRotation(FWTDegrees2Radians(newSecondAngle));
                }
            }];
        }
    }
}

- (void)setOscillatorType:(FWTClockOscillatorType)oscillatorType
{
    if (self->_oscillatorType != oscillatorType)
    {
        self->_oscillatorType = oscillatorType;

        if ([self isTicking])
        {
            [self stop];  // first stop
            [self start];  // then restart
        }
    }
}

- (void)start
{
    if (![self isTicking])
    {
        self.queue = [[[NSOperationQueue alloc] init] autorelease];
        [self _tick];
        
        //
        self.ticking = YES;
    }
}

- (void)stop
{
    if ([self isTicking])
    {
        //
        [self.queue cancelAllOperations];
        self.queue = nil;
        
        //
        if (self.oscillatorType == FWTClockOscillatorTypeMechanical)
        {
            __block typeof(self) myself = self;
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                CALayer *pl = myself.clockView.handSecondView.layer.presentationLayer;
                CGAffineTransform t = pl.affineTransform;
                [myself.clockView.handSecondView.layer removeAnimationForKey:keySecondHandAnimation];
                myself.clockView.handSecondView.transform = t;
            }];
        }
     
        //
        self.ticking = NO;
    }
}

- (void)toggle
{
    [self isTicking] ? [self stop] : [self start];
}


@end
