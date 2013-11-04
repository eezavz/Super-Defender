//
//  GameData.m
//  Super Defender
//
//  Created by Furkan on 11/3/13.
//  Copyright (c) 2013 RoFuPaNi. All rights reserved.
//

#import "GameData.h"

@implementation GameData
@synthesize gameData;

-(GameData *)init
{
    gameData = [[NSMutableDictionary alloc] init];
    NSFileManager *filemanager = [NSFileManager defaultManager];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    path = [path stringByAppendingPathComponent:@"GameData.plist"];
    if([filemanager fileExistsAtPath:path])
    {
        gameData = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
        //NSLog(@"%@", [gameData objectForKey:@"Score"]);
        //NSLog(@"%@", gameData);
    }else{
        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"GameData" ofType:@"plist"];
        gameData = [[NSMutableDictionary alloc] initWithContentsOfFile:sourcePath];
        //NSLog(@"%@", gameData);
        [self saveGame];
    }
    return self;
}

- (void)saveGame
{
    [gameData writeToFile:[self givePath] atomically:YES];
    //[self dismissViewControllerAnimated:YES completion:nil];
}

- (NSString *)givePath
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    path = [path stringByAppendingPathComponent:@"GameData.plist"];
    return path;
}

@end
