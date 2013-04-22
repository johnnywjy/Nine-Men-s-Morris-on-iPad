//
//  NMMInfoViewController.m
//  NMM
//
//  Created by lynny on 23/08/2012.
//  Copyright (c) 2012 jy. All rights reserved.
//

#import "NMMInfoViewController.h"

@interface NMMInfoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *introLabel;
@property (weak, nonatomic) IBOutlet UITextView *introText;
@property (weak, nonatomic) IBOutlet UILabel *ruleLabel;
@property (weak, nonatomic) IBOutlet UITextView *ruleText;
@property (weak, nonatomic) IBOutlet UIButton *returnButton;

@end

@implementation NMMInfoViewController
@synthesize introLabel = _introLabel;
@synthesize introText = _introText;
@synthesize ruleLabel = _ruleLabel;
@synthesize ruleText = _ruleText;
@synthesize returnButton = _returnButton;
@synthesize delegate = _delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)returnPressed:(UIButton *)sender {
    [self.delegate dismissViewController:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_introLabel applyLabelStyleDefault];
    [_introText applyTextViewStyle];
    [_ruleLabel applyLabelStyleDefault];
    [_ruleText applyTextViewStyle];
    [_returnButton applyButtonStyle];
}

- (void)viewDidUnload
{
    [self setReturnButton:nil];
    [self setRuleLabel:nil];
    [self setRuleText:nil];
    [self setIntroLabel:nil];
    [self setIntroText:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return autorotateSetting;
}

@end
