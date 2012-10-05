//
//  FWTClockRingView.m
//  FWTClock
//
//  Created by Marco Meschini on 26/09/2012.
//  Copyright (c) 2012 Marco Meschini. All rights reserved.
//

#import "FWTClockRingView.h"

@implementation FWTClockRingView

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        self.contentMode = UIViewContentModeRedraw;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGRect availableRect = CGRectInset(rect, 2, 2);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //
    CGColorRef colorRef = [UIColor colorWithWhite:.9f alpha:1.0f].CGColor;
    CGContextSetFillColorWithColor(ctx, colorRef);
    UIBezierPath *ellipsePath = [UIBezierPath bezierPathWithOvalInRect:availableRect];
    [ellipsePath fill];
    [ellipsePath stroke];
}

@end
