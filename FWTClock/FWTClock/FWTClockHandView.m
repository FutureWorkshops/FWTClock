//
//  FWTClockHandView.m
//  FWTClock
//
//  Created by Marco Meschini on 26/09/2012.
//  Copyright (c) 2012 Marco Meschini. All rights reserved.
//

#import "FWTClockHandView.h"

@interface FWTClockHandView ()

@property (nonatomic, assign) CGRect shapeLayerPathRect;

@end

@implementation FWTClockHandView

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        //
        self.shapeLayer.shadowOpacity = 1.0f;//.25f;
        self.shapeLayer.shadowOffset = CGSizeMake(.0f, .0f);
        self.shapeLayer.shadowRadius = 2.0f;
        
        //
        self.horizontalInset = 2.0f;
    }
    return self;
}

#pragma mark - Overrides
- (void)updateShapePath
{
    [super updateShapePath];
    
    CGRect currentShapeLayerPathRect = CGRectInset(self.bounds, self.horizontalInset, .0f);
    if (!self.shapeLayer.path || !CGRectEqualToRect(self.shapeLayerPathRect, currentShapeLayerPathRect))
    {
        self.shapeLayerPathRect = currentShapeLayerPathRect;
        
        CGRect pathRect = currentShapeLayerPathRect;
        pathRect.origin.y += (pathRect.size.height * self.start);
        pathRect.size.height *= (self.end-self.start);
        
        UIBezierPath *bp = [UIBezierPath bezierPathWithRect:pathRect];
        self.shapeLayer.path = bp.CGPath;
        self.shapeLayer.shadowPath = bp.CGPath;
    }
}

@end
