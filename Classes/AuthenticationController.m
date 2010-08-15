//
//  AuthentionController.m
//  AccountViewer
//
//  Created by Tom-Eric Gerritsen on 8/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AuthenticationController.h"

@implementation AuthenticationController

@synthesize credentials;

// PUBLIC:

- (void)viewDidLoad {
	[super viewDidLoad];
	credentials = [Credentials load];	
}

- (void)viewDidUnload {
	[credentials release];
}

- (id) getCredentials {
	return self.credentials;
}

- (void) updateCredentials:(NSString *)username :(NSString *)password {
	[ASIHTTPRequest clearSession];
	
	credentials.username = username;
	credentials.password = password;
	
	[credentials update];
}

- (void)attemptLogin {
	if (![credentials valid]) {
		[self loginFailed];
	} else {
    NSURL *URL = [NSURL URLWithString:[API_URL stringByAppendingFormat: @"account.json#"]];
		NSLog(@"Sending request to: %@", URL);
		
		ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:URL];

		[request setDelegate:self];
		[request setUsername: credentials.username];
		[request setPassword: credentials.password];		
		[request startAsynchronous];
	}
}
- (void)handleAuthenticationResponse {
	NSLog(@"handleAuthenticationResponse");
	// Parse JSON into an Array
	SBJSON *parser = [[SBJSON alloc] init];
	NSString *JSON = [[NSString alloc] initWithData: receivedData
																				 encoding: NSUTF8StringEncoding];
	
	NSDictionary *accountDictionary = [parser objectWithString:JSON];
	
	if([accountDictionary objectForKey:@"email"] != nil) {
		[self loginCompleted];
	} else {
		[self loginFailed];
	}
	
	// Release resources
	[parser release];
	[JSON release];
}

- (void)loginCompleted {
	// Overwrite this method in your class
	NSLog(@"Login completed");
}

- (void)loginFailed {
	NSLog(@"Login failed");
	[self showLoginError];
}

- (void)showConnectionError {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Probleem met de verbinding"
																									message: @"Er is een probleem met de verbinding waardoor inloggen mislukt is. Probeer het later opnieuw."
																								 delegate: self
																				cancelButtonTitle: @"Sluiten"
																				otherButtonTitles: nil];
	
	[alert show];
	[alert release];
}

- (void)showLoginError {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Inloggegevens niet correct" 
																									message: @"Het is niet gelukt om met de opgegeven gebruikersnaam en wachtwoord in te loggen." 
																								 delegate: self 
																				cancelButtonTitle: @"Sluiten" 
																				otherButtonTitles: nil];
	
	[alert show];	
	[alert release];
}

// DELEGATES:

- (void)requestFailed:(ASIHTTPRequest *)request {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	[self loginFailed];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
	NSLog(@"Received authentication challenge");
	
	if ([challenge previousFailureCount] == 0) {
		NSLog(@"Logging in with username: %@, password: %@", credentials.username, credentials.password);
		
		[[challenge sender]  useCredential: [NSURLCredential credentialWithUser: credentials.username
																																	 password: credentials.password
																															  persistence: NSURLCredentialPersistenceNone] 
						forAuthenticationChallenge: challenge];
	} else {
		[[challenge sender] cancelAuthenticationChallenge: challenge];
	}
}

- (void)requestFinished:(ASIHTTPRequest *)request {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	NSLog(@"requestFinished");
	
	receivedData = [request responseData];
	[self handleAuthenticationResponse];
}


@end
