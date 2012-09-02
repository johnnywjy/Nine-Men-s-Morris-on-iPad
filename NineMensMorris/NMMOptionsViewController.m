//
//  NMMOptionsViewController.m
//  NMM
//
//  Created by lynny on 23/08/2012.
//  Copyright (c) 2012 jy. All rights reserved.
//

#import "NMMOptionsViewController.h"

@interface NMMOptionsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *soundLabel;
@property (weak, nonatomic) IBOutlet UISwitch *soundSwitch;
@property (weak, nonatomic) IBOutlet UILabel *flyingLabel;
@property (weak, nonatomic) IBOutlet UISwitch *flyingSwitch;
@property (weak, nonatomic) IBOutlet UIButton *returnButton;

@end

@implementation NMMOptionsViewController
@synthesize soundLabel = _soundLabel;
@synthesize soundSwitch = _soundSwitch;
@synthesize flyingLabel = _flyingLabel;
@synthesize flyingSwitch = _flyingSwitch;
@synthesize returnButton = _returnButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)returnPressed:(UIButton *)sender {
    [self.delegate nmmOptionsViewControllerDidCancel:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [_soundLabel applyLabelStyleDefault];
    [_flyingLabel applyLabelStyleDefault];
    [_returnButton applyButtonStyle];
    
    NSString *currentSetting = [NMMSettings getCurrentSettings];
    NSLog(@"sound %c", [currentSetting characterAtIndex:0]);
    NSLog(@"fly %c", [currentSetting characterAtIndex:1]);
    
    if ([currentSetting characterAtIndex:0] == '1') {
        [_soundSwitch setOn:YES];
    }else{
        [_soundSwitch setOn:NO];
    }
    
    if ([currentSetting characterAtIndex:1] == '1') {
        [_flyingSwitch setOn:YES];
    }else{
        [_flyingSwitch setOn:NO];
    }
}

- (void)viewDidUnload
{
    [self setSoundSwitch:nil];
    [self setFlyingSwitch:nil];
    [self setSoundLabel:nil];
    [self setFlyingLabel:nil];
    [self setReturnButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

-(IBAction)soundSwitch:(UISwitch *)sender
{
    NSString *currentSetting = [NMMSettings getCurrentSettings];
    char fly = [currentSetting characterAtIndex:1];
    
    if ([sender isOn]) {
        NSLog(@"Sound Switch ON");
        NSString *newSetting = [NSString stringWithFormat:@"1%c",fly];
        NSLog(@"new setting: %@", newSetting);
        [NMMSettings writeSettingsWithContent:newSetting];
    } else {
        NSLog(@"Sound Switch OFF");
        NSString *newSetting = [NSString stringWithFormat:@"0%c",fly];
        NSLog(@"new setting: %@", newSetting);
        [NMMSettings writeSettingsWithContent:newSetting];
    }
}

-(IBAction)flyingSwitch:(UISwitch *)sender
{
    NSString *currentSetting = [NMMSettings getCurrentSettings];
    char sound = [currentSetting characterAtIndex:0];
    
    if ([sender isOn]) {
        NSLog(@"Flying Switch ON");
        NSString *newSetting = [NSString stringWithFormat:@"%c1",sound];
        NSLog(@"new setting: %@", newSetting);
        [NMMSettings writeSettingsWithContent:newSetting];
    } else {
        NSLog(@"Flying Switch OFF");
        NSString *newSetting = [NSString stringWithFormat:@"%c0",sound];
        NSLog(@"new setting: %@", newSetting);
        [NMMSettings writeSettingsWithContent:newSetting];
    }
}

@end
