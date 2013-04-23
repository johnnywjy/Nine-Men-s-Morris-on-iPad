//
//  NMMViewController.m
//  NineMensMorris
//
//  Created by lynny on 25/08/2012.
//  Copyright (c) 2012 UoL. All rights reserved.
//

#import "NMMViewController.h"



@interface NMMViewController (){
    CGPoint originalCenter;
    NMMPiece *currentPiece;
    int soundStatus;
    BOOL removing;
    BOOL rotateP2Msg;
    BOOL positionOperation;
    int moveStartPosition;
    
    //messages
    NSString *nmmPlacing;
    NSString *nmmWaiting;
    NSString *nmmMill;
    NSString *nmmMove;
    NSString *nmmWin;
    NSString *nmmLose;
    
    //pieceImg
    NSString *topPieceImg;
    NSString *bottomPieceImg;
    
    NSArray *topPieces;
    NSArray *bottomPieces;
}

@property (weak, nonatomic) IBOutlet UILabel *p1label;
@property (weak, nonatomic) IBOutlet UILabel *p2label;
@property (weak, nonatomic) IBOutlet UILabel *p1msg;
@property (weak, nonatomic) IBOutlet UILabel *p2msg;
@property (weak, nonatomic) IBOutlet UIButton *returnButton;

@property (weak, nonatomic) IBOutlet NMMPiece *topPiece1;
@property (weak, nonatomic) IBOutlet NMMPiece *topPiece2;
@property (weak, nonatomic) IBOutlet NMMPiece *topPiece3;
@property (weak, nonatomic) IBOutlet NMMPiece *topPiece4;
@property (weak, nonatomic) IBOutlet NMMPiece *topPiece5;
@property (weak, nonatomic) IBOutlet NMMPiece *topPiece6;
@property (weak, nonatomic) IBOutlet NMMPiece *topPiece7;
@property (weak, nonatomic) IBOutlet NMMPiece *topPiece8;
@property (weak, nonatomic) IBOutlet NMMPiece *topPiece9;

@property (weak, nonatomic) IBOutlet NMMPiece *bottomPiece1;
@property (weak, nonatomic) IBOutlet NMMPiece *bottomPiece2;
@property (weak, nonatomic) IBOutlet NMMPiece *bottomPiece3;
@property (weak, nonatomic) IBOutlet NMMPiece *bottomPiece4;
@property (weak, nonatomic) IBOutlet NMMPiece *bottomPiece5;
@property (weak, nonatomic) IBOutlet NMMPiece *bottomPiece6;
@property (weak, nonatomic) IBOutlet NMMPiece *bottomPiece7;
@property (weak, nonatomic) IBOutlet NMMPiece *bottomPiece8;
@property (weak, nonatomic) IBOutlet NMMPiece *bottomPiece9;

@property (weak, nonatomic) IBOutlet NMMPosition *pos0;
@property (weak, nonatomic) IBOutlet NMMPosition *pos1;
@property (weak, nonatomic) IBOutlet NMMPosition *pos2;
@property (weak, nonatomic) IBOutlet NMMPosition *pos3;
@property (weak, nonatomic) IBOutlet NMMPosition *pos4;
@property (weak, nonatomic) IBOutlet NMMPosition *pos5;
@property (weak, nonatomic) IBOutlet NMMPosition *pos6;
@property (weak, nonatomic) IBOutlet NMMPosition *pos7;
@property (weak, nonatomic) IBOutlet NMMPosition *pos8;
@property (weak, nonatomic) IBOutlet NMMPosition *pos9;
@property (weak, nonatomic) IBOutlet NMMPosition *pos10;
@property (weak, nonatomic) IBOutlet NMMPosition *pos11;
@property (weak, nonatomic) IBOutlet NMMPosition *pos12;
@property (weak, nonatomic) IBOutlet NMMPosition *pos13;
@property (weak, nonatomic) IBOutlet NMMPosition *pos14;
@property (weak, nonatomic) IBOutlet NMMPosition *pos15;
@property (weak, nonatomic) IBOutlet NMMPosition *pos16;
@property (weak, nonatomic) IBOutlet NMMPosition *pos17;
@property (weak, nonatomic) IBOutlet NMMPosition *pos18;
@property (weak, nonatomic) IBOutlet NMMPosition *pos19;
@property (weak, nonatomic) IBOutlet NMMPosition *pos20;
@property (weak, nonatomic) IBOutlet NMMPosition *pos21;
@property (weak, nonatomic) IBOutlet NMMPosition *pos22;
@property (weak, nonatomic) IBOutlet NMMPosition *pos23;

