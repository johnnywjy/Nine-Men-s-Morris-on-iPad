

#import "NMM.h"

@implementation NMM

-(id)init
{
    
    _winner = NONE;
    _phase = PLACING;
    _canFly = NO;
    for (int p = 0; p<24; p++) {
        board[p] = NONE;
    }
    _whiteTurn = YES;
    _whiteCount = 0;
    _blackCount = 0;
    _selectedPiece = NOT_SELECTED;
    _isMovingPhase = NO;
    return self;
    
}

-(void)reset
{
    NSLog(@"reset");
}

-(int)getPosition:(int)pos
{
    return board[pos];
}

-(int *)getBoard
{
    return board;
}


-(BOOL)checkMill:(int)colour withPosition:(int)position
{
    for (int p = 0; p<24; p+=2) {
        if (p==0||p==8||p==16) {//special column
            if (board[p]==colour && board[p+7]==colour && board[p+6]==colour) {
                if (p==position||p+7==position||p+6==position) {
                    NSLog(@"mill0 at %d %d %d",p,p+7,p+6);
                    return YES;
                }
            }
        }
        if (board[p]==colour && board[p+1]==colour && board[p+2]==colour) {//same ring
            if (p==position||p+1==position||p+2==position) {
                if (p == 6 || p == 14 || p == 22) {
                    continue;
                }
                NSLog(@"mill1 at %d %d %d",p,p+1,p+2);
                return YES;
            }
        }
    }
    
    for (int p1 = 1; p1 <= 7; p1 += 2) {
        if (board[p1]==colour && board[p1+8]==colour && board[p1+16]==colour) {//accross rings
            if (p1==position||p1+8==position||p1+16==position) {
                NSLog(@"mill2 at %d %d %d",p1,p1+8,p1+16);
                return YES;
            }
        }
    }
    return NO;
}

-(BOOL)checkWin:(int)colour
{
    if (_phase == PLACING) {
        return NO;
    }
    else{
        int othercolour = (colour==WHITE?BLACK:WHITE);
    //no piece can move
        if (![self pieceCanMove:othercolour]) {
            _phase = ENDING;
            NSLog(@"no piece can move!");
            _winner = colour;
            return YES;
        }
    //less than 3 pieces
        if ([self piecesRemain:othercolour] < 3) {
            _phase = ENDING;
            NSLog(@"less than 3 pieces");
            _winner = colour;
            return YES;
        }
    }
    return NO;
}

-(int)piecesRemain:(int)colour
{
    int result = 0;
    for (int i = 0; i<24; i++) {
        if (board[i]==colour) {
            result++;
        }
    }
    return result;
}



-(BOOL)position:(int)pos1 isAdjacentTo:(int)pos2
{
    int big = pos1>pos2?pos1:pos2;
    int small = pos1>pos2?pos2:pos1;
    int diff = big - small;
    if (big-small==1) {
        if (small == 7 || small ==15) {
            return NO;
        }
        return YES;
    }
    if ((small == 0 ||small == 8 || small == 16) && diff == 7 ) {
        return YES;
    }
    if (small%2 ==1 && diff == 8) {
        return YES;
    }
    
    NSLog(@"pos1 = %d pos2 = %d",pos1,pos2);
    return NO;
}

-(BOOL)canFly:(int)colour
{
    if (!_canFly) {
        return NO;
    }
    if ([self piecesRemain:colour]==3) {
        return YES;
    }
    return NO;
}

-(BOOL)pieceCanMove:(int)colour{

    if (_canFly && [self piecesRemain:colour] == 3) {
        return YES;
    }
    for (int i = 0; i < 24; i++) {
        if (board[i] == colour) {
            for (int j = 0; j<24; j++) {
                if (j == i) {
                    continue;
                }
                if (board[j] == NONE && [self position:i isAdjacentTo:j]) {
                    return YES;
                }
            }
        }
    }
    return NO;
}

-(void)changeTurn
{
    _whiteTurn = !_whiteTurn;
}

-(void)increaseCountWithColour:(int)colour
{
    if (colour == WHITE) {
        _whiteCount++;
    }else if (colour == BLACK){
        _blackCount++;
    }else{
        NSLog(@"err in increasing count ");
    }
}

-(BOOL)canPlaceWithColour:(int)colour atPosition:(int)position
{
    if ([self getPosition:position] == NONE) {
        return YES;
    }
    return NO;
}

-(BOOL)placePieceWithColour:(int)colour atPosition:(int)position
{
    if ([self canPlaceWithColour:colour atPosition:position]) {
        NSLog(@"%d with colour %d",position, colour);
        board[position] = colour;

        [self increaseCountWithColour:colour];
        NSLog(@"colour %d count:%d", colour, colour==WHITE?_whiteCount:_blackCount);

        if (colour == BLACK && _blackCount == 9) {
            _isMovingPhase =YES;
        }
        
        if([self checkMill:colour withPosition:position]) {
            _phase = REMOVING;
            return YES;
        }else if (_isMovingPhase) {
            _phase = MOVING;
        }
        [self changeTurn];
        return YES;
    }
    return NO;
}

-(BOOL)canRemovePieceAtPosition:(int)position
{
    if (_phase == REMOVING && board[position] != NONE) {
        int colour = [self getPosition:position];
        BOOL allInMill = YES;
        for (int i = 0; i<24; i++) {
            if (board[i] == colour) {
                if (![self checkMill:colour withPosition:i]) {
                    allInMill = NO;
                }
            }
        }
        
        if (![self checkMill:colour withPosition:position]) {
            return YES;
        }
        else if (allInMill) {
            return YES;
        }
    }
    return NO;
}

-(BOOL)removePieceAtPosition:(int)position
{
    if ([self canRemovePieceAtPosition:position]) {
        int colour = board[position];
        board[position] = NONE;
        if ([self isMovingPhase]) {
            _phase = MOVING;
        }else{
            _phase = PLACING;
        }
        NSLog(@"%d removed at %d", colour, position);
        
        //moving phase, check win
        int otherColour = (colour==WHITE?BLACK:WHITE);
        if (_isMovingPhase && [self checkWin:otherColour]) {
            NSLog(@"%d WIN!", otherColour);
        }else{
            NSLog(@"change turn after removing at %d", position);
            [self changeTurn];
        }
        return YES;
    }
    return NO;
}

-(BOOL)canMoveFrom:(int)pos1 to:(int)pos2
{
    int colour = board[pos1];
    if (board[pos1] != NONE && board[pos2] == NONE) {
        if ((_canFly && [self piecesRemain:colour]==3) || ([self position:pos1 isAdjacentTo:pos2]) ) {
            return YES;
        }
    }
    return NO;
}

-(BOOL)moveFrom:(int)pos1 to:(int)pos2{
    if ([self canMoveFrom:pos1 to:pos2]) {
        int colour = board[pos1];
        board[pos1] = NONE;
        board[pos2] = colour;
        if([self checkMill:colour withPosition:pos2]) {
            _phase = REMOVING;
            return YES;
        }
        if ([self checkWin:colour]){
            NSLog(@"%d win!", colour);
            return YES;
        }
        NSLog(@"change turn!");
        [self changeTurn];
        return YES;
    }
    return NO;
}

@end
