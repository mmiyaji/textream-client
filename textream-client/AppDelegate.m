//
//  AppDelegate.m
//  textream-client
//
//  Created by Masahiro MIYAJI on 7/17/13.
//  Copyright (c) 2013 Masahiro MIYAJI. All rights reserved.
//

#import "AppDelegate.h"
#import "StreamText.h"

@implementation AppDelegate
@synthesize _pref_window;
int count;
- (void)dealloc
{
    [super dealloc];
}

//  アプリケーション起動時
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    count = 1;
    visibleScreenRect = [[NSScreen mainScreen] visibleFrame];
    _text_array = [NSMutableArray array];
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
    [self connectServer];
}
- (void)webSocketDidOpen:(SRWebSocket *)webSocket{
    [webSocket send:@"クライアントが接続されました"];
}
- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error{
    NSLog(@"fail");
}
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
    count++;
    NSLog(@"%@", [message description]);
    [self createText:[message description]];
    [self setLog:[message description]];
}
- (void)reloadServer:(id)sender{
    [self connectServer];
}
- (void)connectServer{
    _web_socket = [[SRWebSocket alloc] initWithURLRequest:
                   [NSURLRequest requestWithURL:[NSURL URLWithString:[_url_field stringValue]]]];
    [_web_socket setDelegate:self];
    [_web_socket open];
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
    [_pref_window makeKeyAndOrderFront:nil];
    [NSApp activateIgnoringOtherApps:YES];
}
-(IBAction)hideScreen:(id)sender{
    [_screen setIsVisible:false];
}
-(IBAction)showScreen:(id)sender{
    [_screen setIsVisible:true];
}
int TEXT_HEIGHT = 33;
- (void)createText:(NSString*)str{
    double origin_y = (visibleScreenRect.size.height - TEXT_HEIGHT) * rand() / RAND_MAX;
    StreamText *textField;
    textField = [[StreamText alloc] initWithFrame:NSMakeRect(visibleScreenRect.size.width, origin_y, 10, TEXT_HEIGHT)];
    [_screen_view addSubview:textField];
    NSLog(@"%@", [_duration_field stringValue]);
    [textField setDuration:[_duration_field floatValue]];
    [textField showText:[str stringByTrimmingCharactersInSet:[NSCharacterSet punctuationCharacterSet]]];
}
-(void)setLog:(NSString*)str{
    [_log_field setStringValue:[NSString stringWithFormat:@"%@\n %@", str, [_log_field stringValue]]];
}
@end
