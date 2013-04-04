//
//  AppDelegate.m
//  FWTClock_Test
//
//  Created by Marco Meschini on 25/09/2012.
//  Copyright (c) 2012 Marco Meschini. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.backgroundColor = [UIColor whiteColor];

    //
    NSArray *samples = @[[RistrettoSampleDescriptor descriptorWithTitle:@"Default" className:@"DefaultViewController"],
                         [RistrettoSampleDescriptor descriptorWithTitle:@"Night" className:@"CustomViewController"],
                         ];

    RistrettoTableViewController *rootViewController = [[[RistrettoTableViewController alloc] init] autorelease];
    rootViewController.items = samples;
    
    self.window.rootViewController = [UINavigationController Ristretto_navigationControllerWithRootViewController:rootViewController
                                                                                             defaultHeaderEnabled:YES];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
