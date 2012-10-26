//
//  FWTClockView.m
//  FWTClock
//
//  Created by Marco Meschini on 25/09/2012.
//  Copyright (c) 2012 Marco Meschini. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "FWTClockView.h"
#import "FWTClockBackgroundView.h"
#import "FWTClockHandView.h"
#import "FWTClockRingView.h"

@interface FWTClockView ()
@property (nonatomic, assign, getter = isInitializedWithDefaults) BOOL initializedWithDefaults;
@property (nonatomic, retain) NSMutableArray *clockSubviewsSize;
@property (nonatomic, retain) NSMutableArray *clockSubviews;
@property (nonatomic, assign) BOOL subviewsNeedLayout;
@end

@implementation FWTClockView
@synthesize edgeInsets = _edgeInsets;
@synthesize backgroundView = _backgroundView;
@synthesize handHourView = _handHourView;
@synthesize handMinuteView = _handMinuteView;
@synthesize handSecondView = _handSecondView;
@synthesize ringView = _ringView;
@synthesize clockSubviewsSize = _clockSubviewsSize;
@synthesize clockSubviews = _clockSubviews;

- (void)dealloc
{
    self.clockSubviews = nil;
    self.clockSubviewsSize = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        //
        self.edgeInsets = UIEdgeInsetsZero;
        self.subviewsMask = FWTClockSubviewAll;

        //
        NSInteger capacity = log2(FWTClockSubviewCount);
        self.clockSubviewsSize = [NSMutableArray arrayWithCapacity:capacity];
        self.clockSubviews = [NSMutableArray arrayWithCapacity:capacity];
        NSNull *null = [NSNull null];
        for (unsigned i=0; i<capacity; i++)
        {
            [self.clockSubviewsSize addObject:null];
            [self.clockSubviews addObject:null];
        }
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    CGRect previous = [[self valueForKey:@"frame"] CGRectValue];
    self.subviewsNeedLayout = !CGSizeEqualToSize(previous.size, frame.size);
    [super setFrame:frame];
}

- (void)setBounds:(CGRect)bounds
{
    CGRect previous = [[self valueForKey:@"bounds"] CGRectValue];
    self.subviewsNeedLayout = !CGSizeEqualToSize(previous.size, bounds.size);
    [super setBounds:bounds];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //
    [self _initWithDefaultsIfNeeded];
    
    //
    if (self.subviewsNeedLayout)
    {
        self.subviewsNeedLayout = NO;
        
        CGRect availableRect = UIEdgeInsetsInsetRect(self.bounds, self.edgeInsets);
        CGPoint centerPoint = CGPointMake(CGRectGetMidX(availableRect), CGRectGetMidY(availableRect));
        [self.clockSubviews enumerateObjectsUsingBlock:^(UIView *subview, NSUInteger idx, BOOL *stop) {
            
            NSInteger index = pow(2, idx);
            if (self.subviewsMask & index)
            {
                if (!subview.superview)
                    [self addSubview:subview];
                
                //
                CGSize absoluteSize = [self _absoluteSizeForClockSubview:index];
                subview.center = centerPoint;
                subview.bounds = CGRectMake(.0f, .0f, absoluteSize.width, absoluteSize.height);
            }
        }];
    }
}

#pragma mark - Private
- (void)_initWithDefaultsIfNeeded
{
    if (![self isInitializedWithDefaults])
    {
        __block BOOL needToInit = NO;
        __block NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
        [self.clockSubviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSInteger index = pow(2, idx);
            if (obj == [NSNull null] && (self.subviewsMask & index))
            {
                [indexSet addIndex:index];
                needToInit = YES;
            }
        }];
        
        if (needToInit)
        {
            self.initializedWithDefaults = YES;
            [self _applyDefaultSubviewsForIndexes:indexSet];
        }
    }
}

- (CGSize)_absoluteSizeForClockSubview:(FWTClockSubview)clockSubview
{
    NSInteger index = log2(clockSubview);
    id value = [self.clockSubviewsSize objectAtIndex:index];
    if (value == [NSNull null])
    {
        UIView *subview = [self.clockSubviews objectAtIndex:index];
        CGSize relativeSize = subview.frame.size;
        value = [NSValue valueWithCGSize:relativeSize];
        [self.clockSubviewsSize replaceObjectAtIndex:index withObject:value];
    }

    CGRect availableRect = UIEdgeInsetsInsetRect(self.bounds, self.edgeInsets);
    CGSize relativeSize = [value CGSizeValue];
    NSInteger wi = CGRectGetWidth(availableRect)*relativeSize.width;
    NSInteger hi = CGRectGetHeight(availableRect)*relativeSize.height;
    CGSize toReturn = CGSizeMake(wi, hi);
    return toReturn;
}

- (UIView *)_currentViewForClockSubview:(FWTClockSubview)clockSubview
{
    if (!(self.subviewsMask & clockSubview))
        return nil;
    
    NSInteger index = log2(clockSubview);
    UIView *currentView = [self.clockSubviews objectAtIndex:index];
    if ((NSNull *)currentView == [NSNull null])
    {
        currentView = [[self class] defaultViewForClockSubview:clockSubview];
        [self.clockSubviews replaceObjectAtIndex:index withObject:currentView];
    }
    
    return currentView;
}

