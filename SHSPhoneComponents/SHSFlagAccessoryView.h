//
//  SHSFlagAccessoryView.h
//  PhoneComponentExample
//
//  Created by Willy on 14.07.13.
//  Copyright (c) 2013 SHS. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 Accessory view shows flag images in handsome way.
 Created due to ios7 design chagnes.
*/
@interface SHSFlagAccessoryView : UIView
{
    UIImageView *imageView;
}

/**
 Set image for accessory view.
 */
-(void) setImage:(UIImage *) image;

@end
