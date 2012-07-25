//
//  AppDelegate.h
//  CocoaServer
//
//  Created by PAWAN POUDEL on 7/24/12.
//  Copyright (c) 2012 Mobile Defense Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate, NSTableViewDataSource, NSTableViewDelegate, NSNetServiceDelegate> {
    NSNetService *service;
    NSMutableArray *registeredUsers;
}

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *statusField;
@property (weak) IBOutlet NSTableView *tableView;
@end
