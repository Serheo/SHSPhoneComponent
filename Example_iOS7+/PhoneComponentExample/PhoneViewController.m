//
//  PhoneViewController.m
//  PhoneComponentExample
//
//  Created by Willy on 18.04.13.
//  Copyright (c) 2013 SHS. All rights reserved.
//

#import "PhoneViewController.h"

@implementation PhoneViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.phoneField becomeFirstResponder];
    
//    [self defaultExample];
//    [self prefixExample];
//    [self doubleFormatExample];
    [self doubleFormatExamplePrefixed];
    
    self.phoneField.textDidChangeBlock = ^(UITextField *textField) {
//        NSLog(@"number is %@", textField.text);
    };
    
    [self.phoneField addTarget:self action:@selector(didChange:) forControlEvents:UIControlEventValueChanged];
}

-(void) didChange:(UITextField *)sender {
    NSLog(@"%@", sender.text);
}

#pragma mark Examples

-(void) defaultExample
{
    [self.phoneField.formatter setDefaultOutputPattern:@"+# (###) ###-##-##"];
}

-(void) prefixExample
{
    [self.phoneField.formatter setDefaultOutputPattern:@"(###) ###-##-##"];
    self.phoneField.formatter.prefix = @"+7 ";
    [self.phoneField.formatter addOutputPattern:@"(###) ###-##-##" forRegExp:@"^[0-689]\\d*$" imagePath:@"SHSPhoneImage.bundle/flag_ru"];
}

-(void) doubleFormatExample
{
    [self.phoneField.formatter setDefaultOutputPattern:@"##########" imagePath:nil];
    self.phoneField.formatter.prefix = nil;
    [self.phoneField.formatter addOutputPattern:@"+# (###) ###-##-##" forRegExp:@"^7[0-689]\\d*$" imagePath:@"SHSPhoneImage.bundle/flag_ru"];
    [self.phoneField.formatter addOutputPattern:@"+### ###-##-##" forRegExp:@"^380\\d*$" imagePath:@"SHSPhoneImage.bundle/flag_ua"];
}

-(void) doubleFormatExamplePrefixed
{
    [self.phoneField.formatter setDefaultOutputPattern:@"### ### ###"];
    self.phoneField.formatter.prefix = @"+7 ";
    [self.phoneField.formatter addOutputPattern:@"(###) ###-##-##" forRegExp:@"^1\\d*$" imagePath:@"SHSPhoneImage.bundle/flag_ru"];
    [self.phoneField.formatter addOutputPattern:@"(###) ###-###" forRegExp:@"^2\\d*$" imagePath:@"SHSPhoneImage.bundle/flag_ua"];
}

#pragma mark -

@end
