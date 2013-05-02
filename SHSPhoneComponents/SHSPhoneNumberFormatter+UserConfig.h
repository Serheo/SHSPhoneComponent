//
//  SHSPhoneNumberFormatter+UserConfig.h
//  PhoneComponentExample
//
//  Created by Willy on 24.04.13.
//  Copyright (c) 2013 SHS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHSPhoneNumberFormatter.h"

@interface SHSPhoneNumberFormatter (UserConfig)

/**
 Remove all patterns and apply clear format style.
 Default format is @"#############", imagePath is nil.
*/
-(void) resetFormats;

/**
 Remove all patterns and apply default format style. 
 Default format is "## (###) ###-##-##", imagePath is nil.
*/
-(void) setDefaultFormat;

/**
 Remove all patterns and set predefined values.
 Method contains values for next countries:
 Russia, Kazakhstan, Belorussia, Ukraine, Armenia, Tajikistan, Kirgistan,
 Uzbekistan, Moldova, Azerbaijan, Turkmenistan
 Default format is "#############", imagePath is nil.
*/
-(void) setPredefinedFormats;

/**
 Apply default format style and image
 Symbol '#' assumes all digits and '+'.
 Example is "## (###) ###-##-##", imagePath is "flag_ru".
*/
-(void) setDefaultOutputPattern:(NSString *)pattern imagePath:(NSString *)imagePath;

/**
 All number matched your regexp will formatted with your style and image
 Symbol '#' assumes all digits and '+'.
 Example: pattern is "## (###) ###-##-##", imagePath is "flag_ru", regexp is "^\\+375\\d*$"
*/
-(void) addOutputPattern:(NSString *)pattern forRegExp:(NSString *)regexp imagePath:(NSString *)imagePath;
@end
