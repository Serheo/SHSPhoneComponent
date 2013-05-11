//
//  SHSPhoneTextField.h
//  PhoneComponentExample
//
//  Created by Willy on 18.04.13.
//  Copyright (c) 2013 SHS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHSPhoneLogic.h"
#import "SHSPhoneNumberFormatter.h"

/**
 Simple UITextField subclass to handle phone numbers formats
 ARC enabled.
*/
@interface SHSPhoneTextField : UITextField
{
    SHSPhoneLogic *logicDelegate;
}

/**
 SHSPhoneNumberFormatter instance.
 Use is to configure format properties.
*/
@property (readonly, strong) SHSPhoneNumberFormatter *formatter;

/**
 If you want to use leftView or leftViewMode property set this property to NO.
 Default is YES.
*/
@property (readwrite) BOOL canAffectLeftViewByFormatter;

/**
 Formate a text and set it to a textfield.
*/
-(void) setFormattedText:(NSString *)text;

/**
 Block will be called when text changed
*/
typedef void (^SHSTextBlock)(UITextField *textField);
@property (nonatomic, copy) SHSTextBlock textDidChangeBlock;

@end

/**
 Flags String Constants. Each method is NSString path to image.
*/
@interface SHSFlags : NSObject
+ (NSString *) FlagRU;
+ (NSString *) FlagUS;
+ (NSString *) FlagDE;
+ (NSString *) FlagUA;
@end

