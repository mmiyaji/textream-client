//
//  AppDelegate.m
//  textream-client
//
//  Created by Masahiro MIYAJI on 7/17/13.
//  Copyright (c) 2013 Masahiro MIYAJI. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
int count;
- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    count = 1;
    NSRect  screenFrame = [[NSScreen mainScreen] frame];
    [_screen setFrame:screenFrame display:YES];
    [_screen setStyleMask:NSBorderlessWindowMask];
    [_screen setOpaque:NO];
    [_screen setBackgroundColor:[NSColor clearColor]];
    [_screen makeKeyAndOrderFront:self];
    [_screen setCollectionBehavior:  (NSWindowCollectionBehaviorCanJoinAllSpaces |
                                      NSWindowCollectionBehaviorStationary |
                                      NSWindowCollectionBehaviorIgnoresCycle)];
    [_screen setLevel:NSFloatingWindowLevel];
    [self showStatusBar];
    SRWebSocket *web_socket = [[SRWebSocket alloc] initWithURLRequest:
                               [NSURLRequest requestWithURL:[NSURL URLWithString:[_url_field stringValue]]]];
    [web_socket setDelegate:self];
    [web_socket open];
}
- (void)webSocketDidOpen:(SRWebSocket *)webSocket{
    [webSocket send:@"クライアントが接続されました"];
}
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
    NSLog(@"%@", [message description]);
    [self createText:[message description]:count++];
}
-(void)showStatusBar{
    _status_bar = [NSStatusBar systemStatusBar];
    [_status_bar retain];
    _status_item = [_status_bar statusItemWithLength:NSVariableStatusItemLength];
    [_status_item retain];
    [_status_item setTitle:@"textream"];
//    [_status_item setImage:[NSImage imageNamed:@"cut"]];
//    [_status_item setAlternateImage:[NSImage imageNamed:@"cut2"]];
    [_status_item setHighlightMode:YES];
    [_status_item setMenu:_menu];
}
-(void)removeStatusBar{
    if(_status_bar){
        [_status_bar removeStatusItem:_status_item];
        [_status_bar release];
        [_status_item setMenu:Nil];
        [_status_item release];
    }
}
-(IBAction)openAboutPanel:(id)sender{
    [NSApp orderFrontStandardAboutPanel:self];
    [NSApp activateIgnoringOtherApps:YES];
}
-(IBAction)openPereferecesWindow:(id)sender{
//    [_preferences_window makeKeyAndOrderFront:nil];
    [NSApp activateIgnoringOtherApps:YES];
}
int TEXT_HEIGHT = 33;
- (void)createText:(NSString*)str :(NSInteger)i{
    NSTextField *textField;
    textField = [[NSTextField alloc] initWithFrame:NSMakeRect(10, TEXT_HEIGHT*i, 600, TEXT_HEIGHT)];
    [textField setStringValue:str];
    [textField setBezeled:NO];
    [textField setDrawsBackground:NO];
    [textField setEditable:NO];
    [textField setSelectable:NO];
    [[textField cell] setBackgroundStyle:NSBackgroundStyleRaised];
    [textField setFont:[NSFont systemFontOfSize:26.0]];
    [textField setTextColor:[NSColor blackColor]];
    NSShadow* shadow = [[NSShadow alloc] init];
    shadow.shadowBlurRadius = 2; //set how many pixels the shadow has
    shadow.shadowOffset = NSMakeSize(2, -2); //the distance from the text the shadow is dropped
    shadow.shadowColor = [NSColor blackColor];
    [textField setShadow:shadow];
    [_screen_view addSubview:textField];
}

@end
