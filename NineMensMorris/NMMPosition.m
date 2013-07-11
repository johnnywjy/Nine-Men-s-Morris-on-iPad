//
//  NMMPosition.m
//  NineMensMorris
//
//  Created by lynny on 03/09/2012.
//  Copyright (c) 2012 UoL. All rights reserved.
//

#import "NMMPosition.h"

@implementation NMMPosition

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _pieceOnPosition = nil;
    }
    return self;
}

@end
