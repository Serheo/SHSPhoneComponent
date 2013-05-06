//
//  SHSPhoneNumberFormatter.m
//  PhoneComponentExample
//
//  Created by Willy on 18.04.13.
//  Copyright (c) 2013 SHS. All rights reserved.
//

#import "SHSPhoneNumberFormatter.h"
#import "SHSPhoneNumberFormatter+UserConfig.h"

@implementation SHSPhoneNumberFormatter

-(id) init
{
    self = [super init];
    if (self) {
        [self setDefaultFormat];
    }
    return self;
}

#pragma mark -
#pragma mark Filtering Input String

-(NSString *) digitOnlyString:(NSString *)aString
{
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\D"
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    return [regex stringByReplacingMatchesInString:aString options:0 range:NSMakeRange(0, [aString length]) withTemplate:@""];
}


#pragma mark -
#pragma mark Find Matched Dictionary

-(BOOL) matchString:(NSString *)aString withPattern:(NSString *)pattern
{
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    NSTextCheckingResult *match = [regex firstMatchInString:aString options:0 range:NSMakeRange(0, [aString length])];
    return match ? YES : NO;
}

-(NSDictionary *) configForSequence:(NSString *)aString
{
    for (NSString *format in [config allKeys]) {
        if ([self matchString:aString withPattern:format])
        {
            return config[format];
        }
    }
    return config[@"default"];
}


#pragma mark -
#pragma mark Getting Formatted String And Image Path

-(BOOL) isRequireSubstitute:(unichar)ch
{
    return ( ch == '#') ? YES : NO;
}

-(NSString *) applyFormat:(NSString *)format forFormattedString:(NSString *)formattedDigits
{
    NSMutableString *result = [[NSMutableString alloc] init];
    
    int charIndex = 0;
    for (int i = 0; i < [format length] && charIndex < [formattedDigits length]; i++) {
        
        unichar ch = [format characterAtIndex:i];
        if ([self isRequireSubstitute:ch])
        {
            unichar sp = [formattedDigits characterAtIndex:charIndex++];
            [result appendString:[NSString stringWithCharacters:&sp length:1]];
        }
        else
        {
            [result appendString:[NSString stringWithCharacters:&ch length:1]];
        }
    }
    return result;
}

-(NSDictionary *) valuesForString:(NSString *)aString
{
    NSString *formattedDigits = [self digitOnlyString:aString];
    NSDictionary *configDict = [self configForSequence:formattedDigits];
    NSString *result = [self applyFormat: configDict[@"format"] forFormattedString:formattedDigits];
    
    return @{ @"image": configDict[@"image"], @"text": result };
}

#pragma mark -
#pragma mark Formatted Remove

+(int) valuableCharCountIn:(NSString *)string
{
    int count = 0;
    for (int i = 0; i< [string length]; i++) {
        unichar ch = [string characterAtIndex:i];
        if ([self isValuableChar:ch]) count++;
    }
    return count;
}

+(BOOL) isValuableChar:(unichar)ch
{
    return (ch >= '0' && ch <= '9') ? YES : NO;
}

+(NSString *) formattedRemove:(NSString *)string AtIndex:(NSRange)range
{
    NSMutableString *newString = [[NSMutableString alloc] initWithString:string];
    int removeCount = [self valuableCharCountIn:[newString substringWithRange:range]];
    if (range.length == 1) removeCount = 1;
    
    for (int wordCount = 0 ; wordCount < removeCount; wordCount++) {
        
        for (int i = range.location + range.length - wordCount -1; i >= 0; i--) {
            unichar ch = [newString characterAtIndex:i];
            if ( [self isValuableChar:ch] )
            {
                [newString deleteCharactersInRange:NSMakeRange(i, 1)];
                break;
            }
        }
    }
    
    return newString;
}

#pragma mark -
#pragma mark NSFormatter requirements

-(BOOL) getObjectValue:(id *)obj forString:(NSString *)string errorDescription:(NSString  **)error {
    *obj = [self digitOnlyString:string];
    return YES;
}

-(NSString *) stringForObjectValue:(id)anObject
{
    if (![anObject isKindOfClass:[NSString class]]) return nil;
    return [self valuesForString:anObject][@"text"];
}

#pragma mark -

@end