//
//  SHSPhoneNumberFormatter.h
//  PhoneComponentExample
//
//  Created by Willy on 18.04.13.
//  Copyright (c) 2013 SHS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHSFormatter.h"
/**
 Formatter class that converts input string to phone format.
*/
@interface SHSPhoneNumberFormatter : SHSFormatter

/**
 Returns all digits from string.
*/
+(NSString *) digitOnlyString:(NSString *)aString;
-(NSString *) digitOnlyString:(NSString *)aString;

@end