//
//  StreamText.m
//  textream-client
//
//  Created by Masahiro MIYAJI on 7/23/13.
//  Copyright (c) 2013 Masahiro MIYAJI. All rights reserved.
//

#import "StreamText.h"

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
        shadow.shadowBlurRadius = 2; //set how many pixels the shadow has
        shadow.shadowOffset = NSMakeSize(2, -2); //the distance from the text the shadow is dropped
        shadow.shadowColor = [NSColor blackColor];
        [[self cell] setBackgroundStyle:NSBackgroundStyleRaised];
        [self setShadow:shadow];
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
    _string_attributes = [[self attributedStringValue] attributesAtIndex:0 effectiveRange:nil];
    NSSize size = [str sizeWithAttributes:_string_attributes];
    [self setFrameSize:NSMakeSize(size.width + 5, size.height)];
    NSPoint startAt = [self frame].origin;
    NSPoint endAt = NSMakePoint(-size.width + 5, startAt.y);
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
    [self release];
}
@end
