//
//  AppDelegate.m
//  textream-client
//
//  Created by Masahiro MIYAJI on 7/17/13.
//  Copyright (c) 2013 Masahiro MIYAJI. All rights reserved.
//

#import "AppDelegate.h"
#import "StreamText.h"
#import "StreamView.h"
#define HEARTBEAT_TIME 10.0f
#define ARC4RANDOM_MAX      0x100000000
// ユーザ変数として保存するメソッド。型によって使い分け
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
bool isAlive;
- (void)dealloc
{
    [_web_socket release];
    [super dealloc];
}
float randFloat(float a, float b)
{
    return ((b-a)*((float)arc4random()/ARC4RANDOM_MAX))+a;
}
static NSColor *colorFromRGB(unsigned char r, unsigned char g, unsigned char b)
{
    return [NSColor colorWithCalibratedRed:(r/255.0f) green:(g/255.0f) blue:(b/255.0f) alpha:1.0];
}
// ユーザ変数の初期値設定。値に何も設定されていない場合のみ反映。
-(void)initUserDefaults{
    id defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObjectIfNeeded:@"ws://localhost:8080"  forKey:@"server_url"];
}

//  アプリケーション起動時
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // ユーザ変数初期化
    [self initUserDefaults];
    count = 0;
    isAlive = true;
    // 表示領域全体の大きさを取得
    NSScreen* screenFrame = [[NSScreen screens] objectAtIndex:
                           [_window_button indexOfSelectedItem]];
    // メニューバーを除いた表示領域の大きさ取得
    _visible_screen_rect = [screenFrame visibleFrame];
    _text_array = [NSMutableArray array];
    // 透明ウィンドウ作成
    [_screen setFrame:[screenFrame frame] display:YES];
    [_screen setStyleMask:NSBorderlessWindowMask];
    [_screen setOpaque:NO];
    [_screen setBackgroundColor:[NSColor clearColor]];
    [_screen makeKeyAndOrderFront:self];
    [_screen setCollectionBehavior:  (NSWindowCollectionBehaviorCanJoinAllSpaces |
                                      NSWindowCollectionBehaviorStationary |
                                      NSWindowCollectionBehaviorIgnoresCycle)];
    [_screen setLevel:NSFloatingWindowLevel];
    // メニューバーセット
    [self showStatusBar];
    // WebsocketServerに接続
    @try {
        [self connectServer];
    }
    @catch (NSException *exception) {
        NSLog(@"error");
    }
    [NSTimer scheduledTimerWithTimeInterval:HEARTBEAT_TIME //タイマーを発生させる間隔
                                     target:self //タイマー発生時に呼び出すメソッドがあるターゲット
                                   selector:@selector(heartbeat:) //タイマー発生時に呼び出すメソッド
                                   userInfo:nil //selectorに渡す情報(NSDictionary)
                                    repeats:YES //リピート
     ];
}

