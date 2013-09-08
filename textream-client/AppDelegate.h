//
//  AppDelegate.h
//  textream-client
//
//  Created by Masahiro MIYAJI on 7/17/13.
//  Copyright (c) 2013 Masahiro MIYAJI. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <SocketRocket/SRWebSocket.h>

@interface AppDelegate : NSObject <SRWebSocketDelegate>{
    IBOutlet NSWindow*  _screen;        // 透過スクリーン
    IBOutlet NSView*    _screen_view;   // 透過スクリーン上のビュー テキストはここに追加します
    IBOutlet NSMenu*    _menu;          // menu bar
    IBOutlet
        NSTextField*    _url_field;
    IBOutlet
        NSTextField*    _log_field;
    IBOutlet
        NSTextField*    _send_field;
    IBOutlet
        NSTextField*    _duration_field;
    IBOutlet
        NSTextField*    _status_field;
    IBOutlet
        NSTextField*    _mtop_field;
    IBOutlet
        NSTextField*    _mbottom_field;
    IBOutlet
        NSTextField*    _size_field;
    IBOutlet
        NSPopUpButton*  _window_button;
    IBOutlet
        NSButton*       _random_button;
    IBOutlet
        NSTextField*    _random_min_field;
    IBOutlet
        NSTextField*    _random_max_field;
    IBOutlet
        NSPopUpButton*  _color_button;
    NSStatusBar*        _status_bar;     // 上のメニューバーに表示する。常駐型なのでアプリケーション終了はここらか
    NSStatusItem*       _status_item;       // menu bar item
    SRWebSocket*        _web_socket;
    NSMutableArray*     _text_array;
    NSRect              _visible_screen_rect;
}
-(IBAction)openAboutPanel:      (id)sender;
-(IBAction)openPereferecesWindow:(id)sender;
-(IBAction)changeScreen:        (id)sender;
-(IBAction)sendText:            (id)sender;
-(IBAction)reloadServer:        (id)sender;
-(IBAction)hideScreen:          (id)sender;
-(IBAction)showScreen:          (id)sender;
-(IBAction)savePref:            (id)sender;

@property (assign) IBOutlet NSWindow *_pref_window;

@end

@interface NSUserDefaults (Preferences)
- (void)setBoolIfNeeded:    (BOOL)value     forKey:(NSString*)key;
- (void)setFloatIfNeeded:   (float)value    forKey:(NSString*)key;
- (void)setIntegerIfNeeded: (int)value      forKey:(NSString*)key;
- (void)setObjectIfNeeded:  (id)value       forKey:(NSString*)key;
@end
