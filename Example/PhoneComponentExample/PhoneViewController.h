//
//  PhoneViewController.h
//  PhoneComponentExample
//
//  Created by Willy on 18.04.13.
//  Copyright (c) 2013 SHS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHSPhoneLibrary.h"

@interface PhoneViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet SHSPhoneTextField *phoneField;

@end
