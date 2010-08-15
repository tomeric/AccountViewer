//
//  MainViewController.m
//  AccountViewer
//
//  Created by Tom-Eric Gerritsen on 8/14/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//


#import "MainViewController.h"

@implementation MainViewController

@synthesize loadingLabel, loadingIndicator;
@synthesize titleLabel;

- (IBAction)showInfo:(id)sender {    
	[self presentLoginModal];
}

- (void)viewDidLoad {
	loadingLabel.hidden = NO;
	loadingIndicator.hidden = NO;
	titleLabel.hidden = YES;
	
	[super viewDidLoad];
}

- (void)loginCompleted {
	NSDictionary *accountDictionary = [self getAccountDictionary];
	
	loadingLabel.hidden = YES;
	loadingIndicator.hidden = YES;
	
	titleLabel.text = [accountDictionary objectForKey:@"name"];
	titleLabel.hidden = NO;
	
	[super loginCompleted];
}

@end

