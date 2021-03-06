//
//  FWTClockHandView.m
//  FWTClock
//
//  Created by Marco Meschini on 26/09/2012.
//  Copyright (c) 2012 Marco Meschini. All rights reserved.
//

#import "FWTClockHandView.h"

@implementation FWTClockHandView

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        //
        self.shapeLayer.shadowOpacity = 1.0f;//.25f;
        self.shapeLayer.shadowOffset = CGSizeMake(.0f, .0f);
        self.shapeLayer.shadowRadius = 2.0f;
    }
    
    return self;
}

#pragma mark - Overrides
- (void)updateShapePath
{    
    [super updateShapePath];
    self.shapeLayer.shadowPath = self.shapeLayer.path;
}

@end
