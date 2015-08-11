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
#import "SHSFormattedTextField.h"

/**
 Simple UITextField subclass to handle phone numbers formats
 ARC enabled.
*/
@interface SHSPhoneTextField : SHSFormattedTextField

/**
 Return phone number without format. Ex: 89201235678
*/
-(NSString *) phoneNumber;


@end

