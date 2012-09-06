//
//  NMMViewController.m
//  NineMensMorris
//
//  Created by lynny on 25/08/2012.
//  Copyright (c) 2012 UoL. All rights reserved.
//

#import "NMMViewController.h"

#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define MIN_DISTANCE 40.0f
#define WHITE_OFFSET 1000
#define BLACK_OFFSET 2000
#define ANIMATION_DURATION 0.3f

//coordinates L1R1 = Layer 1 (biggest ring) row 1, L3C2 = layer 3 column 2
#define L1R1 197.0
#define L1C1 81.0
#define L2R1 292.0
#define L2C1 181.0
#define L3R1 389.0
#define L3C1 280.0
#define L1R3 779.0
#define L1C3 677.0
#define L2R3 681.0
#define L2C3 576.0
#define L3R3 585.0
#define L3C3 478.0
//all rings/layers share column 2 and row 2
#define R2 486.0
#define C2 379.0

@interface NMMViewController (){
    CGPoint originalCenter;
    NMMPiece *currentPiece;
    BOOL soundEnabled;
    BOOL removing;
    BOOL rotateP2Msg;
    int moveStartPosition;
    
    //messages
    NSString *nmmPlacing;
    NSString *nmmWaiting;
    NSString *nmmMill;
    NSString *nmmMove;
    NSString *nmmWin;
    NSString *nmmLose;

    CGPoint p0;
    CGPoint p1;
    CGPoint p2;
    CGPoint p3;
    CGPoint p4;
    CGPoint p5;
    CGPoint p6;
    CGPoint p7;
    CGPoint p8;
    CGPoint p9;
    CGPoint p10;
    CGPoint p11;
    CGPoint p12;
    CGPoint p13;
    CGPoint p14;
    CGPoint p15;
    CGPoint p16;
    CGPoint p17;
    CGPoint p18;
    CGPoint p19;
    CGPoint p20;
    CGPoint p21;
    CGPoint p22;
    CGPoint p23;
    
    NSArray *positions;
    
}

@property (weak, nonatomic) IBOutlet UILabel *p1label;
@property (weak, nonatomic) IBOutlet UILabel *p2label;
@property (weak, nonatomic) IBOutlet UILabel *p1msg;
@property (weak, nonatomic) IBOutlet UILabel *p2msg;
@property (weak, nonatomic) IBOutlet UIButton *returnButton;

@property (weak, nonatomic) IBOutlet NMMPiece *w1;
@property (weak, nonatomic) IBOutlet NMMPiece *w2;
@property (weak, nonatomic) IBOutlet NMMPiece *w3;
@property (weak, nonatomic) IBOutlet NMMPiece *w4;
@property (weak, nonatomic) IBOutlet NMMPiece *w5;
@property (weak, nonatomic) IBOutlet NMMPiece *w6;
@property (weak, nonatomic) IBOutlet NMMPiece *w7;
@property (weak, nonatomic) IBOutlet NMMPiece *w8;
@property (weak, nonatomic) IBOutlet NMMPiece *w9;

@property (weak, nonatomic) IBOutlet NMMPiece *b1;
@property (weak, nonatomic) IBOutlet NMMPiece *b2;
@property (weak, nonatomic) IBOutlet NMMPiece *b3;
@property (weak, nonatomic) IBOutlet NMMPiece *b4;
@property (weak, nonatomic) IBOutlet NMMPiece *b5;
@property (weak, nonatomic) IBOutlet NMMPiece *b6;
@property (weak, nonatomic) IBOutlet NMMPiece *b7;
@property (weak, nonatomic) IBOutlet NMMPiece *b8;
@property (weak, nonatomic) IBOutlet NMMPiece *b9;

@end

