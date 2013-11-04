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
    }else{
        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"GameData" ofType:@"plist"];
        gameData = [[NSMutableDictionary alloc] initWithContentsOfFile:sourcePath];
        [self saveGame];
    }
    return self;
}

- (void)saveGame
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    path = [path stringByAppendingPathComponent:@"GameData.plist"];
    [gameData writeToFile:path atomically:YES];
}

- (void) dealloc
{
    NSLog(@"GameData dealloc");
    [gameData dealloc];
    [super dealloc];
}

@end
