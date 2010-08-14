//
//  AccountViewerAppDelegate.m
//  AccountViewer
//
//  Created by Tom-Eric Gerritsen on 8/14/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//


#import "AccountViewerAppDelegate.h"
#import "MainViewController.h"

@implementation AccountViewerAppDelegate


@synthesize window;

@synthesize mainViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	
	// Override point for customization after application launch.
	// Add the main view controller's view to the window and display.
	[window addSubview:mainViewController.view];
	[window makeKeyAndVisible];
	return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
	
	// Save data if appropriate.
}

- (void)dealloc {
	
	[window release];
	[mainViewController release];
	[super dealloc];
}

@end

