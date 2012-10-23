//
//  FWTClockViewFactory.m
//  FWTClock
//
//  Created by Marco Meschini on 26/09/2012.
//  Copyright (c) 2012 Marco Meschini. All rights reserved.
//

#import "FWTClockViewFactory.h"
#import "FWTClockBackgroundView.h"
#import "FWTClockHandView.h"
#import "FWTClockRingView.h"

@implementation FWTClockViewFactory

+ (UIView *)_styleDayDefaultViewForClockSubview:(FWTClockSubview)clockSubview
{
    switch (clockSubview)
    {
        case FWTClockSubviewBackground:
        {
            //
            CGRect relativeFrame = CGRectMake(.0f, .0f, 1.0f, 1.0f);
            FWTClockBackgroundView *toReturn = [[[FWTClockBackgroundView alloc] initWithFrame:relativeFrame] autorelease];
            toReturn.shapeLayer.fillColor = [UIColor colorWithWhite:.875f alpha:1.0f].CGColor;
            toReturn.shapeLayer.strokeColor = [UIColor blackColor].CGColor;
            return toReturn;
        } 
            
        case FWTClockSubviewHandHour:
        {
            //
            FWTClockHandView *toReturn = [[[FWTClockHandView alloc] init] autorelease];
            toReturn.start = .2f;
            toReturn.end = .55f;
            toReturn.frame = CGRectMake(.0f, .0f, .051020f, 1.0f);//.204082f);
            toReturn.shapeLayer.strokeColor = [UIColor colorWithWhite:.5f alpha:.5f].CGColor;
            return toReturn;
        } 
            
        case FWTClockSubviewHandMinute:
        {
            FWTClockHandView *toReturn = [[[FWTClockHandView alloc] init] autorelease];
            toReturn.start = .125f;
            toReturn.end = .55f;
            toReturn.frame = CGRectMake(.0f, .0f, .040816f, 1.0f);//.357143f);
            toReturn.shapeLayer.strokeColor = [UIColor colorWithWhite:.7f alpha:.5f].CGColor;
            return toReturn;
        } 
            
        case FWTClockSubviewHandSecond:
        {
            FWTClockHandView *toReturn = [[[FWTClockHandView alloc] init] autorelease];
            toReturn.start = .05f;
            toReturn.end = .575f;
            toReturn.frame = CGRectMake(.0f, .0f, .025510f, 1.0f);//.438163f);
            toReturn.shapeLayer.fillColor = [UIColor redColor].CGColor;
            return toReturn;
        } 
            
        case FWTClockSubviewRing:
        {
            CGRect relativeFrame = CGRectMake(.0f, .0f, .06f, .06f);
            FWTClockRingView *toReturn = [[[FWTClockRingView alloc] initWithFrame:relativeFrame] autorelease];
            toReturn.shapeLayer.fillColor = [UIColor colorWithWhite:.9f alpha:1.0f].CGColor;
            toReturn.shapeLayer.strokeColor = [UIColor blackColor].CGColor;
            return toReturn;
        }
            
        default:
            break;
    }
    
    return nil;
}

+ (UIView *)_styleNightDefaultViewForClockSubview:(FWTClockSubview)clockSubview
{
    switch (clockSubview)
    {
        case FWTClockSubviewBackground:
        {
            //
            CGRect relativeFrame = CGRectMake(.0f, .0f, 1.0f, 1.0f);
            FWTClockBackgroundView *toReturn = [[[FWTClockBackgroundView alloc] initWithFrame:relativeFrame] autorelease];
            toReturn.shapeLayer.fillColor = [UIColor blackColor].CGColor;
            return toReturn;
        }
            
        case FWTClockSubviewHandHour:
        {
            //
            FWTClockHandView *toReturn = [[[FWTClockHandView alloc] init] autorelease];
            toReturn.start = .2f;
            toReturn.end = .55f;
            toReturn.frame = CGRectMake(.0f, .0f, .051020f, 1.0f);//.204082f);
            toReturn.shapeLayer.fillColor = [UIColor colorWithWhite:.9f alpha:1.0f].CGColor;
//            toReturn.shapeLayer.strokeColor = [UIColor colorWithWhite:.5f alpha:.5f].CGColor;
            return toReturn;
        }
            
        case FWTClockSubviewHandMinute:
        {
            FWTClockHandView *toReturn = [[[FWTClockHandView alloc] init] autorelease];
            toReturn.start = .125f;
            toReturn.end = .55f;
            toReturn.frame = CGRectMake(.0f, .0f, .040816f, 1.0f);//.357143f);
            toReturn.shapeLayer.fillColor = [UIColor colorWithWhite:.9f alpha:1.0f].CGColor;
//            toReturn.shapeLayer.strokeColor = [UIColor colorWithWhite:.7f alpha:.f].CGColor;
            return toReturn;
        }
            
        case FWTClockSubviewHandSecond:
        {
            FWTClockHandView *toReturn = [[[FWTClockHandView alloc] init] autorelease];
            toReturn.start = .05f;
            toReturn.end = .6f;
            toReturn.frame = CGRectMake(.0f, .0f, .033510f, 1.0f);//.438163f);
            toReturn.shapeLayer.fillColor = [UIColor whiteColor].CGColor;
            return toReturn;
        }
            
        case FWTClockSubviewRing:
        {
            CGRect relativeFrame = CGRectMake(.0f, .0f, .06f, .06f);
            FWTClockRingView *toReturn = [[[FWTClockRingView alloc] initWithFrame:relativeFrame] autorelease];
            toReturn.shapeLayer.fillColor = [UIColor colorWithWhite:.9f alpha:1.0f].CGColor;
            toReturn.shapeLayer.strokeColor = [UIColor blackColor].CGColor;
            return toReturn;
        }
            
        default:
            break;
    }
    
    return nil;
}

+ (UIView *)defaultViewForClockSubview:(FWTClockSubview)clockSubview style:(FWTClockViewStyle)style
{
    switch (style)
    {
        case FWTClockViewStyleDay:
            return [[self class] _styleDayDefaultViewForClockSubview:clockSubview];
            
        case FWTClockViewStyleNight:
            return [[self class] _styleNightDefaultViewForClockSubview:clockSubview];
            
        default:
            break;
    }
}

+ (void)applyDefaultsToClockView:(FWTClockView *)clockView forIndexes:(NSIndexSet *)indexes style:(FWTClockViewStyle)style
{
    if ([indexes containsIndex:FWTClockSubviewBackground])
        clockView.backgroundView = [[self class] defaultViewForClockSubview:FWTClockSubviewBackground style:style];
    
    if ([indexes containsIndex:FWTClockSubviewHandHour])
        clockView.handHourView   = [[self class] defaultViewForClockSubview:FWTClockSubviewHandHour style:style];
    
    if ([indexes containsIndex:FWTClockSubviewHandMinute])
        clockView.handMinuteView = [[self class] defaultViewForClockSubview:FWTClockSubviewHandMinute style:style];
    
    if ([indexes containsIndex:FWTClockSubviewHandSecond])
        clockView.handSecondView = [[self class] defaultViewForClockSubview:FWTClockSubviewHandSecond style:style];
    
    if ([indexes containsIndex:FWTClockSubviewRing])
        clockView.ringView       = [[self class] defaultViewForClockSubview:FWTClockSubviewRing style:style];
}

@end
