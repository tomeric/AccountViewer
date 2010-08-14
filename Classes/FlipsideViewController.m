//
//  FlipsideViewController.m
//  AccountViewer
//
//  Created by Tom-Eric Gerritsen on 8/14/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "FlipsideViewController.h"


@implementation FlipsideViewController

@synthesize credentials;
@synthesize delegate;
@synthesize usernameField;
@synthesize passwordField;

- (void)viewDidLoad {
	[super viewDidLoad];
	
	credentials = [Credentials load];
	usernameField.text = credentials.username;
	passwordField.text = credentials.password;
	
	self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];    
}


- (IBAction)done:(id)sender {
	credentials.username = usernameField.text;
	credentials.password = passwordField.text;
	
	if([credentials valid]) {
		[credentials update];
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
	[credentials release];
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
