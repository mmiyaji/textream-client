//
//  AppDelegate.h
//  textream-client
//
//  Created by Masahiro MIYAJI on 7/17/13.
//  Copyright (c) 2013 Masahiro MIYAJI. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>{
    IBOutlet NSWindow*  _screen;
    IBOutlet NSView*    _screen_view;
}

@property (assign) IBOutlet NSWindow *window;

@end
