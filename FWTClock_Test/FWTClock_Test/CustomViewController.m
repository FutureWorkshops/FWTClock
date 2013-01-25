//
//  CustomViewController.m
//  FWTClock_Test
//
//  Created by Marco Meschini on 25/01/2013.
//  Copyright (c) 2013 Marco Meschini. All rights reserved.
//

#import "CustomViewController.h"
#import "FWTClock.h"
#import <QuartzCore/QuartzCore.h>

@implementation CustomViewController
@synthesize clock = _clock;

- (FWTClock *)clock
{
    if (!self->_clock)
    {
        self->_clock = [[FWTClock alloc] init];
        self->_clock.oscillatorType = FWTClockOscillatorTypeQuartzSmallJump;
        self->_clock.clockView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
    
        __block FWTClockViewClockSubviewBlock superBlock = self->_clock.clockView.clockSubviewBlock;
        self->_clock.clockView.clockSubviewBlock = ^(FWTClockSubview clockSubview){
            UIView *toReturn = superBlock(clockSubview);
            switch (clockSubview)
            {
                case FWTClockSubviewBackground:
                case FWTClockSubviewRing:
                {
                    [(FWTClockBackgroundView *)toReturn shapeLayer].fillColor = [UIColor blackColor].CGColor;
                    [(FWTClockBackgroundView *)toReturn shapeLayer].strokeColor = [UIColor whiteColor].CGColor;
                
                } break;
                    
                case FWTClockSubviewHandHour:
                case FWTClockSubviewHandMinute:
                {
                    [(FWTClockHandView *)toReturn shapeLayer].strokeColor = [UIColor colorWithWhite:.5f alpha:1.0f].CGColor;
                
                } break;
                    
                default: break;
            }
            
            return toReturn;
        };
    }
    
    return self->_clock;
}

@end
