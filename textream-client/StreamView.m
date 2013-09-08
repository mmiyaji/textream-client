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
    _text_size = 44;
//    [_message retain];
    return self;
}
-(void)drawRect:(NSRect)rect{
    _shadow = [[[NSShadow alloc] init] retain];
    _shadow.shadowBlurRadius = 10;
    _shadow.shadowOffset = NSMakeSize(0, 0);
    _shadow.shadowColor = _scolor;
    [_shadow set];
    if(_message){
        [_message drawAtPoint:NSMakePoint(0,0)
               withAttributes:_border_attributes];
        [_message drawAtPoint:NSMakePoint(0,0)
               withAttributes:_string_attributes];
    }
}
- (void)setTextColor:(NSColor*)c
{
    _color = c;
    [_color set];
    [_color retain];
}
- (void)setShadowColor:(NSColor*)c
{
    _scolor = c;
    [_scolor set];
    [_scolor retain];
}
- (void)setDuration:(CGFloat)d
{
    _duration = d;
}
- (void)setTextSize:(NSInteger)s
{
    _text_size = s;
}
- (void)showText:(NSString*)str
{
//    [_string_attributes release];
    _string_attributes = [[NSMutableDictionary dictionary] retain];
    _border_attributes = [[NSMutableDictionary dictionary] retain];
    [_string_attributes setObject:_color
                           forKey:NSForegroundColorAttributeName];
    [_string_attributes setObject:[NSFont boldSystemFontOfSize:_text_size]
                           forKey: NSFontAttributeName];
    [_border_attributes setObject:[NSFont boldSystemFontOfSize:_text_size]
                           forKey: NSFontAttributeName];
    [_border_attributes setObject:[[NSNumber alloc]initWithFloat:_text_size/4]
                           forKey:NSStrokeWidthAttributeName];
    [_border_attributes setObject:_scolor forKey: NSStrokeColorAttributeName];
    _message = str;
    [_message retain];
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
    [_message release];
    [self removeFromSuperview];
}

@end
