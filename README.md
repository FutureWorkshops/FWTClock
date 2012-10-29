#FWTClock

![FWTClock screenshot](http://grab.by/h3N4)


FWTClock is a simple object that helps you showing dates on an analog clock. You can use FWTClock as a real clock or, for instance, you can use as a stamp to create dynamic images at runtime. 

##Requirements
* XCode 4.4.1 or higher
* iOS 5.0

##Features

FWTClock ticks on its own queue and will not lock the main loop. You can choose between different oscillator mode (animations): *mechanical, quartz and quartz with a small backward jump*.
FWTClock is the controller and it exposes an FWTClockView, the view. The controller has the responsibility to calculate the right rotation tranforms for each single hand and to apply those with or without animation.
FWTClockView can be configured by accessing its public properties or by implementing the protocol.

This project is not yet ARC-ready.

##Initializing
You don't have to do much if you're happy with the default clock style:

	self.clock = [[FWTClock alloc] init];
    self.clock.oscillatorType = FWTClockOscillatorTypeMechanical; 
	self.clock.clockView.frame = CGRectMake(.0f, .0f, 300.0f, 300.0f);
	[self.view addSubview:self.clock.clockView];


##How to use FWTClock: configure

**clockView** the *readonly* clock view 

**date** the date displayed by the clock

**calendar** the calendar used by the clock

**isTicking** returns a Boolean value indicating whether the tick animation is running

**oscillatorType** the style of the animation for the second hand

##How to use FWTClockView: configure

The FWTClockView is just a basic container for all the views needed for the UI: the background, the hands, the ring. The clock view, during the first layout, reads the *subviewsMask* and, if needed, creates the default subviews otherwise its simply sets the bounds and the center point to the subviews. You can access each of the default subviews and adjust their appearance (see below for further details) or you can easily replace with your own custom UIView subclass. It's not mandatory but you can specify the frame for each single subview using a rectangle in the unit coordinate space.

**backgroundView** the background of the clock

**handHourView** the hour hand of the clock

**handMinuteView** the minute hand of the clock

**handSecondView** the second hand of the clock

**ringView** the frontmost ring of the clock  
    
The view has few more properties to help you configure the clock appearance:

**edgeInsets** use this property to resize and reposition the effective rectangle 

**subviewsMask** an integer bit mask that determines which of the clock subviews should be enabled 

**appearanceClass** the class to use for initialize the clock subviews

##FWTClockView subviews: default

**FWTClockShapeView** the backing layer of this superclass is a *CAShapeLayer*. The view call the *updateShapePath* only when it's needed and relies on the *pathBlock* property to set the path property of the layer. Use the *edgeInsets* property to resize and reposition the effective rectangle.

**FWTClockBackgroundView** *[todo]*

**FWTClockHandView** the height of each hand matches the clockView height (the anchorPoint is the default one). There are two additional properties: *start* and *end*, the start and the end of the path when drawn in the layer’s coordinate space.

##FWTClockViewAppearance
The FWTClockViewAppearance protocol gives you an additional way to customize your FWTClockView. There's only method to implement:

\+ (UIView *)clockView:(FWTClockView *)clockView viewForClockSubview:(FWTClockSubview)clockSubview; 

There's no possibility to force the clock view to call this method or the refresh the appearance after it's added to the superview. 

##For your interest


##Demo
See the sample project.


##Licensing
Apache License Version 2.0

##Support, bugs and feature requests
If you want to submit a feature request, please do so via the issue tracker on github.
If you want to submit a bug report, please also do so via the issue tracker, including a diagnosis of the problem and a suggested fix (in code).
