//
//  FWTClockViewFactory.h
//  FWTClock
//
//  Created by Marco Meschini on 26/09/2012.
//  Copyright (c) 2012 Marco Meschini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FWTClockView.h"

@interface FWTClockViewFactory : NSObject

+ (UIView *)defaultViewForClockSubview:(FWTClockSubview)clockSubview style:(FWTClockViewStyle)style;

+ (void)applyDefaultsToClockView:(FWTClockView *)clockView forIndexes:(NSIndexSet *)indexes style:(FWTClockViewStyle)style;

@end
