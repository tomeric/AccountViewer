//
//  MainViewController.h
//  AccountViewer
//
//  Created by Tom-Eric Gerritsen on 8/14/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//


#import "FlipsideViewController.h"
#import "AuthentionController.h"

@interface MainViewController : AuthentionController <FlipsideViewControllerDelegate> {
}

@property (nonatomic, retain) Credentials *credentials;

- (IBAction)showInfo:(id)sender;
- (void)presentLoginModal;

@end

