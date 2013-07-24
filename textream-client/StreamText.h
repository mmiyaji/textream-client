//
//  StreamText.h
//  textream-client
//
//  Created by Masahiro MIYAJI on 7/23/13.
//  Copyright (c) 2013 Masahiro MIYAJI. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface StreamText : NSTextField{
    NSDictionary* _string_attributes;
    NSSize textSize;
    NSTimer*    _timer;
    CGFloat _duration;
}
- (void)setDuration:(CGFloat)d;
-(void)showText:(NSString*)str;
@end
