//
//  FWTClock.h
//  FWTClock
//
//  Created by Marco Meschini on 25/09/2012.
//  Copyright (c) 2012 Marco Meschini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FWTClockView.h"

@interface FWTClock : NSObject

@property (nonatomic, readonly, retain) FWTClockView *clockView;
@property (nonatomic, retain) NSDate *date;
@property (nonatomic, retain) NSCalendar *calendar;
@property (nonatomic, getter = isAnimating) BOOL animating;

- (void)setDate:(NSDate *)date animated:(BOOL)animated;

- (void)toggle;

@end
