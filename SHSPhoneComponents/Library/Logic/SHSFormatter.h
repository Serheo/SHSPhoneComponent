//
//  SHSFormatter.h
//  PhoneComponentExample
//
//  Created by Will on 20/07/15.
//  Copyright (c) 2015 SHS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class SHSFormattedTextField;
typedef void (^SHSTextBlock)(UITextField *textField);

@interface SHSFormatter : NSFormatter
{
    NSMutableDictionary *config;
}

@property (readwrite) BOOL canAffectLeftViewByFormatter;
@property (copy, nonatomic) NSString *prefix;
@property (weak) SHSFormattedTextField *textField;



/**
 Converts input string to dictionary.
 Return value format {text: "FORMATTED_PHONE_NUMBER", image: "PATH_TO_IMAGE"}
 Image path can be nil
 */
-(NSDictionary *) configValuesForString:(NSString *)aString;
-(NSDictionary *) configForSequence:(NSString *)aString;

-(NSString *) stringWithoutFormat:(NSString *)aString;


/**
 If you want to use leftView or leftViewMode property set this property to NO.
 Default is NO.
 */

-(BOOL) isValuableChar:(unichar)ch;
-(NSInteger) valuableCharCountIn:(NSString *)string;


-(void) applyText:(NSString *)text;
-(BOOL) matchString:(NSString *)aString withPattern:(NSString *)pattern;

-(void) resetFormatsToDefault;

/**
 Apply default format style and image.
 Symbol '#' assumes all digits.
 Example is "+# (###) ###-##-##", imagePath is "flag_ru".
 */
-(void) setDefaultOutputPattern:(NSString *)pattern imagePath:(NSString *)imagePath;

/**
 Apply default format style.
 Symbol '#' assumes all digits.
 Example is "+# (###) ###-##-##"
 */
-(void) setDefaultOutputPattern:(NSString *)pattern;


/**
 All number matched your regexp will formatted with your style and image
 Symbol '#' assumes all digits.
 Example: pattern is "+# (###) ###-##-##", imagePath is "flag_ru", regexp is "^375\\d*$"
 */
-(void) addOutputPattern:(NSString *)pattern forRegExp:(NSString *)regexp imagePath:(NSString *)imagePath;

/**
 All number matched your regexp will formatted with your style.
 Symbol '#' assumes all digits.
 Example: pattern is "+# (###) ###-##-##", regexp is "^375\\d*$"
 */
-(void) addOutputPattern:(NSString *)pattern forRegExp:(NSString *)regexp;


-(void) setOutputPatternsFromArray:(NSArray *)patterns;

-(BOOL) isRequireSubstitute:(unichar)ch;
@end
