//
//  GameData.h
//  Super Defender
//
//  Created by Furkan on 11/3/13.
//  Copyright (c) 2013 RoFuPaNi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameData : NSObject

@property (nonatomic, strong) NSMutableDictionary* gameData;

- (void)saveGame;

@end
