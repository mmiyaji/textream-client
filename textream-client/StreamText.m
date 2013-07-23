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
        [self setBezeled:NO];
        [self setDrawsBackground:NO];
        [self setEditable:NO];
        [self setSelectable:NO];
        [[self cell] setBackgroundStyle:NSBackgroundStyleRaised];
        [self setFont:[NSFont systemFontOfSize:26.0]];
        [self setTextColor:[NSColor blackColor]];
        NSShadow* shadow = [[NSShadow alloc] init];
        shadow.shadowBlurRadius = 2; //set how many pixels the shadow has
        shadow.shadowOffset = NSMakeSize(2, -2); //the distance from the text the shadow is dropped
        shadow.shadowColor = [NSColor blackColor];
        [self setShadow:shadow];
    }
    
    return self;
}
int TEXT_HEIGHTS = 33;
- (void)showText:(NSString*)str
{
    [self setStringValue:str];
    _string_attributes = [[self attributedStringValue] attributesAtIndex:0 effectiveRange:nil];
    NSSize size = [str sizeWithAttributes:_string_attributes];
    [self setFrameSize:NSMakeSize(size.width + 5, size.height)];
    NSLog(@"%f", size.width);
    NSPoint startAt = [self frame].origin;
    NSPoint endAt = NSMakePoint(-size.width + 5, startAt.y);
    CGFloat duration = 5;
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:duration];
    [[NSAnimationContext currentContext] setCompletionHandler:^{
        NSLog(@"****");
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
