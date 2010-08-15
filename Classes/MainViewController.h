//
//  MainViewController.h
//  AccountViewer
//
//  Created by Tom-Eric Gerritsen on 8/14/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "AuthenticatedController.h"

@interface MainViewController : AuthenticatedController {
	NSString * title;
}

@property (nonatomic, retain) IBOutlet UILabel *loadingLabel;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *loadingIndicator;
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;

- (IBAction)showInfo:(id)sender;

@end

