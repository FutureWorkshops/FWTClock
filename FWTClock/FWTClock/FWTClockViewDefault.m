//
//  FWTClockAppearance.m
//  FWTClock
//
//  Created by Marco Meschini on 28/10/2012.
//  Copyright (c) 2012 Marco Meschini. All rights reserved.
//

#import "FWTClockViewDefault.h"
#import "FWTClockShapeView.h"
#import "FWTClockBackgroundView.h"
#import "FWTClockHandView.h"

@implementation FWTClockViewDefault

+ (FWTClockViewClockSubviewBlock)defaultClockSubviewBlock
{
    FWTClockViewClockSubviewBlock toReturn = ^(FWTClockSubview clockSubview){
        
        static dispatch_once_t onceToken;
        static FWTClockShapeViewPathBlock ellipsePathBlock = nil;
        static FWTClockShapeViewPathBlock handPathBlock = nil;
        dispatch_once(&onceToken, ^{
            ellipsePathBlock = ^(FWTClockShapeView *shapeView){
                CGRect availableRect = UIEdgeInsetsInsetRect(shapeView.bounds, shapeView.edgeInsets);
                return [UIBezierPath bezierPathWithOvalInRect:availableRect].CGPath;
            };
            
            handPathBlock = ^(FWTClockShapeView *shapeView){
                FWTClockHandView *castedView = (FWTClockHandView *)shapeView;
                CGRect availableRect = UIEdgeInsetsInsetRect(castedView.bounds, shapeView.edgeInsets);
                availableRect.origin.y += (availableRect.size.height * castedView.start);
                availableRect.size.height *= (castedView.end-castedView.start);
                return [UIBezierPath bezierPathWithRect:availableRect].CGPath;
            };
        });

        switch (clockSubview)
        {
            case FWTClockSubviewBackground:
            {
                CGRect relativeFrame = CGRectMake(.0f, .0f, 1.0f, 1.0f);    // CGRectMake(.0f, .0f, 200.0f, 200.0f);
                FWTClockBackgroundView *view = [[[FWTClockBackgroundView alloc] initWithFrame:relativeFrame] autorelease];
                view.shapeLayer.fillColor = [UIColor colorWithWhite:.875f alpha:1.0f].CGColor;
                view.shapeLayer.strokeColor = [UIColor blackColor].CGColor;
                view.pathBlock = ellipsePathBlock;
                return (UIView *)view;
            }
                
            case FWTClockSubviewHandHour:
            {
                CGRect relativeFrame = CGRectMake(.0f, .0f, .051020f, 1.0f);    // CGRectMake(.0f, .0f, 12.0f, 300.0f);
                FWTClockHandView *view = [[[FWTClockHandView alloc] initWithFrame:relativeFrame] autorelease];
                view.start = .2f;
                view.end = .55f;
                view.shapeLayer.strokeColor = [UIColor colorWithWhite:.5f alpha:.5f].CGColor;
                view.pathBlock = handPathBlock;
                return (UIView *)view;
            }
                
            case FWTClockSubviewHandMinute:
            {
                CGRect relativeFrame = CGRectMake(.0f, .0f, .040816f, 1.0f);    // CGRectMake(.0f, .0f, 10.0f, 300.0f);
                FWTClockHandView *view = [[[FWTClockHandView alloc] initWithFrame:relativeFrame] autorelease];
                view.start = .125f;
                view.end = .55f;
                view.shapeLayer.strokeColor = [UIColor colorWithWhite:.7f alpha:.5f].CGColor;
                view.pathBlock = handPathBlock;
                return (UIView *)view;
            }
                
            case FWTClockSubviewHandSecond:
            {
                CGRect relativeFrame = CGRectMake(.0f, .0f, .025510f, 1.0f);    // CGRectMake(.0f, .0f, 7.0f, 300.0f);
                FWTClockHandView *view = [[[FWTClockHandView alloc] initWithFrame:relativeFrame] autorelease];
                view.start = .05f;
                view.end = .575f;
                view.shapeLayer.fillColor = [UIColor redColor].CGColor;
                view.pathBlock = handPathBlock;
                return (UIView *)view;
            }
                
            case FWTClockSubviewRing:
            {
                CGRect relativeFrame = CGRectMake(.0f, .0f, .06f, .06f);    // CGRectMake(.0f, .0f, 15.0f, 15.0f);
                FWTClockShapeView *view = [[[FWTClockShapeView alloc] initWithFrame:relativeFrame] autorelease];
                view.shapeLayer.fillColor = [UIColor colorWithWhite:.9f alpha:1.0f].CGColor;
                view.shapeLayer.strokeColor = [UIColor blackColor].CGColor;
                view.pathBlock = ellipsePathBlock;
                return (UIView *)view;
            }
                
            default: break;
        }
        
        return (UIView *)nil;
    };
    
    return toReturn;
}

@end
