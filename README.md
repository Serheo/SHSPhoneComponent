SHSPhoneComponent
=================

UITextField and NSFormatter subclasses for formatting phone numbers. Allow different formats for different countries(patterns).

## How To Install
Temporary not available

##Example Usage
If you need complete example please see /example folder.

### Default Format
``` objective-c
[self.phoneField setDefaultOutputPattern:@"## (###) ###-##-##" imagePath:nil];
```
<p align="center">
  <img src="https://dl.dropboxusercontent.com/u/3310118/github/shsphonecomponent/r3.png" alt="shspc example 1"/>
</p>
All input strings will be parsed in that way. 
Example: +7 (920) 123-45-67

### Specific Formats
If you want to format some numbers in specific way just do
``` objective-c
[self.phoneField addOutputPattern:@"#### (##) ###-###" forRegExp:@"^\\+374\\d*$" imagePath:@"flagAM"];
```
<p align="center">
  <img src="https://dl.dropboxusercontent.com/u/3310118/github/shsphonecomponent/r4.png" alt="shspc example 2"/>
</p>

##Subclassing/Extending
If you want to use delegate methods you need to subclass SHSPhoneLogicDelegate
 and call setLogicDelegate: method on SHSPhoneTextFeild.
Be careful with textField:shouldChangeCharactersInRange:replacementString: - it should always return NO.
``` objective-c
[self.phoneField setLogicDelegate:newLogicDelegate];
```

##Formatting
If you need only formatting function you can use SHSPhoneNumberFormatter class. 

##Requirements
ARC Enabled.
Tested under iOS >= 5.0.

##License
SHSPhoneComponent is available under the MIT license. See the LICENSE file for more info.






