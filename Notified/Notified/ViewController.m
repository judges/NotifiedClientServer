//
//  ViewController.m
//  Notified
//
//  Created by PAWAN POUDEL on 7/24/12.
//  Copyright (c) 2012 Mobile Defense Inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NSNetServiceDelegate, NSNetServiceBrowserDelegate> {
    NSNetService *desktopServer;
    NSNetServiceBrowser *browser;
}

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@end

@implementation ViewController

#pragma mark - Accessors

@synthesize statusLabel;

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Search for all http servers on the local area network
    browser = [[NSNetServiceBrowser alloc] init];
    [browser setDelegate:self];
    [browser searchForServicesOfType:@"_http._tcp." inDomain:@""];
}

- (void)viewDidUnload {
    [self setStatusLabel:nil];
    [super viewDidUnload];
}

#pragma mark - Rotation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - NSNetServiceBrowser delegate methods

- (void)netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser
           didFindService:(NSNetService *)aNetService
               moreComing:(BOOL)moreComing 
{
    // Looking for an HTTP service, but only one with the name CocoaHTTPServer
    if (!desktopServer && [[aNetService name] isEqualToString:@"CocoaHTTPServer"]) {
        desktopServer = aNetService;
        [desktopServer resolveWithTimeout:30];
        [desktopServer setDelegate:self];
        [statusLabel setText:@"Resolving CocoaHTTPServer..."];
    }
}

#pragma mark - NSNetService delegate methods

- (void)netServiceDidResolveAddress:(NSNetService *)sender {
    self.statusLabel.text = @"Resolved service...";
}

- (void)netService:(NSNetService *)sender didNotResolve:(NSDictionary *)errorDict {
    self.statusLabel.text = @"Could not resolve service.";
    NSLog(@"%@", errorDict);
    
    desktopServer = nil;
}

@end
