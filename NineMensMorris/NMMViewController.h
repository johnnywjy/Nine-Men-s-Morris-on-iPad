

#import <UIKit/UIKit.h>
#import "NMM.h"
#import <AudioToolbox/AudioToolbox.h>
#import "NMMSettings.h"
#import "UIButton+NMMAdditions.h"
#import "UILabel+NMMAdditions.h"

@class NMMViewController;

@protocol NMMViewControllerDelegate <NSObject>

- (void)nmmViewControllerDidCancel:(NMMViewController *)controller;

@end


@interface NMMViewController : UIViewController
{
    NMM *nmm;
}

@property (nonatomic, weak) id <NMMViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIView *portraitView;
@property (strong, nonatomic) IBOutlet UIView *landscapeView;
@end
