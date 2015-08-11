//
//  SHSPhoneTextField.m
//  PhoneComponentExample
//
//  Created by Willy on 18.04.13.
//  Copyright (c) 2013 SHS. All rights reserved.
//

#import "SHSPhoneTextField.h"
#import "SHSFormatter.h"

@implementation SHSPhoneTextField

-(void) logicInitialization
{
    [super logicInitialization];
    self.formatter = [[SHSPhoneNumberFormatter alloc] init];
    self.formatter.textField = self;
    self.keyboardType = UIKeyboardTypeNumberPad;

}

-(SHSPhoneNumberFormatter *)phoneFormatter {
    return (SHSPhoneNumberFormatter *)self.formatter;
}

#pragma mark -
#pragma mark Additional Text Setter

-(void) setFormattedText:(NSString *)text
{
    [self.formatter applyText:text];
}

-(NSString *) phoneNumber
{
    return [self.phoneFormatter digitOnlyString:self.text];
}

-(NSString *)textValueWithoutPrefix
{
    return [self.phoneFormatter digitOnlyString:[self.text stringByReplacingOccurrencesOfString:self.formatter.prefix withString:@""]];
}

@end


