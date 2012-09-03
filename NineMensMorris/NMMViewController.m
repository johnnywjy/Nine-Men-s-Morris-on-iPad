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

@interface NMMViewController (){
    CGPoint originalCenter;
    UIButton *currentPiece;
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
}

@property (weak, nonatomic) IBOutlet UILabel *p1label;
@property (weak, nonatomic) IBOutlet UILabel *p2label;
@property (weak, nonatomic) IBOutlet UILabel *p1msg;
@property (weak, nonatomic) IBOutlet UILabel *p2msg;
@property (weak, nonatomic) IBOutlet UIButton *returnButton;

@property (weak, nonatomic) IBOutlet UIButton *w1;
@property (weak, nonatomic) IBOutlet UIButton *w2;
@property (weak, nonatomic) IBOutlet UIButton *w3;
@property (weak, nonatomic) IBOutlet UIButton *w4;
@property (weak, nonatomic) IBOutlet UIButton *w5;
@property (weak, nonatomic) IBOutlet UIButton *w6;
@property (weak, nonatomic) IBOutlet UIButton *w7;
@property (weak, nonatomic) IBOutlet UIButton *w8;
@property (weak, nonatomic) IBOutlet UIButton *w9;

@property (weak, nonatomic) IBOutlet UIButton *b1;
@property (weak, nonatomic) IBOutlet UIButton *b2;
@property (weak, nonatomic) IBOutlet UIButton *b3;
@property (weak, nonatomic) IBOutlet UIButton *b4;
@property (weak, nonatomic) IBOutlet UIButton *b5;
@property (weak, nonatomic) IBOutlet UIButton *b6;
@property (weak, nonatomic) IBOutlet UIButton *b7;
@property (weak, nonatomic) IBOutlet UIButton *b8;
@property (weak, nonatomic) IBOutlet UIButton *b9;

@property (weak, nonatomic) IBOutlet UIButton *pos0;
@property (weak, nonatomic) IBOutlet UIButton *pos1;
@property (weak, nonatomic) IBOutlet UIButton *pos2;
@property (weak, nonatomic) IBOutlet UIButton *pos3;
@property (weak, nonatomic) IBOutlet UIButton *pos4;
@property (weak, nonatomic) IBOutlet UIButton *pos5;
@property (weak, nonatomic) IBOutlet UIButton *pos6;
@property (weak, nonatomic) IBOutlet UIButton *pos7;
@property (weak, nonatomic) IBOutlet UIButton *pos8;
@property (weak, nonatomic) IBOutlet UIButton *pos9;
@property (weak, nonatomic) IBOutlet UIButton *pos10;
@property (weak, nonatomic) IBOutlet UIButton *pos11;
@property (weak, nonatomic) IBOutlet UIButton *pos12;
@property (weak, nonatomic) IBOutlet UIButton *pos13;
@property (weak, nonatomic) IBOutlet UIButton *pos14;
@property (weak, nonatomic) IBOutlet UIButton *pos15;
@property (weak, nonatomic) IBOutlet UIButton *pos16;
@property (weak, nonatomic) IBOutlet UIButton *pos17;
@property (weak, nonatomic) IBOutlet UIButton *pos18;
@property (weak, nonatomic) IBOutlet UIButton *pos19;
@property (weak, nonatomic) IBOutlet UIButton *pos20;
@property (weak, nonatomic) IBOutlet UIButton *pos21;
@property (weak, nonatomic) IBOutlet UIButton *pos22;
@property (weak, nonatomic) IBOutlet UIButton *pos23;

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
    NSLog(@"viewDidLoad");
	[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:@"UIDeviceOrientationDidChangeNotification" object:nil];
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

-(IBAction)pieceTouch:(UIButton *)sender{
    originalCenter = sender.center;
    if (nmm.phase == MOVING) {
        moveStartPosition = [self getPiecePosition:sender];
        NSLog(@"move piece from %d...", moveStartPosition);
    }
}

-(IBAction)pieceMove:(UIButton *)sender withEvent:(UIEvent *) event{
    if (nmm.phase != REMOVING && nmm.phase != ENDING) {
        CGPoint point = [[[event allTouches]anyObject] locationInView:self.view];
        //[button setImage:[UIImage imageNamed: @"blackHL.png"] forState:UIControlStateNormal];
        sender.center = point;
    }
}

