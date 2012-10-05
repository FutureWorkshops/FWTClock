//
//  FWTClockBackgroundView.m
//  FWTClock
//
//  Created by Marco Meschini on 25/09/2012.
//  Copyright (c) 2012 Marco Meschini. All rights reserved.
//

#import "FWTClockBackgroundView.h"

@interface FWTClockTeethLayer : CALayer
@end

@implementation FWTClockTeethLayer

- (id)init
{
    if ((self = [super init]))
    {
        self.needsDisplayOnBoundsChange = YES;
        self.contentsScale = [UIScreen mainScreen].scale;
    }
    return self;
}

- (void)drawInContext:(CGContextRef)ctx
{
    CGRect availableRect = CGContextGetClipBoundingBox(ctx);
    CGRect teethRect = CGRectInset(availableRect, 4, 4);
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
            CGContextFillRect(ctx, toothSmallFrame);
        else
            CGContextFillRect(ctx, toothLargeFrame);
    }
    
    CGContextRestoreGState(ctx);
}

@end

@interface FWTClockBackgroundView ()
@property (nonatomic, retain) FWTClockTeethLayer *teethLayer;
@end

@implementation FWTClockBackgroundView
@synthesize teethLayer = _teethLayer;

- (void)dealloc
{
    self.teethLayer = nil;
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
        self.contentMode = UIViewContentModeRedraw;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    CGRect availableRect = CGRectInset(self.bounds, 2, 2);
    self.shapeLayer.path = [UIBezierPath bezierPathWithOvalInRect:availableRect].CGPath;
}

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    
    CGRect availableRect = CGRectInset(bounds, 2, 2);
    self.shapeLayer.path = [UIBezierPath bezierPathWithOvalInRect:availableRect].CGPath;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (!self.teethLayer.superlayer)
        [self.layer addSublayer:self.teethLayer];
    
    self.teethLayer.frame = self.bounds;
}

#pragma mark - Getters
- (FWTClockTeethLayer *)teethLayer
{
    if (!self->_teethLayer)
        self->_teethLayer = [[FWTClockTeethLayer alloc] init];
    
    return self->_teethLayer;
}

#pragma mark - Public
- (CAShapeLayer *)shapeLayer
{
    return (CAShapeLayer *)self.layer;
}
@end
