//
//  SHSPhoneTextField.m
//  PhoneComponentExample
//
//  Created by Willy on 18.04.13.
//  Copyright (c) 2013 SHS. All rights reserved.
//

#import "SHSPhoneTextField.h"
#import "SHSPhoneNumberFormatter+UserConfig.h"

@implementation SHSFlags

+ (NSString *) FlagRU { return @"SHSPhoneImage.bundle/flag_ru"; }
+ (NSString *) FlagUS { return @"SHSPhoneImage.bundle/flag_us"; }
+ (NSString *) FlagDE { return @"SHSPhoneImage.bundle/flag_de"; }
+ (NSString *) FlagUA { return @"SHSPhoneImage.bundle/flag_ua"; }

@end

@implementation SHSPhoneTextField

-(void) logicInitialization
{
    _formatter = [[SHSPhoneNumberFormatter alloc]init];
    logicDelegate = [[SHSPhoneLogic alloc] init];
    _canAffectLeftViewByFormatter = YES;
    
    [super setDelegate:logicDelegate];
    self.keyboardType = UIKeyboardTypeNumberPad;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self logicInitialization];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self logicInitialization];
    }
    return self;
}

#pragma mark -

-(void) setDelegate:(id<UITextFieldDelegate>)delegate
{
    logicDelegate.delegate = delegate;
}

-(id<UITextFieldDelegate>) delegate
{
    return logicDelegate.delegate;
}

@end
