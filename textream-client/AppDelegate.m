//
//  AppDelegate.m
//  textream-client
//
//  Created by Masahiro MIYAJI on 7/17/13.
//  Copyright (c) 2013 Masahiro MIYAJI. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [_screen setStyleMask:NSBorderlessWindowMask];
    [_screen setOpaque:NO];
    [_screen setBackgroundColor:[NSColor clearColor]];
    [_screen makeKeyAndOrderFront:self];
    [_screen setCollectionBehavior:  (NSWindowCollectionBehaviorCanJoinAllSpaces |
                                      NSWindowCollectionBehaviorStationary |
                                      NSWindowCollectionBehaviorIgnoresCycle)];
    [_screen setLevel:NSFloatingWindowLevel];
    
}

- (void)createText:(NSString*)str{
    NSTextField *textField;
    textField = [[NSTextField alloc] initWithFrame:NSMakeRect(10, 10, 200, 17)];
    [textField setStringValue:str];
    [textField setBezeled:NO];
    [textField setDrawsBackground:NO];
    [textField setEditable:NO];
    [textField setSelectable:NO];
}

@end
