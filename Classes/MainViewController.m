//
//  MainViewController.m
//  AccountViewer
//
//  Created by Tom-Eric Gerritsen on 8/14/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//


#import "MainViewController.h"

@implementation MainViewController

@synthesize loadingLabel, loadingIndicator;
@synthesize titleLabel;

// PUBLIC:

- (void)attemptLogin {
	[self startLoading];
	[super attemptLogin];
}

- (void)loginCompleted {
	NSDictionary *accountDictionary = [self getAccountDictionary];
	
	titleLabel.text = [accountDictionary objectForKey:@"name"];
	[self finishedLoading];
	
	[super loginCompleted];
}

// DELEGATES:

- (IBAction)showInfo:(id)sender {    
	[self presentLoginModal];
}

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller {
	[self startLoading];
	[super flipsideViewControllerDidFinish:controller];
}


// PRIVATE:

- (void)startLoading {
	loadingLabel.hidden = NO;
	loadingIndicator.hidden = NO;
	titleLabel.hidden = YES;	
}

- (void)finishedLoading {
	loadingLabel.hidden = YES;
	loadingIndicator.hidden = YES;
	titleLabel.hidden = NO;
}

@end

