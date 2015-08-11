//
//  SHSPhoneNumberFormatter.m
//  PhoneComponentExample
//
//  Created by Willy on 18.04.13.
//  Copyright (c) 2013 SHS. All rights reserved.
//

#import "SHSFormatter.h"
#import "SHSPhoneNumberFormatter.h"
#import "SHSPhoneLogic.h"
#import "SHSPhoneTextField.h"

@implementation SHSPhoneNumberFormatter

#pragma mark -
#pragma mark Filtering Input String

-(NSString *) valuableString:(NSString *)aString;
{
    return [self digitOnlyString:aString];
}

+(NSString *) digitOnlyString:(NSString *)aString
{
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\D"
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    return [regex stringByReplacingMatchesInString:aString options:0 range:NSMakeRange(0, [aString length]) withTemplate:@""];
}

-(NSString *) digitOnlyString:(NSString *)aString
{
    return [SHSPhoneNumberFormatter digitOnlyString:aString];
}

-(NSString *) stringWithoutFormat:(NSString *)aString
{
    NSString *swf = [super stringWithoutFormat:aString];
    return [self digitOnlyString:swf];
}


#pragma mark -
#pragma mark Formatted Remove

-(BOOL) isValuableChar:(unichar)ch
{
    return (ch >= '0' && ch <= '9') ? YES : NO;
}


#pragma mark -
#pragma mark Format Setters

-(NSDictionary *) defaultPattern
{
    return @{ @"format": @"#############", @"image": [NSNull null]};
}

#pragma mark -

@end