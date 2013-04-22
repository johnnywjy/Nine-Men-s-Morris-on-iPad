//
//  ModalViewDelegate.h
//  NineMensMorris
//
//  Created by jy on 13-4-22.
//  Copyright (c) 2013年 UoL. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ModalViewDelegate <NSObject>

- (void) dismissViewController: (UIViewController *) childViewController;

@end
