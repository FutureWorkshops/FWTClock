//
//  FWTClockView.m
//  FWTClock
//
//  Created by Marco Meschini on 25/09/2012.
//  Copyright (c) 2012 Marco Meschini. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "FWTClockView.h"
#import "FWTClockViewDefault.h"

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
    self.clockSubviewBlock = nil;
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
        NSInteger capacity = FWTClockSubviewCount;
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
    self.subviewsNeedLayout = !CGRectEqualToRect(previous, frame);
    [super setFrame:frame];
}

- (void)setBounds:(CGRect)bounds
{
    CGRect previous = [[self valueForKey:@"bounds"] CGRectValue];
    self.subviewsNeedLayout = !CGRectEqualToRect(previous, bounds);
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
                CGSize size = [self _sizeForClockSubview:index];
                subview.center = centerPoint;
                subview.bounds = CGRectMake(.0f, .0f, size.width, size.height);
            }
        }];
    }
}

#pragma mark - Private
- (void)_initWithDefaultsIfNeeded
{
    if (![self isInitializedWithDefaults])
    {
        self.initializedWithDefaults = YES;
        
        __block NSMutableIndexSet *indexSet = nil;
        [self.clockSubviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSInteger index = pow(2, idx);
            if (obj == [NSNull null] && (self.subviewsMask & index))
            {
                if (!indexSet) indexSet = [[NSMutableIndexSet indexSet] retain];
                [indexSet addIndex:index];
            }
        }];
        
        if (indexSet)
        {
            [self _loadDefaultSubviewsForIndexes:indexSet];
            [indexSet release];
        }
    }
}

- (CGSize)_sizeForClockSubview:(FWTClockSubview)clockSubview
{
    NSInteger index = log2(clockSubview);
    id value = [self.clockSubviewsSize objectAtIndex:index];
    if (value == [NSNull null])
    {
        UIView *subview = [self.clockSubviews objectAtIndex:index];
        CGSize assignedSize = subview.frame.size;
        value = [NSValue valueWithCGSize:assignedSize];
        [self.clockSubviewsSize replaceObjectAtIndex:index withObject:value];
    }

    CGRect availableRect = UIEdgeInsetsInsetRect(self.bounds, self.edgeInsets);
    CGSize assignedSize = [value CGSizeValue];
    NSInteger wi = 0;
    NSInteger hi = 0;
    if (assignedSize.width > 1.0f && assignedSize.height > 1.0f)
    {
        wi = (NSInteger)assignedSize.width;
        hi = (NSInteger)assignedSize.height;
    }
    else
    {
        wi = CGRectGetWidth(availableRect)*assignedSize.width;
        hi = CGRectGetHeight(availableRect)*assignedSize.height;
    }
    
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
        currentView = self.clockSubviewBlock(clockSubview);
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

- (void)_loadDefaultSubviewsForIndexes:(NSIndexSet *)indexes
{
    [indexes enumerateIndexesUsingBlock:^(NSUInteger clockSubview, BOOL *stop) {
        UIView *defaultView = self.clockSubviewBlock(clockSubview);
        [self _replaceViewForClockSubview:clockSubview withView:defaultView];
    }];
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

- (FWTClockViewClockSubviewBlock)clockSubviewBlock
{
    if (!self->_clockSubviewBlock) self->_clockSubviewBlock = [[FWTClockViewDefault defaultClockSubviewBlock] copy];
    return self->_clockSubviewBlock;
}

@end






