//
//  FWTClockView.m
//  FWTClock
//
//  Created by Marco Meschini on 25/09/2012.
//  Copyright (c) 2012 Marco Meschini. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "FWTClockView.h"
#import "FWTClockViewFactory.h"

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
        self.style = FWTClockViewStyleDay;
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
            [FWTClockViewFactory applyDefaultsToClockView:self forIndexes:indexSet style:self.style];
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
    NSLog(@"absoluteSize[%i]:%@", index, NSStringFromCGSize(toReturn));
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
        currentView = [FWTClockViewFactory defaultViewForClockSubview:clockSubview style:self.style];
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

@end






