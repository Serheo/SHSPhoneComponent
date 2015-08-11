//
//  SHSFormatter.m
//  PhoneComponentExample
//
//  Created by Will on 20/07/15.
//  Copyright (c) 2015 SHS. All rights reserved.
//

#import "SHSFormatter.h"
#import "SHSPhoneLogic.h"
#import "SHSFormattedTextField.h"
#import "SHSFlagAccessoryView.h"

@implementation SHSFormatter

-(instancetype) init
{
    self = [super init];
    if (self) {
        [self resetFormatsToDefault];
        _canAffectLeftViewByFormatter = NO;
        self.prefix = @"";
    }
    return self;
}

#pragma mark -
#pragma mark Filtering Input String



-(NSString *) stringWithoutFormat:(NSString *)aString
{
    aString = [self valuableCharOnlyString:aString];
    NSDictionary *dict = [self configForSequence:aString];
    
    NSArray *removeRanges = @[];
    NSString *format = dict[@"format"];
    for (NSInteger i = 0; i < MIN(format.length, [aString length]); i++)
    {
        unichar formatCh = [format characterAtIndex:i];
        unichar originalCh = [aString characterAtIndex:i];

        if (formatCh == originalCh && [self isRequireSubstitute:formatCh] == false)
        {
            removeRanges = [removeRanges arrayByAddingObject:[NSValue valueWithRange:NSMakeRange(i, 1)]];
        }
    }
    
    for (NSInteger i = removeRanges.count -1; i >= 0; i--) {
        NSValue *value = removeRanges[i];
        aString = [aString stringByReplacingCharactersInRange:[value rangeValue] withString:@""];
    }
    
    return aString;
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

-(void) applyText:(NSString *)text {
    
    if (!text) text = @"";
    NSDictionary *result = [self configValuesForString:text];
    self.textField.text = result[@"text"];
    
    if ( self.textField.formatter.canAffectLeftViewByFormatter )
        [self updateLeftImageView:self.textField imagePath:result[@"image"]];
}

-(void) setImageLeftView:(UITextField *)textField image:(UIImage *)image
{
    if (![textField.leftView isKindOfClass:[SHSFlagAccessoryView class]])
    {
        textField.leftView = [[SHSFlagAccessoryView alloc] initWithTextField:textField];
    }
    textField.leftViewMode = UITextFieldViewModeAlways;
    ((SHSFlagAccessoryView *)textField.leftView).image = image;
}

-(void) updateLeftImageView:(UITextField *)textField imagePath:(NSString *)imagePath
{
    if (imagePath == (id)[NSNull null]) imagePath = nil;
    if (imagePath)
    {
        UIImage *givenImage = [UIImage imageNamed:imagePath];
        [self setImageLeftView:textField image:givenImage];
    }
    else
        textField.leftViewMode = UITextFieldViewModeNever;
}


-(NSString *) applyFormat:(NSString *)format forText:(NSString *)aText;
{
     NSMutableString *result = [[NSMutableString alloc] init];
    if (format) {
   
        
        NSInteger charIndex = 0;
        for (NSInteger i = 0; i < [format length] && charIndex < [aText length]; i++) {
            
            unichar ch = [format characterAtIndex:i];
            if ([self isRequireSubstitute:ch])
            {
                unichar sp = [aText characterAtIndex:charIndex++];
                [result appendString:[NSString stringWithCharacters:&sp length:1]];
            }
            else
            {
                [result appendString:[NSString stringWithCharacters:&ch length:1]];
            }
        }
    } else {
        result = [aText mutableCopy];
    }

    return [NSString stringWithFormat:@"%@%@", self.prefix, result];
}

-(NSDictionary *) configValuesForString:(NSString *)aString
{
    NSString *nonPrefix = aString;
    if ([aString hasPrefix:self.prefix]) nonPrefix = [aString substringFromIndex:self.prefix.length];
    
    NSString *valuableString = [self valuableCharOnlyString:nonPrefix];
    NSDictionary *configDict = [self configForSequence:valuableString];
    NSString *result = [self applyFormat: configDict[@"format"] forText:valuableString];
    
    NSObject *image = [NSNull null];
    if (configDict[@"image"]) {
        image = configDict[@"image"];
    }
    return @{ @"image": image, @"text": result };
}

#pragma mark -
#pragma mark Formatted Remove


-(NSString *) valuableCharOnlyString:(NSString *)aString
{
    NSArray *removeRanges = @[];
    for (NSInteger i = 0; i < aString.length; i++)
    {
        unichar originalCh = [aString characterAtIndex:i];
        
        if ([self isValuableChar:originalCh] == false)
        {
            removeRanges = [removeRanges arrayByAddingObject:[NSValue valueWithRange:NSMakeRange(i, 1)]];
        }
    }
    
    for (NSInteger i = removeRanges.count -1; i >= 0; i--) {
        NSValue *value = removeRanges[i];
        aString = [aString stringByReplacingCharactersInRange:[value rangeValue] withString:@""];
    }
    
    return aString;
}

-(NSInteger) valuableCharCountIn:(NSString *)string
{
    NSInteger count = 0;
    for (NSInteger i = 0; i< [string length]; i++) {
        unichar ch = [string characterAtIndex:i];
        if ([self isValuableChar:ch]) count++;
    }
    return count;
}

-(BOOL) isValuableChar:(unichar)ch
{
    return YES;
}

//-(NSString *) formattedRemove:(NSString *)string AtIndex:(NSRange)range
//{
//    NSMutableString *newString = [[NSMutableString alloc] initWithString:string];
//    NSInteger removeCount = [self valuableCharCountIn:[newString substringWithRange:range]];
//    if (range.length == 1) removeCount = 1;
//    
//    for (NSInteger wordCount = 0 ; wordCount < removeCount; wordCount++) {
//        
//        for (NSInteger i = range.location + range.length - wordCount -1; i >= 0; i--) {
//            unichar ch = [newString characterAtIndex:i];
//            if ( [self isValuableChar:ch] )
//            {
//                [newString deleteCharactersInRange:NSMakeRange(i, 1)];
//                break;
//            }
//        }
//    }
//    
//    return newString;
//}

#pragma mark -
#pragma mark NSFormatter requirements

-(BOOL) getObjectValue:(id *)obj forString:(NSString *)string errorDescription:(NSString  **)error {
    *obj = [self stringWithoutFormat:string];
    return YES;
}

-(NSString *) stringForObjectValue:(id)anObject
{
    if (![anObject isKindOfClass:[NSString class]]) return nil;
    return [self configValuesForString:anObject][@"text"];
}

#pragma mark -

-(void) setPrefix:(NSString *)prefix
{
    _prefix = (prefix ? prefix : @"");
    [self applyText:@""];
}


#pragma mark -
#pragma mark Format Setters

-(NSDictionary *) defaultPattern
{
    return @{ @"format": @"#############", @"image": [NSNull null]};
}

-(void) resetFormatsToDefault
{
    NSDictionary * defaultPattern = @{@"default": self.defaultPattern};
    config = [[NSMutableDictionary alloc]initWithDictionary:@{ @"default": defaultPattern }];
}

-(void) setDefaultOutputPattern:(NSString *)pattern imagePath:(NSString *)imagePath
{
    if (imagePath)
        self.canAffectLeftViewByFormatter = YES;
    else
        imagePath = (id)[NSNull null];
    [config setObject:@{@"format": pattern, @"image": imagePath} forKey:@"default"];
}

-(void) setDefaultOutputPattern:(NSString *)pattern
{
    [self setDefaultOutputPattern:pattern imagePath:nil];
}

-(void) addOutputPattern:(NSString *)pattern forRegExp:(NSString *)regexp imagePath:(NSString *)imagePath
{
    if (imagePath)
        self.canAffectLeftViewByFormatter = YES;
    else
        imagePath = (id)[NSNull null];
    
    [config setObject:@{@"format": pattern, @"image": imagePath} forKey:regexp];
}

-(void) addOutputPattern:(NSString *)pattern forRegExp:(NSString *)regexp
{
    [self addOutputPattern:pattern forRegExp:regexp imagePath:nil];
}

-(void) setOutputPatternsFromArray:(NSArray *)patterns
{
    if (patterns) {
        for (NSDictionary * pattern in patterns) {
            NSString * format = pattern[@"format"];
            NSString * regexp = pattern[@"regexp"];
            
            if (format && regexp) {
                [self addOutputPattern:format forRegExp:regexp imagePath:pattern[@"imagePath"]];
            }
        }
    }
}

#pragma mark -

@end
