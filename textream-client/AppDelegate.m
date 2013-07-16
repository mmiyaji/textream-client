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
    for (int i=0; i<10; i++) {
        [self createText:@"テキストなんですよ":i];
    }
}

- (void)createText:(NSString*)str :(NSInteger)i{
    NSTextField *textField;
    textField = [[NSTextField alloc] initWithFrame:NSMakeRect(10, 15*i, 200, 17)];
    [textField setStringValue:str];
    [textField setBezeled:NO];
    [textField setDrawsBackground:NO];
    [textField setEditable:NO];
    [textField setSelectable:NO];
    [_screen_view addSubview:textField];
}

@end
