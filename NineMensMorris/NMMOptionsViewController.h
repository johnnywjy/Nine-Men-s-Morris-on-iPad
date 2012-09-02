//
//  NMMOptionsViewController.h
//  NMM
//
//  Created by lynny on 23/08/2012.
//  Copyright (c) 2012 jy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NMMSettings.h"
#import "UILabel+NMMAdditions.h"
#import "UIButton+NMMAdditions.h"

@class NMMOptionsViewController;

@protocol NMMOptionsViewControllerDelegate <NSObject>

- (void)nmmOptionsViewControllerDidCancel:(NMMOptionsViewController *)controller;

@end

@interface NMMOptionsViewController : UIViewController

@property (nonatomic, weak) id <NMMOptionsViewControllerDelegate> delegate;

@end
