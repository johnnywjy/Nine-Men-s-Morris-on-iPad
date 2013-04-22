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
#import "ModalViewDelegate.h"

@interface NMMOptionsViewController : UIViewController

@property (nonatomic, weak) id <ModalViewDelegate> delegate;

@end
