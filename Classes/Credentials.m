//
//  Credentials.m
//  AccountViewer
//
//  Created by Tom-Eric Gerritsen on 8/14/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "Credentials.h"


@implementation Credentials

@synthesize username;
@synthesize password;

+(id) load {
	Credentials *credentials = [[Credentials alloc] init];
	NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
	
	credentials.username = [settings stringForKey:@"username"];
	credentials.password = [settings stringForKey:@"password"];
	
	return credentials;
}

-(BOOL) valid {
	if(username == nil || [username length] == 0 ||
		 password == nil || [password length] == 0) {
		return NO;
	}
	
	return YES;
}

-(void) update {
	NSLog(@"Updating credentials. username: %@, password: %@", self.username, self.password);
	NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
	
	[settings setValue: self.username forKey: @"username"];
	[settings setValue: self.password forKey: @"password"];
}

@end
