//
//  AuthenticatedController.m
//  AccountViewer
//
//  Created by Tom-Eric Gerritsen on 8/15/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AuthenticatedController.h"


@implementation AuthenticatedController

- (NSDictionary *)getAccountDictionary {
	return accountDictionary;
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear: animated];
	[self attemptLogin];
}

- (void)loginFailed {
	[self presentLoginModal];
	[self showLoginError];
}

- (void)handleAuthenticationResponse {
	// Parse JSON into an Array
	SBJSON *parser = [[SBJSON alloc] init];
	NSString *JSON = [[NSString alloc] initWithData: receivedData
																				 encoding: NSUTF8StringEncoding];
	
	accountDictionary = [parser objectWithString:JSON];
	
	if([accountDictionary objectForKey:@"email"] != nil) {
		[self loginCompleted];
	} else {
		[self loginFailed];
	}
	
	// Release resources
	[receivedData release];
	[parser release];
	[JSON release];
}

- (void) presentLoginModal {
	FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideView" bundle:nil];
	
	controller.delegate = self;
	controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	
	NSLog(@"Presenting the flipside");
	[self presentModalViewController:controller animated:YES];
	
	[controller release];	
}

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller {
	[self dismissModalViewControllerAnimated:YES];
}

@end
