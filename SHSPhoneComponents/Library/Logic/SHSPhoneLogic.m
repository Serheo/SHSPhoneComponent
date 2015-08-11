//
//  SHSPhoneLogicDelegate.m
//  PhoneComponentExample
//
//  Created by Willy on 18.04.13.
//  Copyright (c) 2013 SHS. All rights reserved.
//

#import "SHSPhoneLogic.h"
#import "SHSPhoneTextField.h"
#import "SHSFlagAccessoryView.h"
#import "SHSFormattedTextField.h"
#import "SHSFormatter.h"

@implementation SHSPhoneLogic
@synthesize delegate = _delegate;

#pragma mark -
#pragma mark Logic Method



-(BOOL)logicTextField:(SHSFormattedTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    NSString *prefix = textField.formatter.prefix;
    if (prefix.length > 0 && range.location < prefix.length) {
        return NO;
    }
    
    NSInteger caretPosition = [self pushCaretPosition:textField range:range formatter:textField.formatter];
    
    SHSFormatter* formatter = textField.formatter;
    
    NSString *newString = [self calculateNewString:textField inRange:range replacementString:string];
//    NSString *newString = textField
    [formatter applyText:newString];
    
    [self popCaretPosition:textField range:range caretPosition:caretPosition formatter:textField.formatter];
    
    [textField sendActionsForControlEvents:UIControlEventValueChanged];
    if (textField.textDidChangeBlock) textField.textDidChangeBlock(textField);
    return NO;
}

-(NSString *) calculateNewString:(SHSFormattedTextField *)textField inRange:(NSRange)range replacementString:(NSString *)string; {
    
    SHSFormatter* formatter = textField.formatter;
    NSString *original = textField.text;
    
    NSString *nonPrefix = original;
    if ([original hasPrefix:formatter.prefix]) nonPrefix = [original substringFromIndex:formatter.prefix.length];
    
    NSString *unFormattedDigits = [formatter stringWithoutFormat:nonPrefix];
    
    NSInteger newLocation = range.location;
    NSInteger newLength = range.length;
    newLocation -= formatter.prefix.length;
    
    NSInteger skipCount = 0;
    for (NSInteger i = 0; i < MIN(range.location - formatter.prefix.length, nonPrefix.length); i++) {
        NSUInteger indexCh1 = i;
        NSUInteger indexCh2 = i-skipCount;
        unichar ch1 = [nonPrefix characterAtIndex:indexCh1];
        unichar ch2 = [unFormattedDigits characterAtIndex:indexCh2];
        if (ch1 != ch2) {
            skipCount++;
        }
    }
    
    newLocation -= skipCount;
    
    if (range.length > 1) {
        skipCount = 0;
        for (NSInteger i = MAX(range.location, formatter.prefix.length); i < MIN(range.location + range.length, original.length); i++) {
            unichar ch1 = [original characterAtIndex:i];
         //   unichar ch2 = [unFormattedDigits characterAtIndex:j];
            if ([formatter isValuableChar:ch1] == NO) {
                skipCount++;
            }
        }
        
        newLength = newLength - skipCount;
    }
    if (newLocation < 0) {
        newLocation = 0;
    }
    
    newLength = MIN(newLength, unFormattedDigits.length + string.length);
    
    NSRange newRange = NSMakeRange(newLocation, newLength);

//    NSLog(@"new range %@", NSStringFromRange(newRange));
    NSString *newString = string;
    
    @try {
        newString = [unFormattedDigits stringByReplacingCharactersInRange:newRange withString:string];
    }
    @catch (NSException *exception) {
        NSLog(@"range counting failed");
    }

    return newString;
}

#pragma mark -
#pragma mark Caret Control

-(NSInteger) pushCaretPosition:(UITextField *)textField range:(NSRange)range formatter:(SHSFormatter *) formatter
{
    NSString *subString = [textField.text substringFromIndex:range.location + range.length];
    return [formatter valuableCharCountIn:subString];
}

-(void) popCaretPosition:(UITextField *)textField range:(NSRange)range caretPosition:(NSInteger)caretPosition  formatter:(SHSFormatter *) formatter
{
    if (range.length == 0) range.length = 1;
    
    NSString *text = textField.text;
    NSInteger lasts = caretPosition;
    NSInteger start = [text length];
    for (NSInteger index = [text length] - 1; index >= 0 && lasts > 0; index--) {
        unichar ch = [text characterAtIndex:index];
        if ([formatter isValuableChar:ch]) lasts--;
        if (lasts <= 0)
        {
            start = index;
            break;
        }
    }

    [self selectTextForInput:textField atRange:NSMakeRange(start, 0)];
}

-(void)selectTextForInput:(UITextField *)input atRange:(NSRange)range {
    UITextPosition *start = [input positionFromPosition:[input beginningOfDocument] offset:range.location ];
    UITextPosition *end = [input positionFromPosition:start offset:range.length];
    [input setSelectedTextRange:[input textRangeFromPosition:start toPosition:end]];
}

#pragma mark -
#pragma mark UITextField Delegate

-(BOOL)textField:(SHSFormattedTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    [self logicTextField:textField shouldChangeCharactersInRange:range replacementString:string];
    
    if ([_delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)])
        [_delegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    
    return NO;
}

- (BOOL)textFieldShouldClear:(SHSFormattedTextField *)textField
{
    if ( textField.formatter.canAffectLeftViewByFormatter) textField.leftViewMode = UITextFieldViewModeNever;
    
    if ([_delegate respondsToSelector:@selector(textFieldShouldClear:)])
        return [_delegate textFieldShouldClear:textField];

    if (textField.formatter.prefix.length > 0)
    {
        [textField setFormattedText:@""];
        return NO;
    }
    else
    {
        return YES;
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([_delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)])
        return [_delegate textFieldShouldBeginEditing:textField];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([_delegate respondsToSelector:@selector(textFieldDidBeginEditing:)])
        [_delegate textFieldDidBeginEditing:textField];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if ([_delegate respondsToSelector:@selector(textFieldShouldEndEditing:)])
        return [_delegate textFieldShouldEndEditing:textField];
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([_delegate respondsToSelector:@selector(textFieldDidEndEditing:)])
        [_delegate textFieldDidEndEditing:textField];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([_delegate respondsToSelector:@selector(textFieldShouldReturn:)])
        return [_delegate textFieldShouldReturn:textField];
    
    return YES;
}

@end
