//
//  FWTClock.h
//  FWTClock
//
//  Created by Marco Meschini on 25/09/2012.
//  Copyright (c) 2012 Marco Meschini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FWTClockView.h"

CGFloat(^FWTDegrees2RadiansBlock)(CGFloat);
CGFloat(^FWTNormalizeAngleBlock)(CGFloat);

typedef NS_ENUM(NSInteger, FWTClockOscillatorType)
{
    FWTClockOscillatorTypeQuartz,
    FWTClockOscillatorTypeQuartzSmallJump,
    FWTClockOscillatorTypeMechanical,
};

struct FWTClockDateComponents
{
    int hours;
    int minutes;
    int seconds;
};

@interface FWTClock : NSObject
{
    FWTClockView *_clockView;
    NSDate *_date;
    NSCalendar *_calendar;
    FWTClockOscillatorType _oscillatorType;
}

@property (nonatomic, readonly, retain) FWTClockView *clockView;
@property (nonatomic, retain) NSDate *date;
@property (nonatomic, retain) NSCalendar *calendar;
@property (nonatomic, getter = isTicking) BOOL ticking;
@property (nonatomic, assign) FWTClockOscillatorType oscillatorType;

//
- (void)setDate:(NSDate *)date animated:(BOOL)animated;

//
- (struct FWTClockDateComponents)dateComponentsFromDate:(NSDate *)date;

//
- (void)start;
- (void)stop;
- (void)toggle;

@end
