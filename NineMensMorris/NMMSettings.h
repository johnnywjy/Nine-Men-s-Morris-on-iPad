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

@interface NMMSettings : NSObject

+(NSString *)getCurrentSettings;
+(void)writeSettingsWithContent:(NSString *)content;

@end
