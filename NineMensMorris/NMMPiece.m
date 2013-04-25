//
//  NMMPiece.m
//  NineMensMorris
//
//  Created by lynny on 03/09/2012.
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
