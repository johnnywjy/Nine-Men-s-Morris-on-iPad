//
//  NMMStartViewController.m
//  NMM
//
//  Created by lynny on 23/08/2012.
//  Copyright (c) 2012 jy. All rights reserved.
//

#import "NMMStartViewController.h"

@interface NMMStartViewController ()
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *optionsButton;
@property (weak, nonatomic) IBOutlet UIButton *infoButton;

@end

@implementation NMMStartViewController
@synthesize startButton;
@synthesize optionsButton;
@synthesize infoButton;

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
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion:nil];
}
- (IBAction)optionsPredded:(UIButton *)sender {
    NMMOptionsViewController *controller = [[NMMOptionsViewController alloc] initWithNibName:@"NMMOptionsViewController" bundle:nil];
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion:nil];

}

- (IBAction)infoPressed:(UIButton *)sender {
    NMMInfoViewController *controller = [[NMMInfoViewController alloc] initWithNibName:@"NMMInfoViewController" bundle:nil];
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion:nil];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.startButton nmmApplyButtonStyle];
    [self.optionsButton nmmApplyButtonStyle];
    [self.infoButton nmmApplyButtonStyle];
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
	return YES;
}

#pragma mark - NMMViewControllerDelegate

- (void)nmmViewControllerDidCancel:(NMMViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)nmmOptionsViewControllerDidCancel:(NMMOptionsViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)nmmInfoViewControllerDidCancel:(NMMInfoViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
