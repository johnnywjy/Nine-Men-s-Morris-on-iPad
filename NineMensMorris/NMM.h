

#import <Foundation/Foundation.h>

#define NONE 0
#define WHITE 1
#define BLACK 2
#define PLACING 3
#define MOVING 4
#define REMOVING 5
#define ENDING 6
#define NOT_SELECTED -1

@interface NMM : NSObject
{
    int board[24];
}

@property (nonatomic) BOOL whiteTurn;
@property (nonatomic) NSInteger phase;
@property (nonatomic) BOOL canFly;;
@property (nonatomic) NSInteger whiteCount;
@property (nonatomic) NSInteger blackCount;
@property (nonatomic) NSInteger selectedPiece;
@property (nonatomic) BOOL isMovingPhase;
@property (nonatomic) NSInteger winner;

-(id)init;
-(void)reset;

-(int)getPosition:(int)pos;
-(int *)getBoard;

-(int)piecesRemain:(int)colour;

-(BOOL)checkMill:(int)colour withPosition:(int)position;
-(BOOL)checkWin:(int)colour;

-(BOOL)canFly:(int)colour;
-(void)changeTurn;
-(void)increaseCountWithColour:(int)colour;
-(BOOL)position:(int)pos1 isAdjacentTo:(int)pos2;

-(BOOL)pieceCanMove:(int)position;

-(BOOL)canPlaceWithColour:(int)colour atPosition:(int)position;
-(BOOL)placePieceWithColour:(int)colour atPosition:(int)position;
-(BOOL)canRemovePieceAtPosition:(int)position;
-(BOOL)removePieceAtPosition:(int)position;
-(BOOL)canMoveFrom:(int)pos1 to:(int)pos2;
-(BOOL)moveFrom:(int)pos1 to:(int)pos2;
@end
