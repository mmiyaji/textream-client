//
//  StreamView.h
//  textream-client
//
//  Created by Masahiro MIYAJI on 7/27/13.
//  Copyright (c) 2013 Masahiro MIYAJI. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface StreamView : NSView{
    NSString*               _message;
    NSMutableDictionary*    _string_attributes;
    NSShadow*               _shadow;
    NSSize                  _text_size;
    CGFloat                 _duration;
}
-(void)setDuration:(CGFloat)d;
-(void)showText:(NSString*)str;

@end
