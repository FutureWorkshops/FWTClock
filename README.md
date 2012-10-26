#FWTClock

![FWTClock screenshot](http://grab.by/h3N4)


FWTClock is a simple object that helps you showing dates on an analog clock. You can use FWTClock as a real clock or, for instance, you can use as a stamp to create images at runtime. 

##Requirements
* XCode 4.4.1 or higher
* iOS 5.0

##Features

FWTClock, when ticking, has its own queue and doesn't lock the main loop. You can choose between different oscillator mode: *mechanical, quartz and quartz with a small backward jump* as the Apple's one.
FWTClock, the controller, exposes an FWTClockView, the view. The controller is in charge to calculate the right rotation tranforms for each single hand and to apply that with or without animation.
The view is just a basic container for all the views needed for the UI: the background, the hands, … 
The view has two more properties to help you configure your clock instance:

* **edgeInsets** use this property to resize and reposition the effective rectangle. 
* **subviewsMask** an integer bit mask that determines which of the clock subviews should be enabled 

This project is not yet ARC-ready.

##How to use it: initializing
If you're happy with the default clock style you don't need to do much to init:

	self.clock = [[FWTClock alloc] init];
    self.clock.oscillatorType = FWTClockOscillatorTypeMechanical; 
	self.clock.clockView.frame = CGRectMake(.0f, .0f, 300.0f, 300.0f);
	[self.view addSubview:self.clock.clockView];


##How to use it: configure

**clockView** the clock view

**date** the date displayed by the clock

**calendar** the calendar to use for the clock

**ticking** returns a Boolean value indicating whether the tick animation is running

**oscillatorType** the style of the animation for the second hand


##View hierarchy

##For your interest


##Demo
The sample project.


##Licensing
Apache License Version 2.0

##Support, bugs and feature requests
If you want to submit a feature request, please do so via the issue tracker on github.
If you want to submit a bug report, please also do so via the issue tracker, including a diagnosis of the problem and a suggested fix (in code).
