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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
	}
	return self;
}

- (IBAction)startPressed:(UIButton *)sender {
	NSString *nibName;
	if (IS_IPAD) {
		nibName = @"NMMViewController";
	}
	else {
		nibName = @"NMMVC_iPhone";
	}
	NMMViewController *controller  = [[NMMViewController alloc] initWithNibName:nibName bundle:nil];
	[self presentViewController:controller animated:YES completion:nil];
}

- (IBAction)optionsPredded:(UIButton *)sender {
	NSString *nibName;
	if (IS_IPAD) {
		nibName = @"NMMOptionsViewController";
	}
	else {
		nibName = @"NMMOptionsVC_iPhone";
	}
	NMMOptionsViewController *controller = [[NMMOptionsViewController alloc] initWithNibName:nibName bundle:nil];
	[self presentViewController:controller animated:YES completion:nil];
}

- (IBAction)infoPressed:(UIButton *)sender {
	NSString *nibName;
	if (IS_IPAD) {
		nibName = @"NMMInfoViewController";
	}
	else {
		nibName = @"NMMInfoVC_iPhone";
	}
	NMMInfoViewController *controller = [[NMMInfoViewController alloc] initWithNibName:nibName bundle:nil];
	[self presentViewController:controller animated:YES completion:nil];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view from its nib.

	[_startButton applyButtonStyle];
	[_optionsButton applyButtonStyle];
	[_infoButton applyButtonStyle];

	NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
	[standardDefaults registerDefaults:@{ SETTING_FLY: @NO, SETTING_SOUND:@YES }];
	[standardDefaults synchronize];
}

- (void)viewDidUnload {
	[self setStartButton:nil];
	[self setOptionsButton:nil];
	[self setInfoButton:nil];
	[super viewDidUnload];
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return autorotateSetting;
}

@end
