//
//  SHSFormatterTextField.h
//  PhoneComponentExample
//
//  Created by Will on 15/07/15.
//  Copyright (c) 2015 SHS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHSFormattedTextField.h"
#import "SHSFormatter.h"

enum {
    SHSFormatterTypePhone = 0,
    SHSFormatterTypeText,
};
typedef NSUInteger SHSFormatterType;

@class SHSPhoneLogic;
@interface SHSFormattedTextField : UITextField
{
    SHSPhoneLogic *logicDelegate;
}

-(void) logicInitialization;

/**
 SHSPhoneNumberFormatter instance.
 Use is to configure format properties.
 */
@property (strong, nonatomic) SHSFormatter* formatter;


@property (nonatomic) SHSFormatterType formatterType;


/**
 Formate a text and set it to a textfield.
 */
-(void) setFormattedText:(NSString *)text;


/**
 Return phone number without format and prefix
 */
-(NSString *) textValueWithoutPrefix;

/**
 Block will be called when text changed
 */
@property (nonatomic, copy) SHSTextBlock textDidChangeBlock;

@end