-(void)heartbeat:(NSTimer*)timer
{
    if(isAlive){
        NSLog(@"heartbeat");
        isAlive = false;
        [_web_socket send:@"heart"];
    }
    else{
        NSLog(@"retry connect");
        [_web_socket close];
//        [_web_socket dealloc];
        [self connectServer];
    }
}
-(void)changeScreen:(id)sender{
    NSLog(@"change screen %ld", [_window_button indexOfSelectedItem]);
    // 表示領域全体の大きさを取得
    NSScreen* screenFrame = [[NSScreen screens] objectAtIndex:
                           [_window_button indexOfSelectedItem]];
    // メニューバーを除いた表示領域の大きさ取得
    _visible_screen_rect = [screenFrame visibleFrame];
    [_screen setFrame:[screenFrame frame] display:YES];
//    [_web_socket send:@"表示スクリーンを変更しました"];
}
- (void)webSocketDidOpen:(SRWebSocket *)webSocket{
//    [webSocket send:@"クライアントが接続されました"];
    NSLog(@"connected");
}
- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error{
    NSLog(@"fail");
    [_status_field setStringValue:@"NG"];
}
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
    if([[message description] isEqualToString:@"beat"]){
        NSLog(@"heart");
        isAlive = true;
    }
    else{
        count++;
        isAlive = true;
        NSLog(@"%@", [message description]);
        [self createText:[message description]];
        [self setLog:[message description]];
    }
}
//再接続
- (void)reloadServer:(id)sender{
    NSLog(@"reload server");
    [_web_socket close];
    [_web_socket dealloc];
    [self connectServer];
}
- (void)connectServer{
    [_status_field setStringValue:@"OK"];
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
//アプリケーション情報パネル表示
-(IBAction)openAboutPanel:(id)sender{
    [NSApp orderFrontStandardAboutPanel:self];
    [NSApp activateIgnoringOtherApps:YES];
}
//環境設定パネル表示
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
-(IBAction)sendText:(id)sender{
    [_web_socket send:[_send_field stringValue]];
//    [_send_field setStringValue:@""];
}
// 最前面化した透明ウィンドウにテキストを流し込む
- (void)createText:(NSString*)str{
    // 適当な高さを設定
//    double origin_y = ((_visible_screen_rect.size.height - _visible_screen_rect.origin.y
//                        - _mbottom_field.integerValue - _mtop_field.integerValue) * (rand() / RAND_MAX)
//                        + _mbottom_field.integerValue) - _visible_screen_rect.origin.y - 150;
    double origin_y = randFloat(_mbottom_field.integerValue + _visible_screen_rect.origin.y,
                                _visible_screen_rect.size.height - _size_field.integerValue);
//    if(origin_y > _visible_screen_rect.size.height - 150){
//        origin_y = _visible_screen_rect.size.height - 150;
//    }
//    NSTextField版
//    {
//        StreamText *textField;
//        // 適当な大きさで初期化
//        textField = [[[StreamText alloc] autorelease]
//                     initWithFrame:NSMakeRect(_visible_screen_rect.size.width, origin_y, 10, 20)];
//        [_screen_view addSubview:textField];
//        // アニメーション速度を設定
//        if([_random_button state]){
//            [textField setDuration:[_duration_field floatValue]*randFloat(
//                                                                          [_random_min_field floatValue],[_random_max_field floatValue])];
//        }else{
//            [textField setDuration:[_duration_field floatValue]];
//        }
//        // アニメーションスタート
////        [textField showText:[str stringByTrimmingCharactersInSet:[NSCharacterSet punctuationCharacterSet]]];
//        [textField showText:[str stringByTrimmingCharactersInSet:
//                             [NSCharacterSet characterSetWithCharactersInString:@"\""]]];
//    }
    
//    　NSView版
    {
        StreamView* sv = [[StreamView alloc]
                          initWithFrame:NSMakeRect(_visible_screen_rect.size.width, origin_y, 10, 20)];
        [_screen_view addSubview:sv];
        // アニメーション速度を設定
        if([_random_button state]){
            [sv setDuration:[_duration_field floatValue]*randFloat(
                                                                          [_random_min_field floatValue],[_random_max_field floatValue])];
        }else{
            [sv setDuration:[_duration_field floatValue]];
        }
        [sv setTextSize:_size_field.integerValue];
        // アニメーションスタート
        switch ([_color_button indexOfSelectedItem]) {
            case 0:
                [sv setTextColor:colorFromRGB(255, 255, 255)];
                [sv setShadowColor:colorFromRGB(0, 0, 0)];
                break;
            case 1:
                [sv setTextColor:colorFromRGB(0, 0, 0)];
                [sv setShadowColor:colorFromRGB(255, 255, 255)];
                break;
            case 2:
                [sv setTextColor:colorFromRGB(255, 0, 0)];
                [sv setShadowColor:colorFromRGB(255, 255, 255)];
                break;
            case 3:
                [sv setTextColor:colorFromRGB(0, 255, 0)];
                [sv setShadowColor:colorFromRGB(255, 255, 255)];
                break;
            case 4:
                [sv setTextColor:colorFromRGB(0, 0, 255)];
                [sv setShadowColor:colorFromRGB(255, 255, 255)];
                break;
            case 5:
                [sv setTextColor:colorFromRGB(50, 50, 50)];
                [sv setShadowColor:colorFromRGB(255, 255, 255)];
                break;
            case 6:
                [sv setTextColor:colorFromRGB(200, 80, 255)];
                [sv setShadowColor:colorFromRGB(255, 255, 255)];
                break;
            default:
                [sv setTextColor:colorFromRGB(randFloat(0,255),randFloat(0,255),randFloat(0,255))];
                [sv setShadowColor:colorFromRGB(randFloat(0,255),randFloat(0,255),randFloat(0,255))];
                break;
        }
//        [sv showText:[str stringByTrimmingCharactersInSet:[NSCharacterSet punctuationCharacterSet]]];
        [sv showText:str];
    }

}
//ログ表示領域に書き出し
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
