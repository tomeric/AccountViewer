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
@synthesize usernameField;
@synthesize passwordField;

// PUBLIC:

- (void)viewDidLoad {
	[super viewDidLoad];
	
	usernameField.text = [[self getCredentials] username];
	passwordField.text = [[self getCredentials] password];
	
	self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];    
}

- (void)loginCompleted {
	[self.delegate flipsideViewControllerDidFinish:self];
}

- (void)loginFailed {
	[self showLoginError];
}

// DELEGATES:

- (IBAction)done:(id)sender {
	[self updateCredentials: usernameField.text: passwordField.text];
	[self attemptLogin];
}

@end
