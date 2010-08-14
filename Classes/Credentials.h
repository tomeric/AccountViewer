//
//  Credentials.h
//  AccountViewer
//
//  Created by Tom-Eric Gerritsen on 8/14/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Credentials : NSObject {
	NSString *username;
	NSString *password;
}

@property (retain) NSString *username;
@property (retain) NSString *password;

+(id) load;
-(BOOL) valid;
-(void) update;

@end
