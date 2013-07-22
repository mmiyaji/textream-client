//
//  StreamText.h
//  textream-client
//
//  Created by Masahiro MIYAJI on 7/23/13.
//  Copyright (c) 2013 Masahiro MIYAJI. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface StreamText : NSTextField{
    NSMutableDictionary* _string_attributes;
}

-(void)showText:(NSString*)str;
@end
