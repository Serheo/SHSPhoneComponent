//
//  SHSPhoneLogicDelegate.m
//  PhoneComponentExample
//
//  Created by Willy on 18.04.13.
//  Copyright (c) 2013 SHS. All rights reserved.
//

#import "SHSPhoneLogicDelegate.h"

@implementation SHSPhoneLogicDelegate

-(id) initWithTextField:(UITextField *)textField formatter:(SHSPhoneNumberFormatter *)formatter
{
    self = [super init];
    if (self) {
        [self loadRequirements:textField formatter:formatter];
    }
    return self;
}

-(void) loadRequirements:(UITextField *)textField formatter:(SHSPhoneNumberFormatter *)formatter
{
    caretPosition = 0;
    
    langImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    langImage.contentMode = UIViewContentModeScaleAspectFit;
    textField.leftView = langImage;
    
    self.formatter = formatter;
}

#pragma mark UITextField Delegate

-(void) blockCallbacks:(UITextField *)textField
{
    if (self.textDidChangeBlock) self.textDidChangeBlock(textField);
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    textField.leftViewMode = UITextFieldViewModeNever;
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newString;
    BOOL isDeleting = (string.length == 0);
    [self pushCaretPosition:textField range:range];
    if (isDeleting)
        newString = [SHSPhoneNumberFormatter formattedRemove:textField.text AtIndex:range];
    else
        newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    NSDictionary *result = [self.formatter valuesForString:newString];
    textField.text = result[@"text"];
    NSString *imageName = result[@"image"];
    
    if (imageName != (id)[NSNull null])
    {
        langImage.image = [UIImage imageNamed:imageName];
        textField.leftViewMode =  UITextFieldViewModeAlways;
    }
    else
        textField.leftViewMode =  UITextFieldViewModeNever;
    
    [self popCaretPosition:textField range:range];
    [self blockCallbacks:textField];
    return NO;
}

#pragma mark Caret Control

-(void) pushCaretPosition:(UITextField *)textField range:(NSRange)range
{
    NSString *subString = [textField.text substringFromIndex:range.location + range.length];
    caretPosition = [SHSPhoneNumberFormatter valuableCharCountIn:subString];
}

-(void) popCaretPosition:(UITextField *)textField range:(NSRange)range
{
    if (range.length == 0) range.length = 1;
    
    NSString *text = textField.text;
    int lasts = caretPosition;
    int start = [text length];
    for (int index = [text length] - 1; index >= 0 && lasts > 0; index--) {
        unichar ch = [text characterAtIndex:index];
        if ([SHSPhoneNumberFormatter isValuableChar:ch]) lasts--;
        if (lasts <= 0 )
        {
            start = index;
            break;
        }
    }

    [self selectTextForInput:textField atRange:NSMakeRange(start, 0)];
    caretPosition = 0;
}

- (void)selectTextForInput:(UITextField *)input atRange:(NSRange)range {
    UITextPosition *start = [input positionFromPosition:[input beginningOfDocument]
                                                 offset:range.location ];
    UITextPosition *end = [input positionFromPosition:start
                                               offset:range.length];
    [input setSelectedTextRange:[input textRangeFromPosition:start toPosition:end]];
}

#pragma mark -

@end