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
    [self.phoneField setPredefinedFormats];
}

@end
