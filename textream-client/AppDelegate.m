//
//  AppDelegate.m
//  textream-client
//
//  Created by Masahiro MIYAJI on 7/17/13.
//  Copyright (c) 2013 Masahiro MIYAJI. All rights reserved.
//

#import "AppDelegate.h"
#import "StreamText.h"
// ユーザ変数として保存
@implementation NSUserDefaults (Preferences)
-(void)setBoolIfNeeded:(BOOL)value forKey:(NSString*)key
{ if(![self objectForKey:key]){ [self setBool:value forKey:key]; } }

-(void)setFloatIfNeeded:(float)value forKey:(NSString*)key
{ if(![self objectForKey:key]){ [self setFloat:value forKey:key]; } }

-(void)setIntegerIfNeeded:(int)value forKey:(NSString*)key
{ if(![self objectForKey:key]){ [self setInteger:value forKey:key]; } }

-(void)setObjectIfNeeded:(id)value forKey:(NSString*)key
{ if(![self objectForKey:key]){ [self setObject:value forKey:key]; } }
@end

@implementation AppDelegate
@synthesize _pref_window;
int count;
- (void)dealloc
{
    [_web_socket release];
    [super dealloc];
}
// ユーザ変数の初期値設定。値に何も設定されていない場合のみ反映。
-(void)initUserDefaults{
    id defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObjectIfNeeded:@"ws://localhost:8080"  forKey:@"server_url"];
}

//  アプリケーション起動時
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [self initUserDefaults];
    count = 0;
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
    @try {
        [self connectServer];
    }
    @catch (NSException *exception) {
        NSLog(@"error");
    }
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
    NSLog(@"reload server");
    [_web_socket close];
    [_web_socket dealloc];
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
// 一時的にスクリーンを隠す
-(IBAction)hideScreen:(id)sender{
    [_screen setIsVisible:false];
}
-(IBAction)showScreen:(id)sender{
    [_screen setIsVisible:true];
}
-(IBAction)savePref:(id)sender{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
}
// 最前面化した透明ウィンドウにテキストを流し込む
- (void)createText:(NSString*)str{
    // 適当な高さを設定
    double origin_y = (visibleScreenRect.size.height - 20) * rand() / RAND_MAX;
    StreamText *textField;
    // 適当な大きさで初期化
    textField = [[[StreamText alloc] autorelease]
                 initWithFrame:NSMakeRect(visibleScreenRect.size.width, origin_y, 10, 20)];
    [_screen_view addSubview:textField];
    // アニメーション速度を設定
    [textField setDuration:[_duration_field floatValue]];
    // アニメーションスタート
    [textField showText:[str stringByTrimmingCharactersInSet:[NSCharacterSet punctuationCharacterSet]]];
}
-(void)setLog:(NSString*)str{
    NSString* date_converted;
    NSDate* date_source = [NSDate date];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM/dd HH:mm:ss"];
    date_converted = [formatter stringFromDate:date_source];
    [formatter release];
    [_log_field setStringValue:[NSString stringWithFormat:@"%d. %@: %@\n %@", count, date_converted, str, [_log_field stringValue]]];
}
@end
