//
//  FWTClockShapeView.m
//  FWTClock
//
//  Created by Marco Meschini on 05/10/2012.
//  Copyright (c) 2012 Marco Meschini. All rights reserved.
//

#import "FWTClockShapeView.h"

@implementation FWTClockShapeView

- (void)dealloc
{
    self.pathBlock = nil;
    [super dealloc];
}

+ (Class)layerClass
{
    return [CAShapeLayer class];
}

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        self.pathBlock = ^(FWTClockShapeView *shapeView){
            return [UIBezierPath bezierPathWithRect:shapeView.bounds].CGPath;
        };
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    BOOL needsRefresh = [self _shapeNeedsRefreshForKey:@"frame" newRect:frame];
    [super setFrame:frame];
    [self _updateShapeForFrame:frame needsRefresh:needsRefresh];
}

- (void)setBounds:(CGRect)bounds
{
    BOOL needsRefresh = [self _shapeNeedsRefreshForKey:@"bounds" newRect:bounds];
    [super setBounds:bounds];
    [self _updateShapeForFrame:bounds needsRefresh:needsRefresh];
}

#pragma mark - Private
- (BOOL)_shapeNeedsRefreshForKey:(NSString *)key newRect:(CGRect)rect
{
    CGRect previous = [[self valueForKey:key] CGRectValue];
    return !CGSizeEqualToSize(previous.size, rect.size);
}

- (void)_updateShapeForFrame:(CGRect)rect needsRefresh:(BOOL)needsRefresh
{
    if (CGRectEqualToRect(rect, CGRectZero))
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
    self.shapeLayer.path = self.pathBlock(self);
}

@end