- (void)_replaceViewForClockSubview:(FWTClockSubview)clockSubview withView:(UIView *)newView
{
    NSInteger index = log2(clockSubview);
    UIView *currentView = [self.clockSubviews objectAtIndex:index];
    if (newView == nil)
    {
        [self.clockSubviews replaceObjectAtIndex:index withObject:[NSNull null]];
        [self.clockSubviewsSize replaceObjectAtIndex:index withObject:[NSNull null]];
    }
    else if (currentView != newView)
    {
        [self.clockSubviews replaceObjectAtIndex:index withObject:newView];
        [self.clockSubviewsSize replaceObjectAtIndex:index withObject:[NSNull null]];
    }
}

- (void)_applyDefaultSubviewsForIndexes:(NSIndexSet *)indexes
{
    if ([indexes containsIndex:FWTClockSubviewBackground])
        self.backgroundView = [[self class] defaultViewForClockSubview:FWTClockSubviewBackground];
    
    if ([indexes containsIndex:FWTClockSubviewHandHour])
        self.handHourView   = [[self class] defaultViewForClockSubview:FWTClockSubviewHandHour];
    
    if ([indexes containsIndex:FWTClockSubviewHandMinute])
        self.handMinuteView = [[self class] defaultViewForClockSubview:FWTClockSubviewHandMinute];
    
    if ([indexes containsIndex:FWTClockSubviewHandSecond])
        self.handSecondView = [[self class] defaultViewForClockSubview:FWTClockSubviewHandSecond];
    
    if ([indexes containsIndex:FWTClockSubviewRing])
        self.ringView       = [[self class] defaultViewForClockSubview:FWTClockSubviewRing];
}

#pragma mark - Accessors
- (UIView *)backgroundView
{
    return [self _currentViewForClockSubview:FWTClockSubviewBackground];
}

- (void)setBackgroundView:(UIView *)backgroundView
{
    [self _replaceViewForClockSubview:FWTClockSubviewBackground withView:backgroundView];
}

- (UIView *)handHourView
{
    return [self _currentViewForClockSubview:FWTClockSubviewHandHour];
}

- (void)setHandHourView:(UIView *)handHourView
{
    [self _replaceViewForClockSubview:FWTClockSubviewHandHour withView:handHourView];
}

- (UIView *)handMinuteView
{
    return [self _currentViewForClockSubview:FWTClockSubviewHandMinute];
}

- (void)setHandMinuteView:(UIView *)handMinuteView
{
    [self _replaceViewForClockSubview:FWTClockSubviewHandMinute withView:handMinuteView];
}

- (UIView *)handSecondView
{
    return [self _currentViewForClockSubview:FWTClockSubviewHandSecond];
}

- (void)setHandSecondView:(UIView *)handSecondView
{
    [self _replaceViewForClockSubview:FWTClockSubviewHandSecond withView:handSecondView];
}

- (UIView *)ringView
{
    return [self _currentViewForClockSubview:FWTClockSubviewRing];
}

- (void)setRingView:(UIView *)ringView
{
    [self _replaceViewForClockSubview:FWTClockSubviewRing withView:ringView];
}

#pragma mark - Public class methods 
+ (UIView *)defaultViewForClockSubview:(FWTClockSubview)clockSubview
{
    switch (clockSubview)
    {
        case FWTClockSubviewBackground:
        {
            //
            CGRect relativeFrame = CGRectMake(.0f, .0f, 1.0f, 1.0f);
            FWTClockBackgroundView *toReturn = [[[FWTClockBackgroundView alloc] initWithFrame:relativeFrame] autorelease];
            toReturn.shapeLayer.fillColor = [UIColor colorWithWhite:.875f alpha:1.0f].CGColor;
            toReturn.shapeLayer.strokeColor = [UIColor blackColor].CGColor;
            return toReturn;
        }
            
        case FWTClockSubviewHandHour:
        {
            //
            FWTClockHandView *toReturn = [[[FWTClockHandView alloc] init] autorelease];
            toReturn.start = .2f;
            toReturn.end = .55f;
            toReturn.frame = CGRectMake(.0f, .0f, .051020f, 1.0f);
            toReturn.shapeLayer.strokeColor = [UIColor colorWithWhite:.5f alpha:.5f].CGColor;
            return toReturn;
        }
            
        case FWTClockSubviewHandMinute:
        {
            FWTClockHandView *toReturn = [[[FWTClockHandView alloc] init] autorelease];
            toReturn.start = .125f;
            toReturn.end = .55f;
            toReturn.frame = CGRectMake(.0f, .0f, .040816f, 1.0f);
            toReturn.shapeLayer.strokeColor = [UIColor colorWithWhite:.7f alpha:.5f].CGColor;
            return toReturn;
        }
            
        case FWTClockSubviewHandSecond:
        {
            FWTClockHandView *toReturn = [[[FWTClockHandView alloc] init] autorelease];
            toReturn.start = .05f;
            toReturn.end = .575f;
            toReturn.frame = CGRectMake(.0f, .0f, .025510f, 1.0f);
            toReturn.shapeLayer.fillColor = [UIColor redColor].CGColor;
            return toReturn;
        }
            
        case FWTClockSubviewRing:
        {
            CGRect relativeFrame = CGRectMake(.0f, .0f, .06f, .06f);
            FWTClockRingView *toReturn = [[[FWTClockRingView alloc] initWithFrame:relativeFrame] autorelease];
            toReturn.shapeLayer.fillColor = [UIColor colorWithWhite:.9f alpha:1.0f].CGColor;
            toReturn.shapeLayer.strokeColor = [UIColor blackColor].CGColor;
            return toReturn;
        }
            
        default: break;
    }
    
    return nil;
}

@end






