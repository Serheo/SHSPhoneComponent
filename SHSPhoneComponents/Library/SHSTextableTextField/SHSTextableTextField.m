//
//  SHSTextableTextField.m
//  PhoneComponentExample
//
//  Created by Will on 15/07/15.
//  Copyright (c) 2015 SHS. All rights reserved.
//

#import "SHSTextableTextField.h"

@implementation SHSTextableTextField

-(void) logicInitialization
{
    [super logicInitialization];
    self.formatter = [[SHSTextFormatter alloc] init];
    self.formatter.textField = self;
    self.keyboardType = UIKeyboardTypeDefault;
}

#pragma mark -
#pragma mark Additional Text Setter

-(NSString *)textValueWithoutPrefix
{
    return self.text;
}

@end
