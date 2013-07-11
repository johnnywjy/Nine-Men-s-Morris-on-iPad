//
//  NMMSettings.h
//  NineMensMorris
//
//  Created by lynny on 25/08/2012.
//  Copyright (c) 2012 UoL. All rights reserved.
//

#import <Foundation/Foundation.h>
#define autorotateSetting (interfaceOrientation == UIInterfaceOrientationPortrait)
#define autorotateEnabled NO

#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define MIN_DISTANCE 40.0f
#define WHITE_OFFSET 1000
#define BLACK_OFFSET 2000
#define ANIMATION_DURATION 0.3f

#define SOUND_DROP (@"sound0")
#define SOUND_RETURN (@"sound1")
#define SOUND_REMOVE (@"sound2")
#define SOUND_END (@"sound3")

#define SOUND_MUTE 0 
#define SOUND_ENABLED 1


#define SETTING_SOUND @"sound"
#define SETTING_FLY @"canFly"

@interface NMMSettings : NSObject

@end
