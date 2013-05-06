//
//  SHSPhoneTextField.h
//  PhoneComponentExample
//
//  Created by Willy on 18.04.13.
//  Copyright (c) 2013 SHS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHSPhoneLogicDelegate.h"
#import "SHSPhoneNumberFormatter.h"

/**
 Simple UITextField subclass to handle phone numbers formats
 ARC enabled.
*/
@interface SHSPhoneTextField : UITextField
{
    SHSPhoneNumberFormatter *formatter;
    SHSPhoneLogicDelegate *logicDelegate;
}

/**
 Remove all patterns and apply clear format style.
 Default format is @"#############", imagePath is nil.
*/
-(void) resetFormats;

/**
 Apply default format style and image
 Symbol '#' assumes all digits.
 Example is "+# (###) ###-##-##", imagePath is "flag_ru".
*/
-(void) setDefaultOutputPattern:(NSString *)pattern imagePath:(NSString *)imagePath;

/**
 All number matched your regexp will formatted with your style and image
 Symbol '#' assumes all digits.
 Example: pattern is "+# (###) ###-##-##", imagePath is "flag_ru", regexp is "^\\+375\\d*$"
*/
-(void) addOutputPattern:(NSString *)pattern forRegExp:(NSString *)regexp imagePath:(NSString *)imagePath;

/**
 If you want to use delegate methods you need to subclass SHSPhoneLogicDelegate
 and call setLogicDelegate: method. It initialize your delegate subclass with required parameters.
 Be careful with textField:shouldChangeCharactersInRange:replacementString: - it should always return NO.
*/
-(void) setLogicDelegate:(SHSPhoneLogicDelegate *)delegate;

/**
 Block will be called when text changed
*/
-(void) setTextDidChangeBlock:(SHSTextBlock)block;

@end