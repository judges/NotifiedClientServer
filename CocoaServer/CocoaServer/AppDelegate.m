//
//  AppDelegate.m
//  CocoaServer
//
//  Created by PAWAN POUDEL on 7/24/12.
//  Copyright (c) 2012 Mobile Defense Inc. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

#pragma mark - Accessors

@synthesize tableView = _tableView;
@synthesize statusField = _statusField;
@synthesize window = _window;

#pragma mark - Application lifecycle

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    registeredUsers = [[NSMutableArray alloc] init];
    
    // Create a service object that will advertise the server's existence on the local network
    service = [[NSNetService alloc] initWithDomain:@"" 
                                              type:@"_http._tcp."
                                              name:@"CocoaHTTPServer"
                                              port:10000];
    [service setDelegate:self];
    [service publish];
}

#pragma mark - NSNetService delegate methods

- (void)netServiceDidPublish:(NSNetService *)sender {
    // When the service succeeds in publishing...
    [self.statusField setStringValue:@"Server is advertising"];
}

- (void)netServiceDidStop:(NSNetService *)sender {
    // If the service stops for some reason...
    [self.statusField setStringValue:@"Server is not advertising"];
}

- (void)netService:(NSNetService *)sender didNotPublish:(NSDictionary *)errorDict {
    // If the service fails to publish, either immediately or in the future...
    [self.statusField setStringValue:@"Server is not advertising"];
}


@end
