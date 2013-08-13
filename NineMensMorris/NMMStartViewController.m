//
//  NMMStartViewController.m
//  NMM
//
//  Created by johnny on 23/08/2012.
//  Copyright (c) 2012 jy. All rights reserved.
//

#import "NMMStartViewController.h"

@interface NMMStartViewController ()
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *optionsButton;
@property (weak, nonatomic) IBOutlet UIButton *infoButton;

@end

@implementation NMMStartViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)startPressed:(UIButton *)sender
{
    NMMViewController *controller = [[NMMViewController alloc] initWithNibName:@"NMMViewController" bundle:nil];
    [self presentViewController:controller animated:YES completion:nil];
}


- (IBAction)optionsPredded:(UIButton *)sender {
    NMMOptionsViewController *controller = [[NMMOptionsViewController alloc] initWithNibName:@"NMMOptionsViewController" bundle:nil];
    [self presentViewController:controller animated:YES completion:nil];

}

- (IBAction)infoPressed:(UIButton *)sender {
    NMMInfoViewController *controller = [[NMMInfoViewController alloc] initWithNibName:@"NMMInfoViewController" bundle:nil];
    [self presentViewController:controller animated:YES completion:nil];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [_startButton applyButtonStyle];
    [_optionsButton applyButtonStyle];
    [_infoButton applyButtonStyle];
    
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    [standardDefaults registerDefaults:@{SETTING_FLY: @NO, SETTING_SOUND:@YES}];
    [standardDefaults synchronize];
}

- (void)viewDidUnload
{
    [self setStartButton:nil];
    [self setOptionsButton:nil];
    [self setInfoButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return autorotateSetting;
}

@end