-(IBAction)pieceTouchUpInside:(UIButton *)sender{
    int pos = [self getPiecePosition:sender];
    if (pos == -1) {
        [self moveBack:sender];
        return;
    }
    
    switch (nmm.phase) {
        case PLACING:
            //can't move pieces in board
            for (int i = 1 ; i<25; i++) {
                UIButton * b = (UIButton *)[self.view viewWithTag:i];
                if ([self pointClose:originalCenter to:b]) {
                    [self moveBack:sender];
                    return;
                }
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
                        [self removePieceAnimated:sender];
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
                        [self removePieceAnimated:sender];
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

-(void)moveBack:(UIButton *)piece{
    [UIView animateWithDuration:0.2f
                     animations:^{piece.center = originalCenter;
                     }
     ];
    if (soundEnabled) {
        [self playSoundReturn];
    }
}

-(BOOL)isWhite:(UIButton *)piece{
    if (piece.tag<2000) {
        return YES;
    }
    return NO;
}

-(IBAction)touchUpOutside:(UIButton *)sender{
    NSLog(@"touchUpOutside");
    [self moveBack:sender];
}

- (IBAction)returnPressed:(UIButton *)sender {
    [self.delegate nmmViewControllerDidCancel:self];
}

-(int)getPiecePosition:(UIButton *)piece{
    int pos = -1;
    for (int i = 1; i<25; i++) {
        UIButton * b = (UIButton *)[self.view viewWithTag:i];
        if ([self isClose:piece to:b]) {
            pos = i-1;
            break;
        }
    }
    return pos;
}

-(void)dropPieceAnimated:(UIButton *)piece atPosition:(int)pos{
    [UIView animateWithDuration:0.3f
                     animations:^{
                         UIButton *p = (UIButton *)[self.view viewWithTag:pos+1]; // tag is pos +1
                         piece.center = p.center;
                         if (soundEnabled) {
                             [self playSoundPieceDrop];
                         }
                     }
                     completion:^(BOOL finished){
                         NSLog(@"place dropped at position %d", pos);
                     }
     ];
}

-(void)removePieceAnimated:(UIButton *)sender{//TODO animation
    [sender setImage:nil forState:UIControlStateNormal];
    [sender setEnabled:NO];
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

-(void)playSoundEnd{
    CFBundleRef mainBundle = CFBundleGetMainBundle();
    CFURLRef soundURLRef = CFBundleCopyResourceURL(mainBundle, (CFStringRef)@"sound3" , CFSTR("wav"), nil);
    UInt32 soundID;
    AudioServicesCreateSystemSoundID(soundURLRef, &soundID);
    AudioServicesPlaySystemSound(soundID);
}


-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)orientation duration:(NSTimeInterval)duration {
    [super willAnimateRotationToInterfaceOrientation:orientation duration:duration];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


-(void)showPiecesCanBeRemoved:(int)colour{
    int offset = 0;
    NSString *pieceHL;
    if (colour == WHITE) {
        offset = 1000;
        pieceHL = @"whiteHL.png";
    }else if (colour == BLACK) {
        offset = 2000;
        pieceHL = @"blackHL.png";
    }else{
        NSLog(@"unexpected colour in showPiecesCanBeRemoved:");
    }
    for (int pos=0; pos<24; pos++) {
        if ([nmm getPosition:pos] == colour && [nmm canRemovePieceAtPosition:pos]) {
            CGPoint posCenter = ((UIButton *)[self.view viewWithTag:pos+1]).center;
            for (int pieceNo=1; pieceNo<10; pieceNo++) {
                int pieceTag = pieceNo+offset;
                UIButton *piece = (UIButton *)[self.view viewWithTag:pieceTag];
                if ([piece isEnabled] && [self pointClose:posCenter to:piece]) {
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
        offset = 1000;
        pieceImg = @"white.png";
    }else if (colour == BLACK) {
        offset = 2000;
        pieceImg = @"black.png";
    }else{
        NSLog(@"unexpected colour in showPiecesNormal:");
    }
    for (int pos=0; pos<24; pos++) {
        if ([nmm getPosition:pos] == colour) {
            CGPoint posCenter = ((UIButton *)[self.view viewWithTag:pos+1]).center;
            for (int pieceNo=1; pieceNo<10; pieceNo++) {
                int pieceTag = pieceNo+offset;
                UIButton *piece = (UIButton *)[self.view viewWithTag:pieceTag];
                if ([piece isEnabled] && [self pointClose:posCenter to:piece]) {
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


@end
