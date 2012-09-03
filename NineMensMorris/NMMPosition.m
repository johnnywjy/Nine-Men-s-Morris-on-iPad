//
//  NMMPosition.m
//  NineMensMorris
//
//  Created by lynny on 03/09/2012.
//  Copyright (c) 2012 UoL. All rights reserved.
//

#import "NMMPosition.h"

@implementation NMMPosition

@synthesize pieceOnPosition = _pieceOnPosition;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _pieceOnPosition = nil;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
