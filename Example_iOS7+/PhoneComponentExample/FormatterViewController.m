//
//  FormatterViewController.m
//  PhoneComponentExample
//
//  Created by Will on 15/07/15.
//  Copyright (c) 2015 SHS. All rights reserved.
//

#import "FormatterViewController.h"
#import "SHSLibrary.h"


enum {
    FieldTypesPhone = 0,
    FieldTypesText,
};
typedef NSUInteger FieldTypes;

@interface FormatterViewController ()

@property (weak, nonatomic) IBOutlet SHSFormattedTextField *textField;
@end

@implementation FormatterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self phoneFormats];
    
    self.textField.textDidChangeBlock = ^(UITextField *textField) {
        //        NSLog(@"number is %@", textField.text);
    };
    
   // [self.textField addTarget:self action:@selector(didChange:) forControlEvents:UIControlEventValueChanged];
}

-(void) didChange:(UITextField *)sender {
    NSLog(@"'%@'", sender.text);
}

- (IBAction)valueChangedAction:(UITextField *)sender {
    NSLog(@"text %@", sender.text);
}

- (IBAction)segmentValueChanged:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == FieldTypesPhone) {
        self.textField.formatterType = SHSFormatterTypePhone;
        [self phoneFormats];
    } else if (sender.selectedSegmentIndex == FieldTypesText){
        self.textField.formatterType = SHSFormatterTypeText;
        [self textFormats];
    }
}


-(void) phoneFormats
{
    [self.textField.formatter setDefaultOutputPattern:@"(###)-###-###"];
    self.textField.formatter.prefix = @"+1237 ";
    
    self.textField.formatter.prefix = @"+7 ";
    [self.textField.formatter addOutputPattern:@"(###)-###-##-##" forRegExp:@"^1\\d*$" imagePath:@"SHSPhoneImage.bundle/flag_ru"];
    [self.textField.formatter addOutputPattern:@"(###)-###-###" forRegExp:@"^2\\d*$" imagePath:@"SHSPhoneImage.bundle/flag_ua"];
}


-(void) textFormats
{
    [self.textField.formatter setDefaultOutputPattern:@"#"];
    self.textField.formatter.prefix = @"+7 ";
    [self.textField.formatter addOutputPattern:@"(###) ###-##-##" forRegExp:@"^1\\d*$" imagePath:@"SHSPhoneImage.bundle/flag_ru"];
    [self.textField.formatter addOutputPattern:@"(###) ###-###" forRegExp:@"^2\\d*$" imagePath:@"SHSPhoneImage.bundle/flag_ua"];
}

#pragma mark Phone format variants

-(void) phoneDefaultExample
{
    [self.textField.formatter setDefaultOutputPattern:@"### ### ###"];
    self.textField.formatter.prefix = @"+7 ";
    [self.textField.formatter addOutputPattern:@"(###) ###-##-##" forRegExp:@"^1\\d*$" imagePath:@"SHSPhoneImage.bundle/flag_ru"];
    [self.textField.formatter addOutputPattern:@"(###) ###-###" forRegExp:@"^2\\d*$" imagePath:@"SHSPhoneImage.bundle/flag_ua"];
    
    //[self.textField.formatter setDefaultOutputPattern:@"+# (###) ###-##-##"];
}

-(void) phonePrefixExample
{
    [self.textField.formatter setDefaultOutputPattern:@"(###) ###-##-##"];
    self.textField.formatter.prefix = @"+7 ";
    [self.textField.formatter addOutputPattern:@"(###) ###-##-##" forRegExp:@"^[0-689]\\d*$" imagePath:@"SHSPhoneImage.bundle/flag_ru"];
}

-(void) phoneDoubleFormatExample
{
    [self.textField.formatter setDefaultOutputPattern:@"##########" imagePath:nil];
    self.textField.formatter.prefix = nil;
    [self.textField.formatter addOutputPattern:@"+# (###) ###-##-##" forRegExp:@"^7[0-689]\\d*$" imagePath:@"SHSPhoneImage.bundle/flag_ru"];
    [self.textField.formatter addOutputPattern:@"+### ###-##-##" forRegExp:@"^380\\d*$" imagePath:@"SHSPhoneImage.bundle/flag_ua"];
}

-(void) phoneDoubleFormatExamplePrefixed
{
    [self.textField.formatter setDefaultOutputPattern:@"### ### ###"];
    self.textField.formatter.prefix = @"+7 ";
    [self.textField.formatter addOutputPattern:@"(###) ###-##-##" forRegExp:@"^1\\d*$" imagePath:@"SHSPhoneImage.bundle/flag_ru"];
    [self.textField.formatter addOutputPattern:@"(###) ###-###" forRegExp:@"^2\\d*$" imagePath:@"SHSPhoneImage.bundle/flag_ua"];
}

#pragma mark -
@end
