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
    IBOutlet NSMenu*    _menu;              // menu bar
    NSStatusBar*        _status_bar;     // 上のメニューバーに表示する。常駐型なのでアプリケーション終了はここらか
    NSStatusItem*       _status_item;       // menu bar item
}
-(IBAction)openAboutPanel:      (id)sender;
-(IBAction)openPereferecesWindow:(id)sender;

@property (assign) IBOutlet NSWindow *window;

@end