@end

@implementation NMMViewController
@synthesize p1label = _p1label;
@synthesize p2label = _p2label;
@synthesize p1msg = _p1msg;
@synthesize p2msg = _p2msg;
@synthesize returnButton = _returnButton;
@synthesize topPiece1 = _topPiece1;
@synthesize topPiece2 = _topPiece2;
@synthesize topPiece3 = _topPiece3;
@synthesize topPiece4 = _topPiece4;
@synthesize topPiece5 = _topPiece5;
@synthesize topPiece6 = _topPiece6;
@synthesize topPiece7 = _topPiece7;
@synthesize topPiece8 = _topPiece8;
@synthesize topPiece9 = _topPiece9;
@synthesize bottomPiece1 = _bottomPiece1;
@synthesize bottomPiece2 = _bottomPiece2;
@synthesize bottomPiece3 = _bottomPiece3;
@synthesize bottomPiece4 = _bottomPiece4;
@synthesize bottomPiece5 = _bottomPiece5;
@synthesize bottomPiece6 = _bottomPiece6;
@synthesize bottomPiece7 = _bottomPiece7;
@synthesize bottomPiece8 = _bottomPiece8;
@synthesize bottomPiece9 = _bottomPiece9;
@synthesize pos0 = _pos0;
@synthesize pos1 = _pos1;
@synthesize pos2 = _pos2;
@synthesize pos3 = _pos3;
@synthesize pos4 = _pos4;
@synthesize pos5 = _pos5;
@synthesize pos6 = _pos6;
@synthesize pos7 = _pos7;
@synthesize pos8 = _pos8;
@synthesize pos9 = _pos9;
@synthesize pos10 = _pos10;
@synthesize pos11 = _pos11;
@synthesize pos12 = _pos12;
@synthesize pos13 = _pos13;
@synthesize pos14 = _pos14;
@synthesize pos15 = _pos15;
@synthesize pos16 = _pos16;
@synthesize pos17 = _pos17;
@synthesize pos18 = _pos18;
@synthesize pos19 = _pos19;
@synthesize pos20 = _pos20;
@synthesize pos21 = _pos21;
@synthesize pos22 = _poa22;
@synthesize pos23 = _pos23;
@synthesize portraitView = _portraitView;
@synthesize landscapeView = _landscapeView;
@synthesize delegate = _delegate;

