#FWTClock

![FWTClock screenshot](http://grab.by/h3N4)


FWTClock is a simple object that helps you showing dates on an analog clock. You can use FWTClock as a real clock or, for instance, you can use as a stamp to create images at runtime. 

##Requirements
* XCode 4.4.1 or higher
* iOS 5.0

##Features

FWTClock, when ticking, has its own queue and doesn't lock the main loop. You can choose between different oscillator mode (animations): *mechanical, quartz and quartz with a small backward jump*.
FWTClock, the controller, exposes an FWTClockView, the view. The controller is in charge to calculate the right rotation tranforms for each single hand and to apply those with or without animation.

This project is not yet ARC-ready.

##Initializing
You don't have to do much if you're happy with the default clock style:

	self.clock = [[FWTClock alloc] init];
    self.clock.oscillatorType = FWTClockOscillatorTypeMechanical; 
	self.clock.clockView.frame = CGRectMake(.0f, .0f, 300.0f, 300.0f);
	[self.view addSubview:self.clock.clockView];


##How to use FWTClock: configure

**clockView** the clock view 

**date** the date displayed by the clock

**calendar** the calendar to use for the clock

**ticking** returns a Boolean value indicating whether the tick animation is running

**oscillatorType** the style of the animation for the second hand

##How to use FWTClockView: configure

The FWTClockView is just a basic container for all the views needed for the UI: the background, the hands, the ring. The clock view, during the first layout, reads the *subviewsMask* and, if needed, creates the default subviews otherwise its simply sets the bounds and the center point. You can access each of the default subviews and adjust their appearance (see below for further details) or you can just easily replace with your own custom UIView subclass. You specify the frame of each single subview using a relative CGRect (in future I will add support also for regular CGRect).

**backgroundView** the background of the clock

**handHourView** the hour hand of the clock

**handMinuteView** the minute hand of the clock

**handSecondView** the second hand of the clock

**ringView** the frontmost ring of the clock  
    
The view has two more properties to help you configure your clock appearance:

**edgeInsets** use this property to resize and reposition the effective rectangle. 

**subviewsMask** an integer bit mask that determines which of the clock subviews should be enabled 

##FWTClockView subviews: default

**FWTClockShapeView** the backing layer of this superclass is a *CAShapeLayer*. The view call the *updateShapePath* only when it's needed and this is the right time to create the path and to set . 

**FWTClockBackgroundView**

**FWTClockHandView**

**FWTClockRingView**

##For your interest


##Demo
The sample project.


##Licensing
Apache License Version 2.0

##Support, bugs and feature requests
If you want to submit a feature request, please do so via the issue tracker on github.
If you want to submit a bug report, please also do so via the issue tracker, including a diagnosis of the problem and a suggested fix (in code).
