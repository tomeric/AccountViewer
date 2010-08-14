//
//  FlipsideViewController.m
//  AccountViewer
//
//  Created by Tom-Eric Gerritsen on 8/14/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "FlipsideViewController.h"


@implementation FlipsideViewController

@synthesize delegate;


- (void)viewDidLoad {
	[super viewDidLoad];
	
	credentials = [Credentials load];
	
	self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];      
}


- (IBAction)done:(id)sender {
	if([credentials valid]) {
		[self.delegate flipsideViewControllerDidFinish:self];			
	} else {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Inloggegevens niet correct" 
                                                    message:@"Het is niet gelukt om met de opgegeven gebruikersnaam en wachtwoord in te loggen." 
                                                   delegate:self 
                                          cancelButtonTitle:@"Sluiten" 
                                          otherButtonTitles:nil];
    
    [alert show];
	}
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
	[super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */


- (void)dealloc {
	[super dealloc];
}


@end
