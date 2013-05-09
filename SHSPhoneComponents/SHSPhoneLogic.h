//
//  SHSPhoneLogicDelegate.h
//  PhoneComponentExample
//
//  Created by Willy on 18.04.13.
//  Copyright (c) 2013 SHS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHSPhoneNumberFormatter.h"
@class SHSPhoneTextField;

/**
 Incapsulate number formatting and caret positioning logics.
 
 If you want to use delegate methods please
 design textField:shouldChangeCharactersInRange:replacementString: method in next way
 
 -(BOOL)textField:(SHSPhoneTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
 {
    [SHSPhoneLogic logicTextField:textField shouldChangeCharactersInRange:range replacementString:string];
    // ..your logic
    return NO;
 }
 
 Other delegate methods use as you want.
*/
@interface SHSPhoneLogic : NSObject <UITextFieldDelegate>

/**
  Incapsulate number formatting and caret positioning logics.
*/
+(BOOL)logicTextField:(SHSPhoneTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
@end
