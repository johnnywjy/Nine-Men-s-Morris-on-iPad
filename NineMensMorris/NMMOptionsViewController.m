//
//  NMMOptionsViewController.m
//  NMM
//
//  Created by johnny on 23/08/2012.
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [_soundLabel applyLabelStyleDefault];
    [_flyingLabel applyLabelStyleDefault];
    [_returnButton applyButtonStyle];
    
    bool sound  = [[NSUserDefaults standardUserDefaults] boolForKey:SETTING_SOUND];
    bool canFly = [[NSUserDefaults standardUserDefaults] boolForKey:SETTING_FLY];

    NSLog(@"sound %d", sound);
    NSLog(@"fly %d", canFly);
    
    if (sound) {
        [_soundSwitch setOn:YES];
    }else{
        [_soundSwitch setOn:NO];
    }
    
    if (canFly) {
        [_flyingSwitch setOn:YES];
    }else{
        [_flyingSwitch setOn:NO];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return autorotateSetting;
}

- (IBAction)returnPressed:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)soundSwitch:(UISwitch *)sender
{
    if ([sender isOn]) {
        NSLog(@"Sound Switch ON");
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:SETTING_SOUND];
    } else {
        NSLog(@"Sound Switch OFF");
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:SETTING_SOUND];
    }
}

-(IBAction)flyingSwitch:(UISwitch *)sender
{
    if ([sender isOn]) {
        NSLog(@"Flying Switch ON");
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:SETTING_FLY];
    } else {
        NSLog(@"Flying Switch OFF");
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:SETTING_FLY];
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
}

@end
