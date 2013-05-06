//
//  SHSPhoneNumberFormatter.h
//  PhoneComponentExample
//
//  Created by Willy on 18.04.13.
//  Copyright (c) 2013 SHS. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Formatter class that converts input string to phone format.
*/
@interface SHSPhoneNumberFormatter : NSFormatter
{
    NSMutableDictionary *config;
}

/**
 Converts input string to dictionary.
 Return value format {text: "FORMATTED_PHONE_NUMBER", image: "PATH_TO_IMAGE"}
 Image path can be nil
*/
-(NSDictionary *) valuesForString:(NSString *)aString;

/**
 Remove required number of digits in phone text.
*/
+(NSString *) formattedRemove:(NSString *)string AtIndex:(NSRange)range;

/**
 Check if a chas is valuable symbol(part of number).
 Valuable chars are all digits.
*/
+(BOOL) isValuableChar:(unichar)ch;

/**
 Returns a count of valuable symbols in string.
*/
+(int) valuableCharCountIn:(NSString *)string;


@end