- (void)viewDidLoad
{
    [super viewDidLoad];

    //init
    if (!nmm) {
        NSLog(@"nmm init");
        nmm = [[NMM alloc]init];
    }
    
    //read settings
    NSString *settings = [NMMSettings getCurrentSettings];
    if ([settings characterAtIndex:0] == '1') {//sound
        soundStatus = SOUND_ENABLED;
    }else{
        soundStatus = SOUND_MUTE;
    }
    
    if ([settings characterAtIndex:1] == '1') {
        [nmm setCanFly:YES];
    }else{
        [nmm setCanFly:NO];
    }
    
    //init vars
    removing = NO;
    rotateP2Msg = YES;//TODO: set it to NO in Multi-Device Mode
    positionOperation = NO;
    
    //rotate p2 labels
    if (rotateP2Msg) {
        _p2label.transform = CGAffineTransformMakeRotation(degreesToRadian(180));
        _p2msg.transform = CGAffineTransformMakeRotation(degreesToRadian(180));
        topPieceImg = @"black.png";//change this in multi-player game
        bottomPieceImg = @"white.png";
    }
    else{
        //TODO: decide the colour 
    }
    
    //init piece images    
    [_topPiece1 setImage:[UIImage imageNamed:topPieceImg] forState:UIControlStateNormal];
    [_topPiece2 setImage:[UIImage imageNamed:topPieceImg] forState:UIControlStateNormal];
    [_topPiece3 setImage:[UIImage imageNamed:topPieceImg] forState:UIControlStateNormal];
    [_topPiece4 setImage:[UIImage imageNamed:topPieceImg] forState:UIControlStateNormal];
    [_topPiece5 setImage:[UIImage imageNamed:topPieceImg] forState:UIControlStateNormal];
    [_topPiece6 setImage:[UIImage imageNamed:topPieceImg] forState:UIControlStateNormal];
    [_topPiece7 setImage:[UIImage imageNamed:topPieceImg] forState:UIControlStateNormal];
    [_topPiece8 setImage:[UIImage imageNamed:topPieceImg] forState:UIControlStateNormal];
    [_topPiece9 setImage:[UIImage imageNamed:topPieceImg] forState:UIControlStateNormal];

    [_bottomPiece1 setImage:[UIImage imageNamed:bottomPieceImg] forState:UIControlStateNormal];
    [_bottomPiece2 setImage:[UIImage imageNamed:bottomPieceImg] forState:UIControlStateNormal];
    [_bottomPiece3 setImage:[UIImage imageNamed:bottomPieceImg] forState:UIControlStateNormal];
    [_bottomPiece4 setImage:[UIImage imageNamed:bottomPieceImg] forState:UIControlStateNormal];
    [_bottomPiece5 setImage:[UIImage imageNamed:bottomPieceImg] forState:UIControlStateNormal];
    [_bottomPiece6 setImage:[UIImage imageNamed:bottomPieceImg] forState:UIControlStateNormal];
    [_bottomPiece7 setImage:[UIImage imageNamed:bottomPieceImg] forState:UIControlStateNormal];
    [_bottomPiece8 setImage:[UIImage imageNamed:bottomPieceImg] forState:UIControlStateNormal];
    [_bottomPiece9 setImage:[UIImage imageNamed:bottomPieceImg] forState:UIControlStateNormal];
   
    
    //add pieces into arrays
    topPieces = [NSArray arrayWithObjects:_topPiece1,_topPiece2,_topPiece3,_topPiece4,_topPiece5,_topPiece6,_topPiece7,_topPiece8,_topPiece9, nil];
    bottomPieces = [NSArray arrayWithObjects:_bottomPiece1,_bottomPiece2,_bottomPiece3,_bottomPiece4,_bottomPiece5,_bottomPiece6,_bottomPiece7,_bottomPiece8,_bottomPiece9, nil];
    
    
    //set Label/Button style
    [_returnButton applyButtonStyle];
    [_p1label applyLabelStylePlayer];
    [_p2label applyLabelStylePlayer];
    [_p1msg applyLabelStyleMsg];
    [_p2msg applyLabelStyleMsg];
    
    
    //messages
    nmmPlacing = @"place a piece";
    nmmWaiting = @"waiting for opponent...";
    nmmMill = @"remove a piece from opponent";
    nmmMove = @"move a piece";
    nmmWin = @"You Win!";
    nmmLose = @"You lose";
    
    //set init msg
    _p1msg.text = nmmPlacing;
    _p2msg.text = nmmWaiting;
    

    
    //FIXME set auto rotation
    if (autorotateEnabled) {
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:@"UIDeviceOrientationDidChangeNotification" object:nil];
    }
}

