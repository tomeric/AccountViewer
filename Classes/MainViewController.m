//
//  MainViewController.m
//  AccountViewer
//
//  Created by Tom-Eric Gerritsen on 8/14/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//


#import "MainViewController.h"

@implementation MainViewController

- (void)viewDidLoad {
	credentials = [Credentials load];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear: animated];

	if(![credentials valid]) {
		NSLog(@"Credentials are invalid");
		[self presentLoginModal];
	}
	
	NSLog(@"Credentials are valid");
}

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller {
	[self dismissModalViewControllerAnimated:YES];
}


- (IBAction)showInfo:(id)sender {    
	[self presentLoginModal];
}

- (void) presentLoginModal {
	FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideView" bundle:nil];
	
	controller.delegate = self;
	controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	
	NSLog(@"Presenting the flipside");
	[self presentModalViewController:controller animated:YES];
	
	[controller release];	
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
	[super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)dealloc {
	
	[super dealloc];
}

@end

