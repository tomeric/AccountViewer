//
//  MainViewController.h
//  AccountViewer
//
//  Created by Tom-Eric Gerritsen on 8/14/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "AuthenticatedController.h"

@interface MainViewController : AuthenticatedController {
}

@property (nonatomic, retain) Credentials *credentials;

- (IBAction)showInfo:(id)sender;

@end