- (void)viewDidUnload
{
    [self setPortraitView:nil];
    [self setLandscapeView:nil];
    [self setTopPiece1:nil];
    [self setTopPiece2:nil];
    [self setTopPiece3:nil];
    [self setTopPiece4:nil];
    [self setTopPiece5:nil];
    [self setTopPiece6:nil];
    [self setTopPiece7:nil];
    [self setTopPiece8:nil];
    [self setTopPiece9:nil];
    [self setBottomPiece1:nil];
    [self setBottomPiece2:nil];
    [self setBottomPiece3:nil];
    [self setBottomPiece4:nil];
    [self setBottomPiece5:nil];
    [self setBottomPiece6:nil];
    [self setBottomPiece7:nil];
    [self setBottomPiece8:nil];
    [self setBottomPiece9:nil];
    [self setPos0:nil];
    [self setPos1:nil];
    [self setPos2:nil];
    [self setPos3:nil];
    [self setPos4:nil];
    [self setPos5:nil];
    [self setPos6:nil];
    [self setPos7:nil];
    [self setPos8:nil];
    [self setPos9:nil];
    [self setPos10:nil];
    [self setPos11:nil];
    [self setPos12:nil];
    [self setPos13:nil];
    [self setPos14:nil];
    [self setPos15:nil];
    [self setPos16:nil];
    [self setPos17:nil];
    [self setPos18:nil];
    [self setPos19:nil];
    [self setPos20:nil];
    [self setPos21:nil];
    [self setPos22:nil];
    [self setPos23:nil];
    [self setP1msg:nil];
    [self setP2msg:nil];
    [self setP1label:nil];
    [self setP2label:nil];
    [self setReturnButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

#pragma mark - IBActions - Piece

-(IBAction)pieceTouch:(NMMPiece *)sender{
    originalCenter = sender.center;
    if (nmm.phase == MOVING) {
        moveStartPosition = [self getPiecePosition:sender];
        NSLog(@"move piece from %d...", moveStartPosition);
    }
}

-(IBAction)pieceMove:(NMMPiece *)sender withEvent:(UIEvent *) event{
    if (nmm.phase != REMOVING && nmm.phase != ENDING) {
        CGPoint point = [[[event allTouches]anyObject] locationInView:self.view];
        //[button setImage:[UIImage imageNamed: @"blackHL.png"] forState:UIControlStateNormal];
        sender.center = point;
    }
}

-(IBAction)pieceTouchUpInside:(NMMPiece *)sender{
    int pos = [self getPiecePosition:sender];
    if (pos == -1) {
        [self moveBack:sender];
        return;
    }
    
    switch (nmm.phase) {
        case PLACING:
            //can't move pieces in board
            if (sender.isOnBoard) {
                [self moveBack:sender];
                return;
            }

            
            if ([nmm whiteTurn]) {//white
                if ([self isWhite:sender]) {
                    if ([nmm placePieceWithColour:WHITE atPosition:pos]) {
                        [self dropPieceAnimated:sender atPosition:pos];
                        [self checkAfterPieceDropForPlayerColour:WHITE inPhase:PLACING];
                        return;
                    }
                }
                [self moveBack:sender];
            }
            else{//black 
                if (![self isWhite:sender]) {
                    if ([nmm placePieceWithColour:BLACK atPosition:pos]) {
                        [self dropPieceAnimated:sender atPosition:pos];
                        [self checkAfterPieceDropForPlayerColour:BLACK inPhase:PLACING];
                        return;
                    }
                }
                [self moveBack:sender];
            }
            break;
        case REMOVING:
            if ([nmm whiteTurn]) {
                if (![self isWhite:sender]) {
                    if ([nmm removePieceAtPosition:pos]) {
                        [self removePieceAnimated:sender atPosition:pos];
                        [self showPiecesNormal:BLACK];
                        [self checkAfterPieceDropForPlayerColour:WHITE inPhase:REMOVING];
                    }
                }
            }
            else{//black
                if ([self isWhite:sender]) {
                    if ([nmm removePieceAtPosition:pos]) {
                        [self removePieceAnimated:sender atPosition:pos];
                        [self showPiecesNormal:WHITE];
                        [self checkAfterPieceDropForPlayerColour:BLACK inPhase:REMOVING];
                    }
                }
            }
            break;
        case MOVING:
            if ([nmm whiteTurn]) {
                if ([self isWhite:sender]) {
                    if ([nmm moveFrom:moveStartPosition to:pos]) {
                        [self dropPieceAnimated:sender atPosition:pos];
                        [self checkAfterPieceDropForPlayerColour:WHITE inPhase:MOVING];
                        return;
                    }
                }
                [self moveBack:sender];
            }
            else{//black
                if (![self isWhite:sender]) {
                    if ([nmm moveFrom:moveStartPosition to:pos]) {
                        [self dropPieceAnimated:sender atPosition:pos];
                        [self checkAfterPieceDropForPlayerColour:BLACK inPhase:MOVING];
                        return;
                    }
                }
                [self moveBack:sender];
            }
            break;

        case ENDING:
            NSLog(@"game over");
            if (nmm.winner == WHITE) {
                [self msgPlayerWin:WHITE];
            }
            else{
                [self msgPlayerWin:BLACK];
            }
            break;
        default:
            NSLog(@"unexpected phase");
            break;
    }
}

-(IBAction)touchUpOutside:(NMMPiece *)sender{
    NSLog(@"touchUpOutside");
    [self moveBack:sender];
}



#pragma mark - IBActions - Position
-(IBAction)positionTouch:(NMMPosition *)sender{
    switch (nmm.phase) {
        case PLACING:
            positionOperation = YES;
            break;
        case MOVING:
            break;
            
        case REMOVING:
            break;
            
        default:
            break;
    }

}

-(IBAction)positionTouchUpInside:(NMMPosition *)sender{
    switch (nmm.phase) {
        case PLACING:
            if (positionOperation) {
                if ([nmm whiteTurn]) {
                    for (NMMPiece *p in bottomPieces) {
                        if (![p isOnBoard] && ![p isRemoved]) {
                            if ([nmm placePieceWithColour:WHITE atPosition:sender.tag - 1]) {
                                [self dropPieceAnimated:p atPosition:sender.tag-1];
                                [self checkAfterPieceDropForPlayerColour:WHITE inPhase:PLACING];
                                NSLog(@"bottom tag is %d",p.tag);
                                break;
                            }
                        }
                    }
                }
                else{//black
                    for (NMMPiece *p in topPieces) {
                        if (![p isOnBoard] && ![p isRemoved]) {
                            if ([nmm placePieceWithColour:BLACK atPosition:sender.tag - 1]) {
                                [self dropPieceAnimated:p atPosition:sender.tag-1];
                                [self checkAfterPieceDropForPlayerColour:BLACK inPhase:PLACING];
                                NSLog(@"top tag is %d",p.tag);
                                break;
                            }
                        }
                    }
                }
            }
            positionOperation = NO;
            break;
            
        case MOVING:
            break;
            
        case REMOVING:
            break;
            
        default:
            break;
    }
    
}


- (IBAction)returnPressed:(UIButton *)sender {
    [self.delegate dismissViewController:self];
}


-(IBAction)testMoveFunction:(UIButton *)sender{
    //TODO rewrite it in multi device game
    
    //random move
    int tag = -1;
    int pos = -1;
    tag = arc4random()%9 + 1;
   
    NSLog(@"tag = %d", tag);
    
    while (pos == -1 || [nmm getPosition:pos]!=NONE) {
        pos = arc4random()%24;
    }
    NSLog(@"pos = %d", pos);
    
    [self movePiece:BLACK withTag:tag toPosition:pos];
    [nmm placePieceWithColour:BLACK atPosition:pos];
}




#pragma mark - general functions

-(void)moveBack:(UIButton *)piece{
    [UIView animateWithDuration:ANIMATION_DURATION
                     animations:^{piece.center = originalCenter;
                     }
     ];
    [self playSound:(CFStringRef)SOUND_RETURN withSetting:soundStatus];
}

-(int)getPiecePosition:(NMMPiece *)piece{
    //notice this function returns the new position of the piece
    int pos = -1;
    for (int i = 1; i<25; i++) {
        NMMPosition * b = (NMMPosition *)[self.view viewWithTag:i];
        if ([self isClose:piece to:b]) {
            pos = i-1;
            break;
        }
    }
    return pos;
}

-(NMMPosition *)getPositionFromNumber:(int)pos{
    return (NMMPosition *)[self.view viewWithTag:pos+1]; //tag of NMMPosition start from 1, nmm board start from 0
}

-(NMMPiece *)getPieceFromNumber:(int)tag{
  return (NMMPiece *)[self.view viewWithTag:tag];
}

-(void)dropPieceAnimated:(NMMPiece *)piece atPosition:(int)pos{
    NMMPosition *p = [self getPositionFromNumber:pos];
    [UIView animateWithDuration:ANIMATION_DURATION
                     animations:^{
                         piece.center = p.center;
                         [self playSound:(CFStringRef)SOUND_DROP withSetting:soundStatus];
                     }
                     completion:^(BOOL finished){
                         piece.isOnBoard = YES;
                         piece.positionOnBoard = pos;
                         p.pieceOnPosition = piece;
                         NSLog(@"place dropped at position %d, mode 1", pos);
                     }
     ];
}

-(void)checkAfterPieceDropForPlayerColour:(int)colour inPhase:(int)phase{
    int currentPlayer = -1;
    int opponent = -1;
    
    if (colour == WHITE) {
        currentPlayer = WHITE;
        opponent = BLACK;
    }else{
        currentPlayer = BLACK;
        opponent = WHITE;
    }
    switch (phase) {
        case PLACING:
            if (nmm.phase == REMOVING) {
                [self msgPlayerRemove:currentPlayer];
                [self showPiecesCanBeRemoved:opponent];
            }
            else
            {
                if (currentPlayer == BLACK) {
                    if ([nmm isMovingPhase]) {
                        [self msgPlayerMove:WHITE];
                    }else{
                        [self msgPlayerPlace:WHITE];
                    }
                }
                else{
                    [self msgPlayerPlace:opponent];
                }
            }
            break;
        case REMOVING:
            if (nmm.phase == ENDING) {
                [self msgPlayerWin:currentPlayer];
                [self playSound:(CFStringRef)SOUND_END withSetting:soundStatus];
                return;
            }
            if ([nmm isMovingPhase]) {
                [self msgPlayerMove:opponent];
            }
            else{
                [self msgPlayerPlace:opponent];
            }
            break;
        case MOVING:
            if (nmm.phase == REMOVING) {
                [self msgPlayerRemove:currentPlayer];
                [self showPiecesCanBeRemoved:opponent];
            }
            else if (nmm.phase == ENDING){
                [self msgPlayerWin:currentPlayer];
                [self playSound:(CFStringRef)SOUND_END withSetting:soundStatus];
            }
            else{
                [self msgPlayerMove:opponent];
            }
            break;
        default:
            break;
    }
}

//For multi-device game: move a piece to a position
-(void)movePiece:(int)colour withTag:(int)tag toPosition:(int)pos{
    int offset = 0;
    if (colour == WHITE) {
        offset = WHITE_OFFSET;
    }
    else if (colour == BLACK) {
        offset = BLACK_OFFSET;
    }
    else{
        NSLog(@"unexpected colour in movePiece:withTag:toPosition:");
    }
    int pieceTag = tag + offset;
    NMMPiece * piece = [self getPieceFromNumber:pieceTag];
    NMMPosition *p = [self getPositionFromNumber:pos];
    [self dropPieceAnimated:piece atPosition:p.tag-1];
}


-(void)removePieceAnimated:(NMMPiece *)sender atPosition:(int)pos{
    NMMPosition *p = [self getPositionFromNumber:pos];
    [UIView animateWithDuration:ANIMATION_DURATION delay:0.0
                        options:UIViewAnimationOptionTransitionCrossDissolve
                     animations:^{
                         [sender setAlpha:0];
                         [self playSound:(CFStringRef)SOUND_REMOVE withSetting:soundStatus];
                     }completion:^(BOOL finished){
                         [sender setImage:nil forState:UIControlStateNormal];
                         [sender setEnabled:NO];
                         sender.positionOnBoard = -1;
                         sender.isOnBoard = NO;
                         sender.isRemoved = YES;
                         p.pieceOnPosition = nil;
                         NSLog(@"removePieceAnimated done");
                     }
     ];
}


-(BOOL)isWhite:(NMMPiece *)piece{
    if (piece.tag<BLACK_OFFSET) {
        return YES;
    }
    return NO;
}

-(BOOL)isClose:(UIButton *)button1 to:(UIButton *)button2{
    return [self pointClose:button1.center to:button2];
}

-(BOOL)pointClose:(CGPoint)point to:(UIButton *)button{
    CGFloat d = MIN_DISTANCE;
    if (abs(point.x - button.center.x) < d && abs(point.y - button.center.y) < d) {
        return YES;
    }
    return NO;
}

#pragma mark - play sounds
-(void)playSound:(CFStringRef)filename withSetting:(int) setting{
    if (setting == SOUND_MUTE) {
        return;
    }
    else if (setting == SOUND_ENABLED){
        CFBundleRef mainBundle = CFBundleGetMainBundle();
        CFURLRef soundURLRef = CFBundleCopyResourceURL(mainBundle, (CFStringRef)filename , CFSTR("wav"), nil);
        UInt32 soundID;
        AudioServicesCreateSystemSoundID(soundURLRef, &soundID);
        AudioServicesPlaySystemSound(soundID);
        CFRelease(soundURLRef);
    }
}

#pragma mark - about display

-(void)showPiecesCanBeRemoved:(int)colour{
    NSString *pieceHL;
    if (colour == WHITE) {
        pieceHL = @"whiteHL.png";
    }else if (colour == BLACK) {
        pieceHL = @"blackHL.png";
    }else{
        NSLog(@"unexpected colour in showPiecesCanBeRemoved:");
    }
    for (int pos=0; pos<24; pos++) {
        if ([nmm getPosition:pos] == colour && [nmm canRemovePieceAtPosition:pos]) {
            NMMPosition *position = [self getPositionFromNumber:pos];
            NMMPiece *piece = position.pieceOnPosition;
            [piece setImage:[UIImage imageNamed:pieceHL] forState:UIControlStateNormal];
        }
    }
}

-(void)showPiecesNormal:(int)colour{
    NSString *pieceImg;
    if (colour == WHITE) {
        pieceImg = @"white.png";
    }else if (colour == BLACK) {
        pieceImg = @"black.png";
    }else{
        NSLog(@"unexpected colour in showPiecesNormal:");
    }
    for (int pos=0; pos<24; pos++) {
        if ([nmm getPosition:pos] == colour) {
            NMMPosition *position = [self getPositionFromNumber:pos];
            NMMPiece *piece = position.pieceOnPosition;
            [piece setImage:[UIImage imageNamed:pieceImg] forState:UIControlStateNormal];
        }
    }
}

-(void)msgPlayerPlace:(int)player{
    if (player == WHITE) {
        _p1msg.text = nmmPlacing;
        _p2msg.text = nmmWaiting;
        return;
    }
    if (player == BLACK) {
        _p2msg.text = nmmPlacing;
        _p1msg.text = nmmWaiting;
        return;
    }
    NSLog(@"unexpected player value");
}

-(void)msgPlayerMove:(int)player{
    if (player == WHITE) {
        _p1msg.text = nmmMove;
        _p2msg.text = nmmWaiting;
        return;
    }
    if (player == BLACK) {
        _p2msg.text = nmmMove;
        _p1msg.text = nmmWaiting;
        return;
    }
    NSLog(@"unexpected player value in msgPlayerMove:");
}

-(void)msgPlayerRemove:(int)player{
    if (player == WHITE) {
        _p1msg.text = nmmMill;
        _p2msg.text = nmmWaiting;
        return;
    }
    if (player == BLACK) {
        _p2msg.text = nmmMill;
        _p1msg.text = nmmWaiting;
        return;
    }
    NSLog(@"unexpected player value in msgPlayerRemove:");
}


-(void)msgPlayerWin:(int)player{
    if (player == WHITE) {
        _p1msg.text = nmmWin;
        _p2msg.text = nmmLose;
        return;
    }
    if (player == BLACK) {
        _p2msg.text = nmmWin;
        _p1msg.text = nmmLose;
        return;
    }
    NSLog(@"unexpected player value in msgPlayerWin:");
}

#pragma mark - about orientation

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)orientation duration:(NSTimeInterval)duration {
    [super willAnimateRotationToInterfaceOrientation:orientation duration:duration];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return autorotateSetting;
}

-(void) orientationChanged:(NSNotification *)obj
{
    NSLog(@"orientationChanged");
    UIDeviceOrientation deviceOrientation = [[obj object] orientation];
    if (deviceOrientation == UIInterfaceOrientationPortrait)
    {
        NSLog(@"portrait00");
        self.view = self.portraitView;
    }
    if (deviceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        NSLog(@"portrait01");
        self.view = self.portraitView;
    }
    
    if(deviceOrientation == UIInterfaceOrientationLandscapeLeft)
    {
        NSLog(@"landscapeLeft");
        self.view = self.landscapeView;
        //self.view = self.portraitView;
    }
    if(deviceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        NSLog(@"landscapeRight");
        self.view = self.landscapeView;
        //self.view = self.portraitView;
    }
}

@end
