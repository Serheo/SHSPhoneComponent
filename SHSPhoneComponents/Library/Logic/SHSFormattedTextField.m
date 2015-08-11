//
//  SHSFormatterTextField.m
//  PhoneComponentExample
//
//  Created by Will on 15/07/15.
//  Copyright (c) 2015 SHS. All rights reserved.
//

#import "SHSFormattedTextField.h"
#import "SHSFormatter.h"
#import "SHSPhoneLogic.h"
#import "SHSPhoneNumberFormatter.h"
#import "SHSTextFormatter.h"

@implementation SHSFormattedTextField

-(void) logicInitialization
{
    _formatter = [[SHSPhoneNumberFormatter alloc] init];
    _formatter.textField = self;
    
    logicDelegate = [[SHSPhoneLogic alloc] init];
    self.keyboardType = UIKeyboardTypeNumberPad;
    [super setDelegate:logicDelegate];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self logicInitialization];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self logicInitialization];
    }
    return self;
}

#pragma mark -
#pragma mark Formatter Type

-(void) setFormatterType:(SHSFormatterType)formatterType {
    self.text = @"";
    self.leftView = nil;
    
    _formatterType = formatterType;
    
    BOOL isActive = [self isFirstResponder];

    if (isActive) [self resignFirstResponder];
    if (_formatterType == SHSFormatterTypePhone) {
        _formatter = [[SHSPhoneNumberFormatter alloc] init];
        self.keyboardType = UIKeyboardTypeNumberPad;
    } else {
        _formatter = [[SHSTextFormatter alloc] init];
        self.keyboardType = UIKeyboardTypeDefault;
    }
    if (isActive) [self becomeFirstResponder];
    _formatter.textField = self;
}

-(void) setFormatter:(SHSFormatter *)formatter{
    self.text = @"";
    self.leftView = nil;
    _formatter = formatter;
    _formatter.textField = self;
}

#pragma mark -
#pragma mark Delegates

-(void) setDelegate:(id<UITextFieldDelegate>)delegate
{
    logicDelegate.delegate = delegate;
}

-(id<UITextFieldDelegate>) delegate
{
    return logicDelegate.delegate;
}

#pragma mark -
#pragma mark Additional Text Setter

-(void) setFormattedText:(NSString *)text
{
    [self.formatter applyText:text];
}

-(NSString *)textValueWithoutPrefix
{
    NSString *prefixValue = self.formatter.prefix ? self.formatter.prefix : @"";
    return [self.text substringFromIndex:prefixValue.length];
}


@end
