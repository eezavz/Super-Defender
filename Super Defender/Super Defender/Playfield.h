//
//  Playfield.h
//  Super Defender
//
//  Created by Furkan on 10/14/13.
//  Copyright (c) 2013 RoFuPaNi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cannon.h"

@interface Playfield : NSObject

@property (nonatomic, assign) int progress;
@property (nonatomic, assign) int score;
@property (nonatomic, assign) int health;
@property (nonatomic, assign) int enemyCountdown;
@property (nonatomic, retain) Cannon *cannon;
@property (nonatomic, retain) NSMutableArray *enemies;
@property (nonatomic, retain) NSMutableArray *projectiles;

-(void)update:(float)angle;

@end
