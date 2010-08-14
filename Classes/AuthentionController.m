//
//  AuthentionController.m
//  AccountViewer
//
//  Created by Tom-Eric Gerritsen on 8/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AuthentionController.h"


@implementation AuthentionController

@synthesize credentials;

- (id) getCredentials {
	return self.credentials;
}

- (void) updateCredentials:(NSString *)username :(NSString *)password {
	credentials.username = username;
	credentials.password = password;

	[credentials update];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	credentials = [Credentials load];	
}

- (void)viewDidUnload {
	[credentials release];
}

- (void)attemptLogin {
	if (![credentials valid]) {
		[self loginFailed];
	} else {
    NSString *URL = [API_URL stringByAppendingPathComponent: @"/account.json"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:URL]
																													 cachePolicy: NSURLCredentialPersistenceNone
																											 timeoutInterval: 30.0];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
		
		if (connection) {
			[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
			receivedData = [[NSMutableData data] retain];
		} else {
			[self loginFailed];
		}
	}
}
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
	NSLog(@"Got authentication challenge");
	
	if ([challenge previousFailureCount] == 0) {
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
}


- (void)loginCompleted {
	NSLog(@"loginCompleted");
}

- (void)loginFailed {
	NSLog(@"loginFailed");
}

- (void)showLoginError {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Inloggegevens niet correct" 
																									message: @"Het is niet gelukt om met de opgegeven gebruikersnaam en wachtwoord in te loggen." 
																								 delegate: self 
																				cancelButtonTitle: @"Sluiten" 
																				otherButtonTitles: nil];
	
	[alert show];	
}

@end