@implementation NMMViewController
@synthesize p1label = _p1label;
@synthesize p2label = _p2label;
@synthesize p1msg = _p1msg;
@synthesize p2msg = _p2msg;
@synthesize returnButton = _returnButton;
@synthesize w1 = _w1;
@synthesize w2 = _w2;
@synthesize w3 = _w3;
@synthesize w4 = _w4;
@synthesize w5 = _w5;
@synthesize w6 = _w6;
@synthesize w7 = _w7;
@synthesize w8 = _w8;
@synthesize w9 = _w9;
@synthesize b1 = _b1;
@synthesize b2 = _b2;
@synthesize b3 = _b3;
@synthesize b4 = _b4;
@synthesize b5 = _b5;
@synthesize b6 = _b6;
@synthesize b7 = _b7;
@synthesize b8 = _b8;
@synthesize b9 = _b9;
@synthesize portraitView = _portraitView;
@synthesize landscapeView = _landscapeView;

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
        soundEnabled = YES;
    }else{
        soundEnabled = NO;
    }
    
    if ([settings characterAtIndex:1] == '1') {
        [nmm setCanFly:YES];
    }else{
        [nmm setCanFly:NO];
    }
    
    //init vars
    removing = NO;
    rotateP2Msg = YES;//TODO: set it to NO in Multi-Device Mode
    
    //init piece images
    [_w1 setImage:[UIImage imageNamed:@"white.png"] forState:UIControlStateNormal];
    [_w2 setImage:[UIImage imageNamed:@"white.png"] forState:UIControlStateNormal];
    [_w3 setImage:[UIImage imageNamed:@"white.png"] forState:UIControlStateNormal];
    [_w4 setImage:[UIImage imageNamed:@"white.png"] forState:UIControlStateNormal];
    [_w5 setImage:[UIImage imageNamed:@"white.png"] forState:UIControlStateNormal];
    [_w6 setImage:[UIImage imageNamed:@"white.png"] forState:UIControlStateNormal];
    [_w7 setImage:[UIImage imageNamed:@"white.png"] forState:UIControlStateNormal];
    [_w8 setImage:[UIImage imageNamed:@"white.png"] forState:UIControlStateNormal];
    [_w9 setImage:[UIImage imageNamed:@"white.png"] forState:UIControlStateNormal];

    [_b1 setImage:[UIImage imageNamed:@"black.png"] forState:UIControlStateNormal];
    [_b2 setImage:[UIImage imageNamed:@"black.png"] forState:UIControlStateNormal];
    [_b3 setImage:[UIImage imageNamed:@"black.png"] forState:UIControlStateNormal];
    [_b4 setImage:[UIImage imageNamed:@"black.png"] forState:UIControlStateNormal];
    [_b5 setImage:[UIImage imageNamed:@"black.png"] forState:UIControlStateNormal];
    [_b6 setImage:[UIImage imageNamed:@"black.png"] forState:UIControlStateNormal];
    [_b7 setImage:[UIImage imageNamed:@"black.png"] forState:UIControlStateNormal];
    [_b8 setImage:[UIImage imageNamed:@"black.png"] forState:UIControlStateNormal];
    [_b9 setImage:[UIImage imageNamed:@"black.png"] forState:UIControlStateNormal];
    
    
    //init coordinates
    p0 = CGPointMake(L1C1, L1R1);
    p1 = CGPointMake(C2, L1R1);
    p2 = CGPointMake(L1C3, L1R1);
    p3 = CGPointMake(L1C3, R2);
    p4 = CGPointMake(L1C3, L1R3);
    p5 = CGPointMake(C2, L1R3);
    p6 = CGPointMake(L1C1, L1R3);
    p7 = CGPointMake(L1C1, R2);
    
    p8 = CGPointMake(L2C1, L2R1);
    p9 = CGPointMake(C2, L2R1);
    p10 = CGPointMake(L2C3, L2R1);
    p11 = CGPointMake(L2C3, R2);
    p12 = CGPointMake(L2C3, L2R3);
    p13 = CGPointMake(C2, L2R3);
    p14 = CGPointMake(L2C1, L2R3);
    p15 = CGPointMake(L2C1, R2);
    
    p16 = CGPointMake(L3C1, L3R1);
    p17 = CGPointMake(C2, L3R1);
    p18 = CGPointMake(L3C3, L3R1);
    p19 = CGPointMake(L3C3, R2);
    p20 = CGPointMake(L3C3, L3R3);
    p21 = CGPointMake(C2, L3R3);
    p22 = CGPointMake(L3C1, L3R3);
    p23 = CGPointMake(L3C1, R2);
    
    //add position points into NSArray
    positions = [NSArray arrayWithObjects:
                 [NSValue valueWithCGPoint:p0],
                 [NSValue valueWithCGPoint:p1],
                 [NSValue valueWithCGPoint:p2],
                 [NSValue valueWithCGPoint:p3],
                 [NSValue valueWithCGPoint:p4],
                 [NSValue valueWithCGPoint:p5],
                 [NSValue valueWithCGPoint:p6],
                 [NSValue valueWithCGPoint:p7],
                 [NSValue valueWithCGPoint:p8],
                 [NSValue valueWithCGPoint:p9],
                 [NSValue valueWithCGPoint:p10],
                 [NSValue valueWithCGPoint:p11],
                 [NSValue valueWithCGPoint:p12],
                 [NSValue valueWithCGPoint:p13],
                 [NSValue valueWithCGPoint:p14],
                 [NSValue valueWithCGPoint:p15],
                 [NSValue valueWithCGPoint:p16],
                 [NSValue valueWithCGPoint:p17],
                 [NSValue valueWithCGPoint:p18],
                 [NSValue valueWithCGPoint:p19],
                 [NSValue valueWithCGPoint:p20],
                 [NSValue valueWithCGPoint:p21],
                 [NSValue valueWithCGPoint:p22],
                 [NSValue valueWithCGPoint:p23],
                 nil];
    
    //set Label/Button style
    [_returnButton applyButtonStyle];
    [_p1label applyLabelStylePlayer];
    [_p2label applyLabelStylePlayer];
    [_p1msg applyLabelStyleMsg];
    [_p2msg applyLabelStyleMsg];
    
    //rotate p2 labels
    if (rotateP2Msg) {
        _p2label.transform = CGAffineTransformMakeRotation(degreesToRadian(180));
        _p2msg.transform = CGAffineTransformMakeRotation(degreesToRadian(180));
    }
    
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
    [self setW1:nil];
    [self setW2:nil];
    [self setW3:nil];
    [self setW4:nil];
    [self setW5:nil];
    [self setW6:nil];
    [self setW7:nil];
    [self setW8:nil];
    [self setW9:nil];
    [self setB1:nil];
    [self setB2:nil];
    [self setB3:nil];
    [self setB4:nil];
    [self setB5:nil];
    [self setB6:nil];
    [self setB7:nil];
    [self setB8:nil];
    [self setB9:nil];
    [self setP1msg:nil];
    [self setP2msg:nil];
    [self setP1label:nil];
    [self setP2label:nil];
    [self setReturnButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

#pragma mark - IBActions

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
                        if (nmm.phase == REMOVING) {
                            [self msgPlayerRemove:WHITE];
                            [self showPiecesCanBeRemoved:BLACK];
                        }
                        else
                        {
                            [self msgPlayerPlace:BLACK];
                        }
                        return;
                    }
                }
                [self moveBack:sender];
            }
            else{//black 
                if (![self isWhite:sender]) {
                    if ([nmm placePieceWithColour:BLACK atPosition:pos]) {
                        [self dropPieceAnimated:sender atPosition:pos];
                        if (nmm.phase == REMOVING) {
                            [self msgPlayerRemove:BLACK];
                            [self showPiecesCanBeRemoved:WHITE];
                        }
                        else
                        {
                            if ([nmm isMovingPhase]) {
                                [self msgPlayerMove:WHITE];
                            }else{
                                [self msgPlayerPlace:WHITE];
                            }
                        }
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
                        if (nmm.phase == ENDING) {
                            [self msgPlayerWin:WHITE];
                            [self playSoundEnd];
                            return;
                        }
                        if ([nmm isMovingPhase]) {
                            [self msgPlayerMove:BLACK];
                        }
                        else{
                            [self msgPlayerPlace:BLACK];
                        }
                    }
                }
            }
            else{//black
                if ([self isWhite:sender]) {
                    if ([nmm removePieceAtPosition:pos]) {
                        [self removePieceAnimated:sender atPosition:pos];
                        [self showPiecesNormal:WHITE];
                        if (nmm.phase == ENDING) {
                            [self msgPlayerWin:BLACK];
                            [self playSoundEnd];
                            return;
                        }
                        if ([nmm isMovingPhase]) {
                            [self msgPlayerMove:WHITE];
                        }
                        else{
                            [self msgPlayerPlace:WHITE];
                        }
                    }
                }
            }
            break;
        case MOVING:
            if ([nmm whiteTurn]) {
                if ([self isWhite:sender]) {
                    if ([nmm moveFrom:moveStartPosition to:pos]) {
                        [self dropPieceAnimated:sender atPosition:pos];
                        if (nmm.phase == REMOVING) {
                            [self msgPlayerRemove:WHITE];
                            [self showPiecesCanBeRemoved:BLACK];
                        }
                        else if (nmm.phase == ENDING){
                            [self msgPlayerWin:WHITE];
                            [self playSoundEnd];
                        }
                        else{
                            [self msgPlayerMove:BLACK];
                        }
                        return;
                    }
                }
                [self moveBack:sender];
            }
            else{//black
                if (![self isWhite:sender]) {
                    if ([nmm moveFrom:moveStartPosition to:pos]) {
                        [self dropPieceAnimated:sender atPosition:pos];
                        if (nmm.phase == REMOVING) {
                            [self msgPlayerRemove:BLACK];
                            [self showPiecesCanBeRemoved:WHITE];
                        }
                        else if (nmm.phase == ENDING){
                            [self msgPlayerWin:BLACK];
                            [self playSoundEnd];
                        }
                        else{
                            [self msgPlayerMove:WHITE];
                        }
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

-(IBAction)touchUpOutside:(UIButton *)sender{
    NSLog(@"touchUpOutside");
    [self moveBack:sender];
}

- (IBAction)returnPressed:(UIButton *)sender {
    [self.delegate nmmViewControllerDidCancel:self];
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




#pragma mark - general functuins

-(void)moveBack:(UIButton *)piece{
    [UIView animateWithDuration:ANIMATION_DURATION
                     animations:^{piece.center = originalCenter;
                     }
     ];
    if (soundEnabled) {
        [self playSoundReturn];
    }
}

-(int)getPiecePosition:(NMMPiece *)piece{
    //notice this function returns the new position of the piece
    int pos = -1;
    for (int i = 0; i<24; i++) {
        CGPoint position = [(NSValue *)[positions objectAtIndex:i] CGPointValue];
        if ([self pointClose:position to:piece]) {
            pos = i;
            break;
        }
    }
    return pos;
}

-(CGPoint)getPositionFromNumber:(int)pos{
    return  [(NSValue *)[positions objectAtIndex:pos] CGPointValue];
}

-(NMMPiece *)getPieceFromNumber:(int)tag{
  return (NMMPiece *)[self.view viewWithTag:tag];
}

-(void)dropPieceAnimated:(NMMPiece *)piece atPosition:(int)pos{
    CGPoint position = [self getPositionFromNumber:pos];

    [UIView animateWithDuration:ANIMATION_DURATION
                     animations:^{
                         piece.center = position;
                         if (soundEnabled) {
                             [self playSoundPieceDrop];
                         }
                     }
                     completion:^(BOOL finished){
                         piece.isOnBoard = YES;
                         piece.positionOnBoard = pos;
                         //p.pieceOnPosition = piece;
                         NSLog(@"place dropped at position %d, mode 1", pos);
                     }
     ];
}

//For multi-device game: move a piece to a position
-(void)movePiece:(int)colour withTag:(int)tag toPosition:(int)pos{
    int offset;
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
    CGPoint p = [self getPositionFromNumber:pos];
    [UIView animateWithDuration:ANIMATION_DURATION
                     animations:^{
                         piece.center = p;
                         if (soundEnabled) {
                             [self playSoundPieceDrop];
                         }
                     }
                     completion:^(BOOL finished){
                         NSLog(@"place dropped at position %d, mode 2", pos);
                     }
     ];
}

-(void)removePieceAnimated:(NMMPiece *)sender atPosition:(int)pos{
    //CGPoint p = [self getPositionFromNumber:pos];
    [UIView animateWithDuration:ANIMATION_DURATION delay:0.0
                        options:UIViewAnimationOptionTransitionCrossDissolve
                     animations:^{
                         [sender setAlpha:0];
                         if (soundEnabled) {
                             [self playSoundRemove];
                         }
                     }completion:^(BOOL finished){
                         [sender setImage:nil forState:UIControlStateNormal];
                         [sender setEnabled:NO];
                         sender.positionOnBoard = -1;
                         sender.isOnBoard = NO;
                         //p.pieceOnPosition = nil;
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

-(void)playSoundPieceDrop{
    CFBundleRef mainBundle = CFBundleGetMainBundle();
    CFURLRef soundURLRef = CFBundleCopyResourceURL(mainBundle, (CFStringRef)@"sound0" , CFSTR("wav"), nil);
    UInt32 soundID;
    AudioServicesCreateSystemSoundID(soundURLRef, &soundID);
    AudioServicesPlaySystemSound(soundID);
}

-(void)playSoundReturn{
    CFBundleRef mainBundle = CFBundleGetMainBundle();
    CFURLRef soundURLRef = CFBundleCopyResourceURL(mainBundle, (CFStringRef)@"sound1" , CFSTR("wav"), nil);
    UInt32 soundID;
    AudioServicesCreateSystemSoundID(soundURLRef, &soundID);
    AudioServicesPlaySystemSound(soundID);
}

-(void)playSoundRemove{
    CFBundleRef mainBundle = CFBundleGetMainBundle();
    CFURLRef soundURLRef = CFBundleCopyResourceURL(mainBundle, (CFStringRef)@"sound2" , CFSTR("wav"), nil);
    UInt32 soundID;
    AudioServicesCreateSystemSoundID(soundURLRef, &soundID);
    AudioServicesPlaySystemSound(soundID);
}

-(void)playSoundEnd{
    CFBundleRef mainBundle = CFBundleGetMainBundle();
    CFURLRef soundURLRef = CFBundleCopyResourceURL(mainBundle, (CFStringRef)@"sound3" , CFSTR("wav"), nil);
    UInt32 soundID;
    AudioServicesCreateSystemSoundID(soundURLRef, &soundID);
    AudioServicesPlaySystemSound(soundID);
}

#pragma mark - about display

-(void)showPiecesCanBeRemoved:(int)colour{
    int offset = 0;
    NSString *pieceHL;
    if (colour == WHITE) {
        offset = WHITE_OFFSET;
        pieceHL = @"whiteHL.png";
    }else if (colour == BLACK) {
        offset = BLACK_OFFSET;
        pieceHL = @"blackHL.png";
    }else{
        NSLog(@"unexpected colour in showPiecesCanBeRemoved:");
    }
    for (int pos=0; pos<24; pos++) {
        if ([nmm getPosition:pos] == colour && [nmm canRemovePieceAtPosition:pos]) {
            CGPoint position = [self getPositionFromNumber:pos];
            for (int pieceNo=1; pieceNo<10; pieceNo++) {
                int pieceTag = pieceNo+offset;
                UIButton *piece = (UIButton *)[self.view viewWithTag:pieceTag];
                if ([piece isEnabled] && [self pointClose:position to:piece]) {
                    [piece setImage:[UIImage imageNamed:pieceHL] forState:UIControlStateNormal];
                }
            }
        }
    }
}

-(void)showPiecesNormal:(int)colour{
    int offset = 0;
    NSString *pieceImg;
    if (colour == WHITE) {
        offset = WHITE_OFFSET;
        pieceImg = @"white.png";
    }else if (colour == BLACK) {
        offset = BLACK_OFFSET;
        pieceImg = @"black.png";
    }else{
        NSLog(@"unexpected colour in showPiecesNormal:");
    }
    for (int pos=0; pos<24; pos++) {
        if ([nmm getPosition:pos] == colour) {
            CGPoint position = [self getPositionFromNumber:pos];
            for (int pieceNo=1; pieceNo<10; pieceNo++) {
                int pieceTag = pieceNo+offset;
                UIButton *piece = (UIButton *)[self.view viewWithTag:pieceTag];
                if ([piece isEnabled] && [self pointClose:position to:piece]) {
                    [piece setImage:[UIImage imageNamed:pieceImg] forState:UIControlStateNormal];
                }
            }
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
