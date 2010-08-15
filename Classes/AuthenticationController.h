//
//  AuthentionController.h
//  AccountViewer
//
//  Created by Tom-Eric Gerritsen on 8/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Credentials.h"
#import "Settings.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"

@interface AuthenticationController : UIViewController {
	Credentials * credentials;
	NSData * receivedData;
}

@property (nonatomic, retain) Credentials *credentials;

- (id) getCredentials;
- (void) updateCredentials:(NSString *)username:(NSString *)password;
- (void) attemptLogin;
- (void) handleAuthenticationResponse;
- (void) loginFailed;
- (void) loginCompleted;
- (void) showLoginError;
- (void) showConnectionError;

@end
