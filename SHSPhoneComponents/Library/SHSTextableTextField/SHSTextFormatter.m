//
//  SHSUniversalFormatter.m
//  PhoneComponentExample
//
//  Created by Will on 15/07/15.
//  Copyright (c) 2015 SHS. All rights reserved.
//

#import "SHSFormatter.h"
#import "SHSTextFormatter.h"
#import "SHSPhoneLogic.h"


@implementation SHSTextFormatter

#pragma mark -
#pragma mark Filtering Input String

-(NSString *) valuableString:(NSString *)aString
{
    return aString;
}

-(NSString *) stringWithoutFormat:(NSString *)aString
{
    NSString *swf = [super stringWithoutFormat:aString];
    return [self valuableString:swf];
}


#pragma mark -
#pragma mark Formatted Remove

-(BOOL) isValuableChar:(unichar)ch
{
    NSString *chs = [NSString stringWithFormat: @"%C", ch];
    BOOL result = [self matchString:chs withPattern:@"\\w"];
    return result;
}

#pragma mark -
#pragma mark Predefined Configs

-(NSDictionary *) defaultPattern
{
    return @{ @"format": [NSNull null], @"image": [NSNull null]};
}

#pragma mark -

@end
