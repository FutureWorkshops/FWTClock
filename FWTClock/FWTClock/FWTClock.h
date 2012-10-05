//
//  FWTClock.h
//  FWTClock
//
//  Created by Marco Meschini on 25/09/2012.
//  Copyright (c) 2012 Marco Meschini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FWTClockView.h"

typedef NS_ENUM(NSInteger, FWTClockOscillatorType) {
    FWTClockOscillatorTypeQuartz,
    FWTClockOscillatorTypeMechanical,
};

@interface FWTClock : NSObject

@property (nonatomic, readonly, retain) FWTClockView *clockView;
@property (nonatomic, retain) NSDate *date;
@property (nonatomic, retain) NSCalendar *calendar;
@property (nonatomic, getter = isAnimating) BOOL animating;
@property (nonatomic, assign) FWTClockOscillatorType oscillatorType;

- (void)setDate:(NSDate *)date animated:(BOOL)animated;

- (void)toggle;

@end
