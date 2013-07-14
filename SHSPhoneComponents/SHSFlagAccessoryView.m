//
//  SHSFlagAccessoryView.m
//  PhoneComponentExample
//
//  Created by Willy on 14.07.13.
//  Copyright (c) 2013 SHS. All rights reserved.
//

#import "SHSFlagAccessoryView.h"

@implementation SHSFlagAccessoryView

- (id)init
{
    self = [super initWithFrame:CGRectMake(0, 0, 20, 18)];
    if (self) {
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake([self startPoint], 0, 18, 18)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:imageView];
    }
    return self;
}

-(int) startPoint
{
    NSString *version = [[UIDevice currentDevice] systemVersion];
    if ([version compare:@"7" options:NSNumericSearch] != NSOrderedAscending)
    {
       return 6;
    }
    else
    {
       return 0;
    }
}

-(void) setImage:(UIImage *) image
{
    imageView.image = image;
}

@end
