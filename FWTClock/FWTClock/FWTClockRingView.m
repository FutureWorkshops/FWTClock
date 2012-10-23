//
//  FWTClockRingView.m
//  FWTClock
//
//  Created by Marco Meschini on 26/09/2012.
//  Copyright (c) 2012 Marco Meschini. All rights reserved.
//

#import "FWTClockRingView.h"

@implementation FWTClockRingView

#pragma mark - Overrides
- (void)updateShapePath
{
    CGRect availableRect = CGRectInset(self.bounds, 2, 2);
    self.shapeLayer.path = [UIBezierPath bezierPathWithOvalInRect:availableRect].CGPath;
}

@end
