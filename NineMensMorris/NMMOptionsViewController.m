//
//  NMMOptionsViewController.m
//  NMM
//
//  Created by lynny on 23/08/2012.
//  Copyright (c) 2012 jy. All rights reserved.
//

#import "NMMOptionsViewController.h"

@interface NMMOptionsViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *soundSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *flyingSwitch;

@end

@implementation NMMOptionsViewController
@synthesize soundSwitch;
@synthesize flyingSwitch;

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
    
    NSString *currentSetting = [NMMSettings getCurrentSettings];
    NSLog(@"sound %c", [currentSetting characterAtIndex:0]);
    NSLog(@"fly %c", [currentSetting characterAtIndex:1]);
    
    if ([currentSetting characterAtIndex:0] == '1') {
        [soundSwitch setOn:YES];
    }else{
        [soundSwitch setOn:NO];
    }
    
    if ([currentSetting characterAtIndex:1] == '1') {
        [flyingSwitch setOn:YES];
    }else{
        [flyingSwitch setOn:NO];
    }
}

- (void)viewDidUnload
{
    [self setSoundSwitch:nil];
    [self setFlyingSwitch:nil];
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
