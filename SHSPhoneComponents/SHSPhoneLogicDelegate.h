//
//  SHSPhoneLogicDelegate.h
//  PhoneComponentExample
//
//  Created by Willy on 18.04.13.
//  Copyright (c) 2013 SHS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHSPhoneNumberFormatter.h"

/**
 UITextField Delegate. Incapsulate formatting logic.
 
 If you want to use delegate methods you need to subclass SHSPhoneLogicDelegate
 and call setLogicDelegate: method on SHSPhoneTextFeild.
 Be careful with textField:shouldChangeCharactersInRange:replacementString: - it should always return NO.
*/
@interface SHSPhoneLogicDelegate : NSObject <UITextFieldDelegate>
{
    UIImageView *langImage;
    int caretPosition;
}

@property (weak) SHSPhoneNumberFormatter *formatter;

-(id) initWithTextField:(UITextField *)textField formatter:(SHSPhoneNumberFormatter *)formatter;
-(void) loadRequirements:(UITextField *)textField formatter:(SHSPhoneNumberFormatter *)formatter;


typedef void (^SHSTextBlock)(UITextField *textField);

/**
 Block will be called when text changed
*/
@property (nonatomic, copy) SHSTextBlock textDidChangeBlock;

@end
