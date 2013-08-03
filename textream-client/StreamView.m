//
//  StreamView.m
//  textream-client
//
//  Created by Masahiro MIYAJI on 7/27/13.
//  Copyright (c) 2013 Masahiro MIYAJI. All rights reserved.
//

#import "StreamView.h"
#define TEXT_W_OFFSET 5
@implementation StreamView
- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    _message = @"textream";
    [_message retain];
    if (self) {
        [[NSColor colorWithDeviceRed:0.0 green:0.0 blue:0.0 alpha:1.] set];
    }
    
    return self;
}

-(void)drawRect:(NSRect)rect{
    _shadow = [[[NSShadow alloc] init] retain];
    _shadow.shadowBlurRadius = 5;
    _shadow.shadowOffset = NSMakeSize(0, 0);
    _shadow.shadowColor = [NSColor blackColor];
    [_shadow set];
    NSLog(@"%@", _message);
    if(_message){
        [_message drawAtPoint:NSMakePoint(0,0)
               withAttributes:_string_attributes];
    }
}
- (void)setDuration:(CGFloat)d
{
    _duration = d;
}
- (void)showText:(NSString*)str
{
//    [_string_attributes release];
    _string_attributes = [[NSMutableDictionary dictionary] retain];
    [_string_attributes setObject:[NSColor whiteColor]
                           forKey:NSForegroundColorAttributeName];
    [_string_attributes setObject:[NSFont boldSystemFontOfSize:44.0]
                           forKey: NSFontAttributeName];
    _message = str;
    // 現在のテキストの設定を取得
    NSSize size = [str sizeWithAttributes:_string_attributes];
    // フレームサイズ調整
    [self setFrameSize:NSMakeSize(size.width + TEXT_W_OFFSET, size.height)];
    NSPoint startAt = [self frame].origin;
    NSPoint endAt = NSMakePoint(-size.width + TEXT_W_OFFSET, startAt.y);
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:_duration];
    [[NSAnimationContext currentContext] setCompletionHandler:^{
        [self textClose];
    }];
    [[self animator] setFrameOrigin:endAt];
    [NSAnimationContext endGrouping];
}
- (void)textClose{
    [_shadow release];
    [_string_attributes release];
    [self removeFromSuperview];
}

@end
