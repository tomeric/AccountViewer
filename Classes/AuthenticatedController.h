//
//  AuthenticatedController.h
//  AccountViewer
//
//  Created by Tom-Eric Gerritsen on 8/15/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AuthenticationController.h"
#import "FlipsideViewController.h"

@interface AuthenticatedController : AuthenticationController <FlipsideViewControllerDelegate> {
	NSDictionary * accountDictionary;
}

- (NSDictionary *) getAccountDictionary;
- (void) presentLoginModal;

@end
