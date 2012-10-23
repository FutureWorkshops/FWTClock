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
    BOOL needsRefresh = [self _shapeNeedsRefreshForKey:@"frame" newRect:frame];
    [super setFrame:frame];
    [self _restoreShapeForFrame:frame needsRefresh:needsRefresh];
}

- (void)setBounds:(CGRect)bounds
{
    BOOL needsRefresh = [self _shapeNeedsRefreshForKey:@"bounds" newRect:bounds];
    [super setBounds:bounds];
    [self _restoreShapeForFrame:bounds needsRefresh:needsRefresh];
}

#pragma mark - Private
- (BOOL)_shapeNeedsRefreshForKey:(NSString *)key newRect:(CGRect)rect
{
    CGRect previous = [[self valueForKey:key] CGRectValue];
    return !CGSizeEqualToSize(previous.size, rect.size);
}

- (void)_restoreShapeForFrame:(CGRect)rect needsRefresh:(BOOL)needsRefresh
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
    NSLog(@"updateShapePath");
}

@end
