//
//  NMMInfoViewController.h
//  NMM
//
//  Created by lynny on 23/08/2012.
//  Copyright (c) 2012 jy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+NMMAdditions.h"
#import "UILabel+NMMAdditions.h"
#import "UITextView+NMMAdditions.h"

@class NMMInfoViewController;

@protocol NMMInfoViewControllerDelegate <NSObject>

-(void) nmmInfoViewControllerDidCancel:(NMMInfoViewController *)controller;

@end

@interface NMMInfoViewController : UIViewController

@property (nonatomic, weak) id <NMMInfoViewControllerDelegate> delegate;
@end
