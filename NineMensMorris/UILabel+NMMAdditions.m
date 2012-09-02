//
//  UILabel+NMMAdditions.m
//  NineMensMorris
//
//  Created by lynny on 31/08/2012.
//  Copyright (c) 2012 UoL. All rights reserved.
//

#import "UILabel+NMMAdditions.h"
#import "UIFont+NMMAdditions.h"

@implementation UILabel (NMMAdditions)

-(void) applyLabelStylePlayer{
    self.font = [UIFont nmmFontWithSize:22.0f];
}

-(void) applyLabelStyleMsg{
    self.font = [UIFont nmmFontWithSize:26.0f];
}

-(void) applyLabelStyleDefault{
    self.font = [UIFont nmmFontWithSize:32.0f];
}

-(void)applyLabelStyleWithFontSize:(int)size{
    self.font = [UIFont nmmFontWithSize:size];
}
@end
