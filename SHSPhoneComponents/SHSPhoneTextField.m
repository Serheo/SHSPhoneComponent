//
//  SHSPhoneTextField.m
//  PhoneComponentExample
//
//  Created by Willy on 18.04.13.
//  Copyright (c) 2013 SHS. All rights reserved.
//

#import "SHSPhoneTextField.h"
#import "SHSPhoneNumberFormatter+UserConfig.h"

@implementation SHSPhoneTextField

-(void) logicInitialization
{
    formatter = [[SHSPhoneNumberFormatter alloc]init];
    
    logicDelegate = [[SHSPhoneLogicDelegate alloc] initWithTextField:self formatter:formatter];
    [super setDelegate:logicDelegate];
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

#pragma mark Delegate Suclass Helper

-(void) setLogicDelegate:(SHSPhoneLogicDelegate *)delegate
{
    [delegate loadRequirements:self formatter:formatter];
    [super setDelegate:logicDelegate];
}

#pragma mark -
#pragma mark Format Style Methods

-(void) resetFormats
{
    [formatter resetFormats];
}

-(void) setDefaultOutputPattern:(NSString *)pattern imagePath:(NSString *)imagePath
{
    [formatter setDefaultOutputPattern:pattern imagePath:imagePath];
}

-(void) addOutputPattern:(NSString *)pattern forRegExp:(NSString *)regexp imagePath:(NSString *)imagePath
{
    [formatter addOutputPattern:pattern forRegExp:regexp imagePath:imagePath];
}

#pragma mark -

-(void) setTextDidChangeBlock:(SHSTextBlock)block
{
    logicDelegate.textDidChangeBlock = block;
}

@end
