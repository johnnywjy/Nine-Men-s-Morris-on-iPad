//
//  NMMPiece.m
//  NineMensMorris
//
//  Created by johnny on 03/09/2012.
//  Copyright (c) 2012 UoL. All rights reserved.
//

#import "NMMPiece.h"

@implementation NMMPiece

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _isOnBoard = NO;
        _isRemoved = NO;
        _positionOnBoard = -1;
    }
    return self;
}

@end
