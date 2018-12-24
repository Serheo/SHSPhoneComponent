//
//  PhoneComponentTests.m
//  PhoneComponentTests
//
//  Created by Willy on 12.01.14.
//  Copyright (c) 2014 SHS. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SHSPhoneNumberFormatter.h"
#import "SHSPhoneNumberFormatter+UserConfig.h"

@interface PhoneComponentTests : XCTestCase
{
    SHSPhoneNumberFormatter *formatter;
}
@end

@implementation PhoneComponentTests

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
    XCTAssertTrue([result[@"text"] isEqualToString:@"+1 (234) 567-89-01"], @"should format number by default");
    XCTAssertTrue(result[@"image"] == [NSNull null], @"default image is nil");
    
    [formatter setDefaultOutputPattern:@"+# (###) ###-####" imagePath:nil];
    
    result = [formatter valuesForString:inputNumber];
    XCTAssertTrue([result[@"text"] isEqualToString:@"+1 (234) 567-8901"], @"should format number by new default");
    XCTAssertTrue(result[@"image"] == [NSNull null], @"default image is nil");
}

- (void)testShouldDetectSpecificFormats
{
    NSString *inputNumber = @"12345678901";
    NSString *specififcInputNumber = @"38012345678901";
    
    NSString *imagePath = @"SOME_IMAGE_PATH";
    [formatter setDefaultOutputPattern:@"+# (###) ###-##-##" imagePath:nil];
    
    [formatter addOutputPattern:@"+### (##) ###-##-##" forRegExp:@"^380\\d*$" imagePath:imagePath];
    
    NSDictionary *result = [formatter valuesForString:inputNumber];
    XCTAssertTrue([result[@"text"] isEqualToString:@"+1 (234) 567-89-01"], @"should format number by default");
    XCTAssertTrue(result[@"image"] == [NSNull null], @"default image is nil");
    
    result = [formatter valuesForString:specififcInputNumber];
    
    XCTAssertTrue([result[@"text"] isEqualToString:@"+380 (12) 345-67-89"], @"should format number by specific pattern");
    XCTAssertTrue([result[@"image"] isEqualToString:imagePath], @"image is specified");
}

- (void)testShouldHandleSpecialSymbols
{
    NSString *inputNumber = @"!#dsti*&";
    
    [formatter setDefaultOutputPattern:@"+# (###) ###-##-##" imagePath:nil];
    
    NSDictionary *result = [formatter valuesForString:inputNumber];
    XCTAssertTrue([result[@"text"] isEqualToString:@""], @"should remove non-number symbols");
    XCTAssertTrue(result[@"image"] == [NSNull null], @"image should be nil");
    
    inputNumber = @"+12345678901";
    
    [formatter setDefaultOutputPattern:@"+# (###) ###-##-##" imagePath:nil];
    
    result = [formatter valuesForString:inputNumber];
    XCTAssertTrue([result[@"text"] isEqualToString:@"+1 (234) 567-89-01"], @"should format number by default and handle + symbol");
    XCTAssertTrue(result[@"image"] == [NSNull null], @"image should be nil");
    
}

- (void)testShouldHandleFormatWithDigits
{
    NSString *inputNumber = @"9201234567";
    
    [formatter setDefaultOutputPattern:@"+7 (###) ###-##-##"];
    
    NSDictionary *result = [formatter valuesForString:inputNumber];
    XCTAssertTrue([result[@"text"] isEqualToString:@"+7 (920) 123-45-67"], @"should format correctly");
    XCTAssertTrue(result[@"image"] == [NSNull null], @"image should be nil");
    
    inputNumber = @"7777778877";
    
    result = [formatter valuesForString:inputNumber];
    XCTAssertTrue([result[@"text"] isEqualToString:@"+7 (777) 777-88-77"], @"should format correctly");
    XCTAssertTrue(result[@"image"] == [NSNull null], @"image should be nil");
    
    
    inputNumber = @"3211231";
    [formatter setDefaultOutputPattern:@"### 123 ##-##"];
    
    result = [formatter valuesForString:inputNumber];
    XCTAssertTrue([result[@"text"] isEqualToString:@"321 123 12-31"], @"should format correctly");
    XCTAssertTrue(result[@"image"] == [NSNull null], @"image should be nil");
    
    inputNumber = @"1113333";
    
    result = [formatter valuesForString:inputNumber];
    XCTAssertTrue([result[@"text"] isEqualToString:@"111 123 33-33"], @"should format correctly");
    XCTAssertTrue(result[@"image"] == [NSNull null], @"image should be nil");
}

