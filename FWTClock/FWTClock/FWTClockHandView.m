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

+ (Class)layerClass
{
    return [CAShapeLayer class];
}

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

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    
//    self.layer.borderWidth = 1.0f;
    
    [self _refreshShapeLayer];
}

#pragma mark - Private
- (void)_refreshShapeLayer
{
    if (CGRectEqualToRect(self.bounds, CGRectZero))
    {
        self.shapeLayer.path = nil;
        return;
    }
    
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

#pragma mark - Public
- (CAShapeLayer *)shapeLayer
{
    return (CAShapeLayer *)self.layer;
}

@end
