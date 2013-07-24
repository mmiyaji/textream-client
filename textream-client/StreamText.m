//
//  StreamText.m
//  textream-client
//
//  Created by Masahiro MIYAJI on 7/23/13.
//  Copyright (c) 2013 Masahiro MIYAJI. All rights reserved.
//

#import "StreamText.h"
#define TEXT_W_OFFSET 5
@implementation StreamText
- (void)dealloc
{
    [super dealloc];
}
- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _duration = 5;
        [self setBezeled:NO];
        [self setDrawsBackground:NO];
        [self setEditable:NO];
        [self setSelectable:NO];
        [self setFont:[NSFont boldSystemFontOfSize:46.0]];
        [self setTextColor:[NSColor blackColor]];
        NSShadow* shadow = [[NSShadow alloc] init];
        shadow.shadowBlurRadius = 3;
        shadow.shadowOffset = NSMakeSize(2, -2);
        shadow.shadowColor = [NSColor blackColor];
        [[self cell] setBackgroundStyle:NSBackgroundStyleRaised];
        [[self cell] setBackgroundColor:[NSColor blackColor]];
        [self setShadow:shadow]; // 反映されない うーむ
    }
    return self;
}
- (void)setDuration:(CGFloat)d
{
    _duration = d;
}
- (void)showText:(NSString*)str
{
    [self setStringValue:str];
    // 現在のテキストの設定を取得
    _string_attributes = [[self attributedStringValue] attributesAtIndex:0 effectiveRange:nil];
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
    [self removeFromSuperview];
}
@end
