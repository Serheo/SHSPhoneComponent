//
//  PhoneComponentTest.m
//  PhoneComponentTest
//
//  Created by Willy on 04.05.13.
//  Copyright (c) 2013 SHS. All rights reserved.
//

#import "PhoneComponentTest.h"


@implementation PhoneComponentTest

- (void)setUp
{
    [super setUp];
    formatter = [[SHSPhoneNumberFormatter alloc]init];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testShouldFormatByDefault
{
    NSString *inputNumber = @"12345678901";
    [formatter setDefaultOutputPattern:@"+# (###) ###-##-##" imagePath:nil];
    
    NSDictionary *result = [formatter valuesForString:inputNumber];
    STAssertTrue([result[@"text"] isEqualToString:@"+1 (234) 567-89-01"], @"should format number by default");
    STAssertTrue(result[@"image"] == [NSNull null], @"default image is nil");

    [formatter setDefaultOutputPattern:@"+# (###) ###-####" imagePath:nil];
    
    result = [formatter valuesForString:inputNumber];
    STAssertTrue([result[@"text"] isEqualToString:@"+1 (234) 567-8901"], @"should format number by new default");
    STAssertTrue(result[@"image"] == [NSNull null], @"default image is nil");
}

- (void)testShouldDetectSpecificFormats
{
    NSString *inputNumber = @"12345678901";
    NSString *specififcInputNumber = @"38012345678901";

    NSString *imagePath = @"SOME_IMAGE_PATH";
    [formatter setDefaultOutputPattern:@"+# (###) ###-##-##" imagePath:nil];
    
    [formatter addOutputPattern:@"+### (##) ###-##-##" forRegExp:@"^380\\d*$" imagePath:imagePath];
    
    NSDictionary *result = [formatter valuesForString:inputNumber];
    STAssertTrue([result[@"text"] isEqualToString:@"+1 (234) 567-89-01"], @"should format number by default");
    STAssertTrue(result[@"image"] == [NSNull null], @"default image is nil");
    
    result = [formatter valuesForString:specififcInputNumber];
    
    STAssertTrue([result[@"text"] isEqualToString:@"+380 (12) 345-67-89"], @"should format number by specific pattern");
    STAssertTrue([result[@"image"] isEqualToString:imagePath], @"image is specified");
}

- (void)testShouldHandleSpecialSymbols
{
    NSString *inputNumber = @"!#dsti*&";
    
    [formatter setDefaultOutputPattern:@"+# (###) ###-##-##" imagePath:nil];
    
    NSDictionary *result = [formatter valuesForString:inputNumber];
    STAssertTrue([result[@"text"] isEqualToString:@""], @"should remove non-number symbols");
    STAssertTrue(result[@"image"] == [NSNull null], @"image should be nil");
    
    inputNumber = @"+12345678901";
    
    [formatter setDefaultOutputPattern:@"+# (###) ###-##-##" imagePath:nil];
    
    result = [formatter valuesForString:inputNumber];
    STAssertTrue([result[@"text"] isEqualToString:@"+1 (234) 567-89-01"], @"should format number by default and handle + symbol");
    STAssertTrue(result[@"image"] == [NSNull null], @"image should be nil");
    
}

- (void)testShouldHandleFormatWithDigits
{
    NSString *inputNumber = @"9201234567";
    
    [formatter setDefaultOutputPattern:@"+7 (###) ###-##-##"];
    
    NSDictionary *result = [formatter valuesForString:inputNumber];
    STAssertTrue([result[@"text"] isEqualToString:@"+7 (920) 123-45-67"], @"should format correctly");
    STAssertTrue(result[@"image"] == [NSNull null], @"image should be nil");
    
    inputNumber = @"7777778877";
    
    result = [formatter valuesForString:inputNumber];
    STAssertTrue([result[@"text"] isEqualToString:@"+7 (777) 777-88-77"], @"should format correctly");
    STAssertTrue(result[@"image"] == [NSNull null], @"image should be nil");
    
    
    inputNumber = @"3211231";
    [formatter setDefaultOutputPattern:@"### 123 ##-##"];
    
    result = [formatter valuesForString:inputNumber];
    STAssertTrue([result[@"text"] isEqualToString:@"321 123 12-31"], @"should format correctly");
    STAssertTrue(result[@"image"] == [NSNull null], @"image should be nil");

    inputNumber = @"1113333";
    
    result = [formatter valuesForString:inputNumber];
    STAssertTrue([result[@"text"] isEqualToString:@"111 123 33-33"], @"should format correctly");
    STAssertTrue(result[@"image"] == [NSNull null], @"image should be nil");
    
    
}

@end
