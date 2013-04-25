//
//  NMMSettings.m
//  NineMensMorris
//
//  Created by lynny on 25/08/2012.
//  Copyright (c) 2012 UoL. All rights reserved.
//

#import "NMMSettings.h"

@implementation NMMSettings

+(NSString *)getSettingsPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = paths[0];
    NSString *path = [documentsDirectory stringByAppendingString:@"/settings"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]){
        NSLog(@"settings file not exist!");
        NSString *initSettings = @"10";
        [initSettings writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }
    NSLog(@"path is %@",path);
    return path;
}

+(void)writeSettingsFileWithString:(NSString *)setting andPath:(NSString *)path{
    [setting writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

+(NSString *)getCurrentSettingsAtPath:(NSString *)path{
    return [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
}

+(NSString *)getCurrentSettings{
    NSString *path = [self getSettingsPath];
    return [self getCurrentSettingsAtPath:path];
}

+(void)writeSettingsWithContent:(NSString *)content{
    NSString *path = [self getSettingsPath];
    [content writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

@end
