//
//  FWTClockView.h
//  FWTClock
//
//  Created by Marco Meschini on 25/09/2012.
//  Copyright (c) 2012 Marco Meschini. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, FWTClockSubview) {
    FWTClockSubviewBackground,
    FWTClockSubviewHandHour,
    FWTClockSubviewHandMinute,
    FWTClockSubviewHandSecond,
    FWTClockSubviewRing,
    FWTClockSubviewCount,
};

typedef NS_ENUM(NSInteger, FWTClockViewStyle) {
    FWTClockViewStyleDay,
    FWTClockViewStyleNight,
};

@interface FWTClockView : UIView

@property (nonatomic, assign) UIEdgeInsets edgeInsets;
@property (nonatomic, retain) UIView *backgroundView;
@property (nonatomic, retain) UIView *handHourView;
@property (nonatomic, retain) UIView *handMinuteView;
@property (nonatomic, retain) UIView *handSecondView;
@property (nonatomic, retain) UIView *ringView;
@property (nonatomic, assign) FWTClockViewStyle style;

@end