- (void)testShouldCheckPrefix
{
    NSString *inputNumber = @"9201234567";
    formatter.prefix = @"pr3f1x";
    [formatter setDefaultOutputPattern:@"(###) ###-##-##"];
    
    NSDictionary *result = [formatter valuesForString:inputNumber];
    NSString *should = [NSString stringWithFormat:@"%@%@", formatter.prefix, @"(920) 123-45-67"];
    XCTAssertTrue([result[@"text"] isEqualToString:should], @"should format correctly");
    XCTAssertTrue(result[@"image"] == [NSNull null], @"image should be nil");

    result = [formatter valuesForString:should];
    XCTAssertTrue([result[@"text"] isEqualToString:should], @"should format correctly");
    XCTAssertTrue(result[@"image"] == [NSNull null], @"image should be nil");
}

- (void)testShouldCheckPrefixAndDifferentFormats
{
    NSString *inputNumber = @"3801234567";
    NSString *inputNumberNonImage = @"1231234567";
    NSString *imagePath = @"SOME_IMAGE_PATH";
    formatter.prefix = @"pr3-f1x";
    
    [formatter setDefaultOutputPattern:@"##########"];
    [formatter addOutputPattern:@"+### (##) ###-##-##" forRegExp:@"^380\\d*$" imagePath:imagePath];
    [formatter addOutputPattern:@"+### (##) ###-##-##" forRegExp:@"^123\\d*$" imagePath:nil];
    
    NSDictionary *result = [formatter valuesForString:inputNumber];
    NSString *should = [NSString stringWithFormat:@"%@%@", formatter.prefix, @"+380 (12) 345-67"];
    XCTAssertTrue([result[@"text"] isEqualToString:should], @"should format correctly");
    XCTAssertTrue([result[@"image"]isEqualToString:imagePath], @"image should not be nil");

    result = [formatter valuesForString:inputNumberNonImage];
    should = [NSString stringWithFormat:@"%@%@", formatter.prefix, @"+123 (12) 345-67"];
    XCTAssertTrue([result[@"text"] isEqualToString:should], @"should format correctly");
    XCTAssertTrue(result[@"image"] == [NSNull null], @"image should be nil");
}

- (void)testShouldRemoveSpaces
{
    NSString *inputNumber = @"380 1234 5467";
    NSString *result = [SHSPhoneNumberFormatter formattedRemove:inputNumber AtIndex:NSMakeRange(3, 1)];
    NSLog(@"%@", result);
    
    XCTAssert([result isEqualToString:@"38 1234 5467"], @"should remove correctly");
}

- (void)testShouldHandlePrefixAndNumberFormatStyle
{
    [formatter setDefaultOutputPattern:@"+78 (###) ###-##-##"];
    NSDictionary *result;
    
    result = [formatter valuesForString:@"+7 (123"];
    XCTAssertTrue([result[@"text"] isEqualToString:@"+78 (123"], @"should format correctly");
    XCTAssertTrue(result[@"image"] == [NSNull null], @"image should be nil");
    
    result = [formatter valuesForString:@"+87 (1234"];
    XCTAssertTrue([result[@"text"] isEqualToString:@"+78 (871) 234"], @"should format correctly");
    XCTAssertTrue(result[@"image"] == [NSNull null], @"image should be nil");
    
    [formatter setDefaultOutputPattern:@"+7 (###) 88#-##-##"];
    
    result = [formatter valuesForString:@"+7 (123"];
    XCTAssertTrue([result[@"text"] isEqualToString:@"+7 (123"], @"should format correctly");
    XCTAssertTrue(result[@"image"] == [NSNull null], @"image should be nil");
    
    result = [formatter valuesForString:@"1234"];
    XCTAssertTrue([result[@"text"] isEqualToString:@"+7 (123) 884"], @"should format correctly");
    XCTAssertTrue(result[@"image"] == [NSNull null], @"image should be nil");
    
    result = [formatter valuesForString:@"+7 (123) 884"];
    XCTAssertTrue([result[@"text"] isEqualToString:@"+7 (123) 888-84"], @"should format correctly");
    XCTAssertTrue(result[@"image"] == [NSNull null], @"image should be nil");
    
    result = [formatter valuesForString:@"+7 (123) 8887"];
    XCTAssertTrue([result[@"text"] isEqualToString:@"+7 (123) 888-88-7"], @"should format correctly");
    XCTAssertTrue(result[@"image"] == [NSNull null], @"image should be nil");
    
    formatter.prefix = @"pr3-f1x ";
    result = [formatter valuesForString:@"+7 (123"];
    XCTAssertTrue([result[@"text"] isEqualToString:@"pr3-f1x +7 (123"], @"should format correctly");
    XCTAssertTrue(result[@"image"] == [NSNull null], @"image should be nil");
    
    result = [formatter valuesForString:@"+7 (123) 8887"];
    XCTAssertTrue([result[@"text"] isEqualToString:@"pr3-f1x +7 (123) 888-88-7"], @"should format correctly");
    XCTAssertTrue(result[@"image"] == [NSNull null], @"image should be nil");
}

@end
