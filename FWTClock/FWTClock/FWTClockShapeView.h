//
//  FWTClockShapeView.h
//  FWTClock
//
//  Created by Marco Meschini on 05/10/2012.
//  Copyright (c) 2012 Marco Meschini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class FWTClockShapeView;
typedef CGPathRef (^FWTClockShapeViewPathBlock)(FWTClockShapeView *);

@interface FWTClockShapeView : UIView

@property (nonatomic, copy) FWTClockShapeViewPathBlock pathBlock;
@property (nonatomic, assign) UIEdgeInsets edgeInsets;

- (CAShapeLayer *)shapeLayer;

- (void)updateShapePath;

@end
