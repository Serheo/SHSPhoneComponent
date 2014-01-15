SHSPhoneComponent <a href="https://travis-ci.org/Serheo/SHSPhoneComponent"><img src="https://travis-ci.org/Serheo/SHSPhoneComponent.png"/></a>
=================

UITextField and NSFormatter subclasses for formatting phone numbers. Allow different formats for different countries(patterns).
Caret positioning works excellent.

## How To Install
pod 'SHSPhoneComponent' or copy /SHSPhoneComponent folder to your project.

##Example Usage
If you need complete example please see /example folder.

###Default Format
``` objective-c
[self.phoneField.formatter setDefaultOutputPattern:@"+# (###) ###-##-##"];
```
<p align="center">
  <img src="http://serheo.github.io/SHSPhoneComponent/readme/r1.jpg" alt="shspc example 1"/>
</p>
All input strings will be parsed in that way. 
Example: +7 (920) 123-45-67

Also you can preset first part of number with format. For example, if you want numbers only from Russia, use next code:

``` objective-c
[self.phoneField.formatter setDefaultOutputPattern:@"+7 (###) ###-##-##"];
self.phoneField.formatter.showFormatOnlyIfTextExist = NO;
[self.phoneField setFormattedText:@""];
```
<p align="center">
  <img src="http://serheo.github.io/SHSPhoneComponent/readme/r7.jpg" alt="shspc example 1"/>
</p>

###Specific Formats
If you want to format some numbers in specific way just do
``` objective-c
[self.phoneField.formatter addOutputPattern:@"+# (###) ###-##-##" forRegExp:@"^7[0-689]\\d*$" imagePath:@"flagRU"];
[self.phoneField.formatter addOutputPattern:@"+### (##) ###-###" forRegExp:@"^374\\d*$" imagePath:@"flagAM"];
```
<p align="center">
  <img src="http://serheo.github.io/SHSPhoneComponent/readme/r2.jpg" alt="shspc example 2"/>
</p>

##Formatting
If you need only formatting function you can use SHSPhoneNumberFormatter class. 
For additional class info see http://serheo.github.io/SHSPhoneComponent/

##Requirements
ARC Enabled.
Tested under iOS >= 5.0.
iOS 7 beta support.

##License
SHSPhoneComponent is available under the MIT license. See the LICENSE file for more info.

