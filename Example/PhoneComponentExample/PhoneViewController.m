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
    [self.phoneField.formatter setDefaultOutputPattern:@"+# (###) ###-##-##" imagePath:nil];
    
    [self.phoneField.formatter addOutputPattern:@"+# (###) ###-##-##" forRegExp:@"^7[0-689]\\d*$" imagePath:[SHSFlags FlagRU]];
    [self.phoneField.formatter addOutputPattern:@"# (###) ###-##-##" forRegExp:@"^8[0-689]\\d*$" imagePath:[SHSFlags FlagRU]];
    
    [self.phoneField.formatter addOutputPattern:@"+### (##) ###-###" forRegExp:@"^380\\d*$" imagePath:[SHSFlags FlagUA]];
    
    self.phoneField.textDidChangeBlock = ^(UITextField *textField) {
        NSLog(@"number is %@", textField.text);
    };
    
}


@end
