//
//  SHSPhoneLogicDelegate.m
//  PhoneComponentExample
//
//  Created by Willy on 18.04.13.
//  Copyright (c) 2013 SHS. All rights reserved.
//

#import "SHSPhoneLogic.h"
#import "SHSPhoneTextField.h"

@implementation SHSPhoneLogic

#pragma mark UITextField Delegate

- (BOOL)textFieldShouldClear:(SHSPhoneTextField *)textField
{
    if ( textField.canAffectLeftViewByFormatter) textField.leftViewMode = UITextFieldViewModeNever;
    return YES;
}

-(BOOL)textField:(SHSPhoneTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return [SHSPhoneLogic logicTextField:textField shouldChangeCharactersInRange:range replacementString:string];
}

#pragma mark -
#pragma mark Logic Method

+(void) setImageLeftView:(UITextField *)textField image:(UIImage *)image
{
    if (![textField.leftView isKindOfClass:[UIImageView class]])
    {
        UIImageView *langImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 18, 18)];
        langImage.contentMode = UIViewContentModeScaleAspectFit;
        textField.leftView = langImage;
    }
    textField.leftViewMode =  UITextFieldViewModeAlways;
    ((UIImageView *)textField.leftView).image = image;
}

+(void) updateLeftImageView:(UITextField *)textField imagePath:(NSString *)imagePath
{
    if (imagePath == (id)[NSNull null]) {
        textField.leftViewMode = UITextFieldViewModeNever;
    }
    else
        [self setImageLeftView:textField image:[UIImage imageNamed:imagePath]];
}

+(BOOL)logicTextField:(SHSPhoneTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newString;
    BOOL isDeleting = (string.length == 0);
    int caretPosition = [self pushCaretPosition:textField range:range];
    
    if (isDeleting)
        newString = [SHSPhoneNumberFormatter formattedRemove:textField.text AtIndex:range];
    else
        newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    NSDictionary *result = [textField.formatter valuesForString:newString];
    textField.text = result[@"text"];

    if ( textField.canAffectLeftViewByFormatter )
        [self updateLeftImageView:textField imagePath:result[@"image"]];
    
    [self popCaretPosition:textField range:range caretPosition:caretPosition];
    
    if (textField.textDidChangeBlock) textField.textDidChangeBlock(textField);
    return NO;
}

#pragma mark -
#pragma mark Caret Control

+(int) pushCaretPosition:(UITextField *)textField range:(NSRange)range
{
    NSString *subString = [textField.text substringFromIndex:range.location + range.length];
    return [SHSPhoneNumberFormatter valuableCharCountIn:subString];
}

+(void) popCaretPosition:(UITextField *)textField range:(NSRange)range caretPosition:(int)caretPosition
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
}

+ (void)selectTextForInput:(UITextField *)input atRange:(NSRange)range {
    UITextPosition *start = [input positionFromPosition:[input beginningOfDocument]
                                                 offset:range.location ];
    UITextPosition *end = [input positionFromPosition:start
                                               offset:range.length];
    [input setSelectedTextRange:[input textRangeFromPosition:start toPosition:end]];
}

#pragma mark -

@end