//
//  UIButton+NMMAdditions.m
//  NineMensMorris
//
//  Created by lynny on 31/08/2012.
//  Copyright (c) 2012 UoL. All rights reserved.
//

#import "UIButton+NMMAdditions.h"
#import "UIFont+NMMAdditions.h"

@implementation UIButton (NMMAdditions)

- (void)applyButtonStyle
{
    self.titleLabel.font = [UIFont nmmFontWithSize:24.0f];
	UIImage *buttonImage = [UIImage imageNamed:@"button"];
	[self setBackgroundImage:buttonImage forState:UIControlStateNormal];
    
	UIImage *pressedImage = [UIImage imageNamed:@"buttonPressed"];
	[self setBackgroundImage:pressedImage forState:UIControlStateHighlighted];
}

@end
