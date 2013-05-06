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
    [self.phoneField setDefaultOutputPattern:@"+# (###) ###-##-##" imagePath:nil];
    
    [self.phoneField addOutputPattern:@"+# (###) ###-##-##" forRegExp:@"^7[0-689]\\d*$" imagePath:@"flag_RU"];
    [self.phoneField addOutputPattern:@"# (###) ###-##-##" forRegExp:@"^8[0-689]\\d*$" imagePath:@"flag_RU"];
    
    [self.phoneField addOutputPattern:@"+### (##) ###-###" forRegExp:@"^374\\d*$" imagePath:@"flag_AM"];
    
    [self.phoneField setTextDidChangeBlock:^(UITextField *textField) {
       // NSLog(@"%@", textField.text);
    }];
}

@end
