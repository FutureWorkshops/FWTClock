//
//  FWTClockShapeView.m
//  FWTClock
//
//  Created by Marco Meschini on 05/10/2012.
//  Copyright (c) 2012 Marco Meschini. All rights reserved.
//

#import "FWTClockShapeView.h"

@implementation FWTClockShapeView

+ (Class)layerClass
{
    return [CAShapeLayer class];
}

- (void)setFrame:(CGRect)frame
{
    CGRect previous = [[self valueForKey:@"frame"] CGRectValue];
    BOOL needsRefresh = !CGSizeEqualToSize(previous.size, frame.size);
    [super setFrame:frame];
    
    if (CGRectEqualToRect(frame, CGRectZero))
        self.shapeLayer.path = nil;
    else if (needsRefresh)
        [self updateShapePath];
}

- (void)setBounds:(CGRect)bounds
{
    CGRect previous = [[self valueForKey:@"bounds"] CGRectValue];
    BOOL needsRefresh = !CGSizeEqualToSize(previous.size, bounds.size);
    [super setBounds:bounds];
    
    if (CGRectEqualToRect(bounds, CGRectZero))
        self.shapeLayer.path = nil;
    else if (needsRefresh)
        [self updateShapePath];
}

#pragma mark - Public
- (CAShapeLayer *)shapeLayer
{
    return (CAShapeLayer *)self.layer;
}

- (void)updateShapePath
{
    NSLog(@"updateShapePath");
}

@end
