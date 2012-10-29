//
//  FWTClockAppearance.m
//  FWTClock
//
//  Created by Marco Meschini on 28/10/2012.
//  Copyright (c) 2012 Marco Meschini. All rights reserved.
//

#import "FWTClockViewDefaultAppearance.h"
#import "FWTClockShapeView.h"
#import "FWTClockBackgroundView.h"
#import "FWTClockHandView.h"

@implementation FWTClockViewDefaultAppearance

+ (UIView *)clockView:(FWTClockView *)clockView viewForClockSubview:(FWTClockSubview)clockSubview
{
    //
    FWTClockShapeViewPathBlock ellipsePathBlock = ^(FWTClockShapeView *shapeView){
        CGRect availableRect = UIEdgeInsetsInsetRect(shapeView.bounds, shapeView.edgeInsets);
        return [UIBezierPath bezierPathWithOvalInRect:availableRect].CGPath;
    };
    
    //
    FWTClockShapeViewPathBlock handPathBlock = ^(FWTClockShapeView *shapeView){
        FWTClockHandView *castedView = (FWTClockHandView *)shapeView;
        CGRect availableRect = UIEdgeInsetsInsetRect(castedView.bounds, shapeView.edgeInsets);
        availableRect.origin.y += (availableRect.size.height * castedView.start);
        availableRect.size.height *= (castedView.end-castedView.start);
        return [UIBezierPath bezierPathWithRect:availableRect].CGPath;
    };
    
    switch (clockSubview)
    {
        case FWTClockSubviewBackground:
        {
            //
            CGRect relativeFrame = CGRectMake(.0f, .0f, 1.0f, 1.0f);
//            CGRect relativeFrame = CGRectMake(.0f, .0f, 200.0f, 200.0f);
            FWTClockBackgroundView *toReturn = [[[FWTClockBackgroundView alloc] initWithFrame:relativeFrame] autorelease];
            toReturn.shapeLayer.fillColor = [UIColor colorWithWhite:.875f alpha:1.0f].CGColor;
            toReturn.shapeLayer.strokeColor = [UIColor blackColor].CGColor;
            toReturn.pathBlock = ellipsePathBlock;
            return toReturn;
        }
            
        case FWTClockSubviewHandHour:
        {
            //
            CGRect relativeFrame = CGRectMake(.0f, .0f, .051020f, 1.0f);
//            CGRect relativeFrame = CGRectMake(.0f, .0f, 12.0f, 300.0f);
            FWTClockHandView *toReturn = [[[FWTClockHandView alloc] initWithFrame:relativeFrame] autorelease];
            toReturn.start = .2f;
            toReturn.end = .55f;
            toReturn.shapeLayer.strokeColor = [UIColor colorWithWhite:.5f alpha:.5f].CGColor;
            toReturn.pathBlock = handPathBlock;
            return toReturn;
        }
            
        case FWTClockSubviewHandMinute:
        {
            CGRect relativeFrame = CGRectMake(.0f, .0f, .040816f, 1.0f);
//            CGRect relativeFrame = CGRectMake(.0f, .0f, 10.0f, 300.0f);
            FWTClockHandView *toReturn = [[[FWTClockHandView alloc] initWithFrame:relativeFrame] autorelease];
            toReturn.start = .125f;
            toReturn.end = .55f;
            toReturn.shapeLayer.strokeColor = [UIColor colorWithWhite:.7f alpha:.5f].CGColor;
            toReturn.pathBlock = handPathBlock;
            return toReturn;
        }
            
        case FWTClockSubviewHandSecond:
        {
            CGRect relativeFrame = CGRectMake(.0f, .0f, .025510f, 1.0f);
//            CGRect relativeFrame = CGRectMake(.0f, .0f, 7.0f, 300.0f);
            FWTClockHandView *toReturn = [[[FWTClockHandView alloc] initWithFrame:relativeFrame] autorelease];
            toReturn.start = .05f;
            toReturn.end = .575f;
            toReturn.shapeLayer.fillColor = [UIColor redColor].CGColor;
            toReturn.pathBlock = handPathBlock;
            return toReturn;
        }
            
        case FWTClockSubviewRing:
        {
            CGRect relativeFrame = CGRectMake(.0f, .0f, .06f, .06f);
//            CGRect relativeFrame = CGRectMake(.0f, .0f, 15.0f, 15.0f);
            FWTClockShapeView *toReturn = [[[FWTClockShapeView alloc] initWithFrame:relativeFrame] autorelease];
            toReturn.shapeLayer.fillColor = [UIColor colorWithWhite:.9f alpha:1.0f].CGColor;
            toReturn.shapeLayer.strokeColor = [UIColor blackColor].CGColor;
            toReturn.pathBlock = ellipsePathBlock;
            return toReturn;
        }
            
        default: break;
    }
    
    return nil;
}

@end
