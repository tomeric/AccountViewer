//
//  FlipsideViewController.h
//  AccountViewer
//
//  Created by Tom-Eric Gerritsen on 8/14/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AuthenticationController.h"

@protocol FlipsideViewControllerDelegate;


@interface FlipsideViewController : AuthenticationController {
	id <FlipsideViewControllerDelegate> delegate;
}

@property (nonatomic, assign) id <FlipsideViewControllerDelegate> delegate;
@property (nonatomic, retain) IBOutlet UITextField *usernameField;
@property (nonatomic, retain) IBOutlet UITextField *passwordField;

- (IBAction)done:(id)sender;

@end

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

