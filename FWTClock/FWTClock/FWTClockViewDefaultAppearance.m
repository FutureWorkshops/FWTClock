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
        CGRect availableRect = CGRectInset(shapeView.bounds, 2, 2);
        return [UIBezierPath bezierPathWithOvalInRect:availableRect].CGPath;
    };
    
    //
    FWTClockShapeViewPathBlock handPathBlock = ^(FWTClockShapeView *shapeView){
        FWTClockHandView *castedView = (FWTClockHandView *)shapeView;
        CGRect currentShapeLayerPathRect = CGRectInset(castedView.bounds, castedView.horizontalInset, .0f);
        currentShapeLayerPathRect.origin.y += (currentShapeLayerPathRect.size.height * castedView.start);
        currentShapeLayerPathRect.size.height *= (castedView.end-castedView.start);
        return [UIBezierPath bezierPathWithRect:currentShapeLayerPathRect].CGPath;
    };
    
    switch (clockSubview)
    {
        case FWTClockSubviewBackground:
        {
            //
            CGRect relativeFrame = CGRectMake(.0f, .0f, 1.0f, 1.0f);
            FWTClockBackgroundView *toReturn = [[[FWTClockBackgroundView alloc] initWithFrame:relativeFrame] autorelease];
            toReturn.shapeLayer.fillColor = [UIColor colorWithWhite:.875f alpha:1.0f].CGColor;
            toReturn.shapeLayer.strokeColor = [UIColor blackColor].CGColor;
            toReturn.pathBlock = ellipsePathBlock;
            return toReturn;
        }
            
        case FWTClockSubviewHandHour:
        {
            //
            FWTClockHandView *toReturn = [[[FWTClockHandView alloc] init] autorelease];
            toReturn.start = .2f;
            toReturn.end = .55f;
            toReturn.frame = CGRectMake(.0f, .0f, .051020f, 1.0f);
            toReturn.shapeLayer.strokeColor = [UIColor colorWithWhite:.5f alpha:.5f].CGColor;
            toReturn.pathBlock = handPathBlock;
            return toReturn;
        }
            
        case FWTClockSubviewHandMinute:
        {
            FWTClockHandView *toReturn = [[[FWTClockHandView alloc] init] autorelease];
            toReturn.start = .125f;
            toReturn.end = .55f;
            toReturn.frame = CGRectMake(.0f, .0f, .040816f, 1.0f);
            toReturn.shapeLayer.strokeColor = [UIColor colorWithWhite:.7f alpha:.5f].CGColor;
            toReturn.pathBlock = handPathBlock;
            return toReturn;
        }
            
        case FWTClockSubviewHandSecond:
        {
            FWTClockHandView *toReturn = [[[FWTClockHandView alloc] init] autorelease];
            toReturn.start = .05f;
            toReturn.end = .575f;
            toReturn.frame = CGRectMake(.0f, .0f, .025510f, 1.0f);
            toReturn.shapeLayer.fillColor = [UIColor redColor].CGColor;
            toReturn.pathBlock = handPathBlock;
            return toReturn;
        }
            
        case FWTClockSubviewRing:
        {
            CGRect relativeFrame = CGRectMake(.0f, .0f, .06f, .06f);
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
