//
//  FWTClockHandView.h
//  FWTClock
//
//  Created by Marco Meschini on 26/09/2012.
//  Copyright (c) 2012 Marco Meschini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface FWTClockHandView : UIView

@property (nonatomic, assign) CGFloat start, end;
@property (nonatomic, assign) CGFloat horizontalInset;

- (CAShapeLayer *)shapeLayer;
@end
