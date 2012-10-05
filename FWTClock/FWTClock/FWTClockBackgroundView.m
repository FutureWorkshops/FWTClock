//
//  FWTClockBackgroundView.m
//  FWTClock
//
//  Created by Marco Meschini on 25/09/2012.
//  Copyright (c) 2012 Marco Meschini. All rights reserved.
//

#import "FWTClockBackgroundView.h"

@implementation FWTClockBackgroundView

+ (Class)layerClass
{
    return [CAShapeLayer class];
}

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
    
//    CGContextStrokeRect(ctx, rect);
    
    //
    CGContextSetFillColorWithColor(ctx, self.shapeLayer.fillColor);
    UIBezierPath *ellipsePath = [UIBezierPath bezierPathWithOvalInRect:availableRect];
    [ellipsePath fill];
    [ellipsePath stroke];
    
    CGRect teethRect = CGRectInset(availableRect, 3, 3);
    [self _drawTeethInRect:teethRect context:ctx];
}

- (void)_drawTeethInRect:(CGRect)rect context:(CGContextRef)ctx
{
    CGContextSaveGState(ctx);
    
    const CGSize frameSize = rect.size;
    const CGFloat radius = frameSize.width / 2.f;
    const CGFloat numberOfTeeth = 60;
    
    CGContextTranslateCTM(ctx, radius+rect.origin.x, radius+rect.origin.y);
	
    CGColorRef fillColorRef = [UIColor colorWithWhite:.34f alpha:1.0f].CGColor;
    CGColorRef strokeColorRef = [UIColor colorWithWhite:.64f alpha:.5f].CGColor;
    CGContextSetFillColorWithColor(ctx, fillColorRef);
    CGContextSetStrokeColorWithColor(ctx, strokeColorRef);
    
    double angle = 1 / numberOfTeeth * (M_PI*2.f);
    CGRect toothSmallFrame = CGRectMake(-.5f, radius*.935f, 1.0f, radius*.065f);
    CGRect toothLargeFrame = CGRectMake(-1.0f, radius*.9f, 3.0f, radius*.1f);
    
    for (NSInteger toothNumber=0; toothNumber<numberOfTeeth; toothNumber++)
    {
        CGContextRotateCTM(ctx, angle);
        if (((toothNumber+1)%5)!=0)
            UIRectFill(toothSmallFrame);
        else
            UIRectFill(toothLargeFrame);
    }
    
    CGContextRestoreGState(ctx);
}

#pragma mark - Public
- (CAShapeLayer *)shapeLayer
{
    return (CAShapeLayer *)self.layer;
}
@end
