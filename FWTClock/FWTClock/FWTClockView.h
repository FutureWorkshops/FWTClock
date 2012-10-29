//
//  FWTClockView.h
//  FWTClock
//
//  Created by Marco Meschini on 25/09/2012.
//  Copyright (c) 2012 Marco Meschini. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, FWTClockSubview) {
    FWTClockSubviewBackground   = 1UL << 0,
    FWTClockSubviewHandHour     = 1UL << 1,
    FWTClockSubviewHandMinute   = 1UL << 2,
    FWTClockSubviewHandSecond   = 1UL << 3,
    FWTClockSubviewRing         = 1UL << 4,
    FWTClockSubviewCount        = 1UL << 5,
    FWTClockSubviewAll          = FWTClockSubviewBackground|FWTClockSubviewHandHour|FWTClockSubviewHandMinute|FWTClockSubviewHandSecond|FWTClockSubviewRing,
};

@class FWTClockView;
@protocol FWTClockViewAppearance <NSObject>
+ (UIView *)clockView:(FWTClockView *)clockView viewForClockSubview:(FWTClockSubview)clockSubview;
@end

@interface FWTClockView : UIView

@property (nonatomic, assign) UIEdgeInsets edgeInsets;
@property (nonatomic, retain) UIView *backgroundView;
@property (nonatomic, retain) UIView *handHourView;
@property (nonatomic, retain) UIView *handMinuteView;
@property (nonatomic, retain) UIView *handSecondView;
@property (nonatomic, retain) UIView *ringView;
@property (nonatomic, assign) FWTClockSubview subviewsMask;     //  default is FWTClockSubviewAll
@property (nonatomic, retain) Class appearanceClass;

+ (Class)defaultAppearanceClass;

@end
