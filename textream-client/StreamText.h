//
//  StreamText.h
//  textream-client
//
//  Created by Masahiro MIYAJI on 7/23/13.
//  Copyright (c) 2013 Masahiro MIYAJI. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface StreamText : NSTextField{
//    テキストデコレーション用
    NSDictionary*   _string_attributes;
    NSSize          textSize;
    CGFloat         _duration;
}
-(void)setDuration:(CGFloat)d;
-(void)showText:(NSString*)str;
@end
