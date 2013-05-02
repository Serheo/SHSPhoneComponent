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

-(NSDictionary *) resetConfig
{
    return @{ @"default": @{ @"format": @"#############", @"image": [NSNull null]} };
}
-(NSDictionary *) defaultConfig
{
    return @{ @"default": @{ @"format": @"## (###) ###-##-##", @"image": [NSNull null]} };
}

-(NSDictionary *) predefinedConfig
{
   return  @{
      // Russia
      @"^\\+7[0-689]\\d*$": @{ @"format": @"## (###) ###-##-##", @"image": @"shs-image.bundle/flag_RU.png"},
      
      // Kazakhstan
      @"^\\+77\\d*$":  @{ @"format": @"## (###) ###-##-##", @"image": @"shs-image.bundle/flag_KZ.png"},
      
      // Belorussia
      @"^\\+375\\d*$": @{ @"format": @"#### (##) ###-##-##", @"image": @"shs-image.bundle/flag_BY.png"},
      
      // Ukraine
      @"^\\+380\\d*$": @{ @"format": @"#### (##) ###-##-##", @"image": @"shs-image.bundle/flag_UA.png"},
      
      // Armenia
      @"^\\+374\\d*$": @{ @"format": @"#### (##) ###-###", @"image": @"shs-image.bundle/flag_AM.png"},
      
      // Tajikistan
      @"^\\+992\\d*$": @{ @"format": @"#### (##) ###-##-##", @"image": @"shs-image.bundle/flag_TJ.png"},
      
      // Kirgistan
      @"^\\+996\\d*$": @{ @"format": @"#### (##) ###-##-##", @"image": @"shs-image.bundle/flag_KG.png"},
      
      // Uzbekistan
      @"^\\+998\\d*$": @{ @"format": @"#### (##) ###-##-##", @"image": @"shs-image.bundle/flag_UZ.png"},
      
      // Moldova
      @"^\\+373\\d*$": @{ @"format": @"#### (##) ###-###", @"image": @"shs-image.bundle/flag_MD.png"},
      
      // Azerbaijan
      @"^\\+994\\d*$": @{ @"format": @"#### (##) ###-##-##", @"image": @"shs-image.bundle/flag_AZ.png"},
      
      // Turkmenistan
      @"^\\+993\\d*$": @{ @"format": @"#### (##) ###-###", @"image": @"shs-image.bundle/flag_TM.png"},
      
      // Default
      @"default": @{ @"format": @"#############", @"image": [NSNull null]}
      };
}

#pragma mark -
#pragma mark Format Setters

-(void) resetFormats
{
    config = [[NSMutableDictionary alloc]initWithDictionary:[self resetConfig]];
}

-(void) setDefaultFormat
{
    config = [[NSMutableDictionary alloc]initWithDictionary:[self defaultConfig]];
}

-(void) setPredefinedFormats
{
    config = [[NSMutableDictionary alloc]initWithDictionary:[self predefinedConfig]];
}

-(void) setDefaultOutputPattern:(NSString *)pattern imagePath:(NSString *)imagePath
{
    if (!imagePath) imagePath = (id)[NSNull null];
    [config setObject:@{@"format": pattern, @"image": imagePath} forKey:@"default"];
}

-(void) addOutputPattern:(NSString *)pattern forRegExp:(NSString *)regexp imagePath:(NSString *)imagePath
{
    if (!imagePath) imagePath = (id)[NSNull null];
    [config setObject:@{@"format": pattern, @"image": imagePath} forKey:regexp];
}

#pragma mark -

@end


