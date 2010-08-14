//
//  AccountViewerAppDelegate.h
//  AccountViewer
//
//  Created by Tom-Eric Gerritsen on 8/14/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//


#import <UIKit/UIKit.h>

@class MainViewController;

@interface AccountViewerAppDelegate : NSObject <UIApplicationDelegate> {

	UIWindow *window;

	MainViewController *mainViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;


@property (nonatomic, retain) IBOutlet MainViewController *mainViewController;

@end

