//
//  FWTClockShapeView.h
//  FWTClock
//
//  Created by Marco Meschini on 05/10/2012.
//  Copyright (c) 2012 Marco Meschini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface FWTClockShapeView : UIView

- (CAShapeLayer *)shapeLayer;

- (void)updateShapePath;

@end
