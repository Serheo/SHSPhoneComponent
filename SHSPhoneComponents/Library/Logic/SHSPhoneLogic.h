//
//  SHSPhoneLogicDelegate.h
//  PhoneComponentExample
//
//  Created by Willy on 18.04.13.
//  Copyright (c) 2013 SHS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SHSPhoneNumberFormatter.h"
#import "SHSFormattedTextField.h"

@class SHSFormattedTextField;
@class SHSPhoneTextField;

/**
 Incapsulate number formatting and caret positioning logics. Also used as inner delegate.
*/
@interface SHSPhoneLogic : NSObject <UITextFieldDelegate>

/**
  Incapsulate number formatting and caret positioning logics.
*/
-(BOOL)logicTextField:(SHSFormattedTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

@property(nonatomic, weak) id<UITextFieldDelegate> delegate;
@end
