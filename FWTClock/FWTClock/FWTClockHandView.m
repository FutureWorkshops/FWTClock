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
    self.shapeLayer.shadowPath = self.shapeLayer.path;
}
//
//+ (CGPathRef)shapePathForClockShapeView:(FWTClockShapeView *)shapeView
//{
//    FWTClockHandView *castedView = (FWTClockHandView *)shapeView;
//    CGRect currentShapeLayerPathRect = CGRectInset(castedView.bounds, castedView.horizontalInset, .0f);
//    currentShapeLayerPathRect.origin.y += (currentShapeLayerPathRect.size.height * castedView.start);
//    currentShapeLayerPathRect.size.height *= (castedView.end-castedView.start);
//    return [UIBezierPath bezierPathWithRect:currentShapeLayerPathRect].CGPath;
//}

@end
