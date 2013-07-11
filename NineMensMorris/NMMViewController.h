

#import <UIKit/UIKit.h>
#import "NMM.h"
#import <AudioToolbox/AudioToolbox.h>
#import "NMMSettings.h"
#import "UIButton+NMMAdditions.h"
#import "UILabel+NMMAdditions.h"
#import "NMMPiece.h"
#import "NMMPosition.h"


@interface NMMViewController : UIViewController
{
    NMM *nmm;
}

@property (strong, nonatomic) IBOutlet UIView *portraitView;
@property (strong, nonatomic) IBOutlet UIView *landscapeView;
@end
