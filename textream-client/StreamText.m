//
//  StreamText.m
//  textream-client
//
//  Created by Masahiro MIYAJI on 7/23/13.
//  Copyright (c) 2013 Masahiro MIYAJI. All rights reserved.
//

#import "StreamText.h"

@implementation StreamText

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
    _string_attributes = [[NSMutableDictionary dictionary] retain];
    [_string_attributes setObject:[NSColor whiteColor]
                           forKey:NSForegroundColorAttributeName];
    [_string_attributes setObject:[NSFont boldSystemFontOfSize:26.0]
                           forKey: NSFontAttributeName];
    NSSize size = [str sizeWithAttributes:_string_attributes];
    
    NSPoint startAt = [self frame].origin;
    NSPoint endAt = NSMakePoint(-size.width, startAt.y);
    CGFloat duration = 5;
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:duration];
    [[self animator] setFrameOrigin:endAt];
    
    [NSAnimationContext endGrouping];
}
@end
