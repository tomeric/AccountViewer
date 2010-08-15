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
	credentials.username = username;
	credentials.password = password;

	[credentials update];
}

- (void)attemptLogin {
	if (![credentials valid]) {
		[self loginFailed];
	} else {
    NSString *URL = [API_URL stringByAppendingFormat: @"account.json#"];
		NSLog(@"Sending request to: %@", URL);
		
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:URL]
																													 cachePolicy: NSURLRequestReloadIgnoringLocalCacheData
																											 timeoutInterval: 20];
		[request setHTTPShouldHandleCookies:NO];
		
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
		
		if (connection) {
			[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
			receivedData = [[NSMutableData data] retain];
		} else {
			[self showConnectionError];
		}
	}
}
- (void)handleAuthenticationResponse {
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
	[receivedData release];
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


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	// Got new response, reset received data
	[receivedData setLength: 0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	// Append the new data to receivedData.
	[receivedData appendData: data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	[receivedData release];
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

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	[self handleAuthenticationResponse];
	
	[connection release];
}


@end
