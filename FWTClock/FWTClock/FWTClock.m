//
//  FWTClock.m
//  FWTClock
//
//  Created by Marco Meschini on 25/09/2012.
//  Copyright (c) 2012 Marco Meschini. All rights reserved.
//

#import "FWTClock.h"
#import <QuartzCore/QuartzCore.h>

struct FWClockDateComponents
{
    int hours;
    int minutes;
    int seconds;
};

float Degrees2Radians(float degrees) { return degrees * M_PI / 180; }

NSString *const keySecondHandAnimation = @"keySecondHandAnimation";

@interface FWTClock ()
@property (nonatomic, readwrite, retain) FWTClockView *clockView;
@end

@implementation FWTClock
@synthesize clockView = _clockView;
@synthesize date = _date;
@synthesize calendar = _calendar;

- (void)dealloc
{
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
- (struct FWClockDateComponents)_dateComponentsFromDate:(NSDate *)date
{
    NSUInteger unitFlags = NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit;
    NSDateComponents *dateComponents = [self.calendar components:unitFlags fromDate:date];
    
    struct FWClockDateComponents toReturn;
    
    toReturn.hours = [dateComponents hour];
    toReturn.minutes = [dateComponents minute];
    toReturn.seconds = [dateComponents second];
    
    return toReturn;
}

- (void)_tick
{
    NSDate *date = [NSDate date];
    [self setDate:date animated:YES];
    [self performSelector:@selector(_tick) withObject:nil afterDelay:1.0f];
}

#pragma mark - Public
- (void)setDate:(NSDate *)date
{
    [self setDate:date animated:NO];
}

- (void)setDate:(NSDate *)date animated:(BOOL)animated
{
    if (self->_date != date)
    {
        self->_date = [date retain];
        
        if (self->_date)
        {
            struct FWClockDateComponents dateComponents = [self _dateComponentsFromDate:self->_date];
            
            CGFloat newHourAngle = 0.5f * ((dateComponents.hours * 60.0f) + dateComponents.minutes);
            newHourAngle = newHourAngle > 360 ? newHourAngle - 360 : newHourAngle;
            
            CGFloat newMinuteAngle = 6.0f * dateComponents.minutes;
            newMinuteAngle = newMinuteAngle > 360 ? newMinuteAngle - 360 : newMinuteAngle;
            
            CGFloat newSecondAngle = 6.0f * dateComponents.seconds;
            newSecondAngle = newSecondAngle > 360 ? newSecondAngle - 360 : newSecondAngle;
            
            void(^rotateHourAndMinuteHands)() = ^(void) {
                self.clockView.handHourView.transform = CGAffineTransformMakeRotation(Degrees2Radians(newHourAngle));
                self.clockView.handMinuteView.transform = CGAffineTransformMakeRotation(Degrees2Radians(newMinuteAngle));
            };
            
            
            if (animated)
            {
                [UIView animateWithDuration:.2f animations:rotateHourAndMinuteHands];
                
                if (![self.clockView.handSecondView.layer animationForKey:keySecondHandAnimation])
                {
                    CGFloat radians = Degrees2Radians(newSecondAngle);
                    self.clockView.handSecondView.transform = CGAffineTransformMakeRotation(radians);
                    
                    CGFloat circleAngle = 2*M_PI+Degrees2Radians(newSecondAngle);
                    circleAngle = radians > M_PI ? circleAngle - 2*M_PI : circleAngle;
                    
                    CABasicAnimation* spinAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
                    spinAnimation.toValue = [NSNumber numberWithFloat:circleAngle];
                    spinAnimation.duration = 60.0f;
                    spinAnimation.repeatCount = INFINITY;
                    [self.clockView.handSecondView.layer addAnimation:spinAnimation forKey:keySecondHandAnimation];
                }
            }
            else
            {
                rotateHourAndMinuteHands();
                
                self.clockView.handSecondView.transform = CGAffineTransformMakeRotation(Degrees2Radians(newSecondAngle));
            }
        }
    }
}

- (void)toggle
{
    if ([self isAnimating])
    {
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        
        CALayer *pl = self.clockView.handSecondView.layer.presentationLayer;
        CGAffineTransform t = pl.affineTransform;
        [self.clockView.handSecondView.layer removeAnimationForKey:keySecondHandAnimation];
        self.clockView.handSecondView.transform = t;
    }
    else
    {
        [self _tick];
    }
    
    self.animating = !self.animating;
}

@end
