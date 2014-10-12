//
//  SHSPhoneNumberFormatter+UserConfig.m
//  PhoneComponentExample
//
//  Created by Willy on 24.04.13.
//  Copyright (c) 2013 SHS. All rights reserved.
//

#import "SHSPhoneNumberFormatter+UserConfig.h"

@implementation SHSPhoneNumberFormatter (UserConfig)

#pragma mark Predefined Configs

-(NSDictionary *) defaultPattern
{
    return @{ @"format": @"#############", @"image": [NSNull null]};
}

-(NSDictionary *) resetConfig
{
    return @{ @"default": [self defaultPattern] };
}

#pragma mark -
#pragma mark Format Setters

-(void) resetDefaultFormat
{
    if (config) {
        [config setObject:[self defaultPattern] forKey:@"default"];
    }
    else {
        config = [[NSMutableDictionary alloc] initWithDictionary:@{ @"default": [self defaultPattern] }];
    }
}

-(void) resetFormats
{
    NSDictionary * defaultPattern = [config objectForKey:@"default"];
    
    if (defaultPattern) {
        // Don't reset default pattern if exists
        config = [[NSMutableDictionary alloc]initWithDictionary:@{ @"default": defaultPattern }];
    }
    else {
        config = [[NSMutableDictionary alloc]initWithDictionary:[self resetConfig]];
    }
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
    [config setObject:@{@"format": pattern, @"image": [NSNull null]} forKey:@"default"];
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
    [config setObject:@{@"format": pattern, @"image": [NSNull null]} forKey:regexp];
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


