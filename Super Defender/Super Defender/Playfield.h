//
//  Playfield.h
//  Super Defender
//
//  Created by Furkan on 10/14/13.
//  Copyright (c) 2013 RoFuPaNi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cannon.h"
#import "Enemy.h"
#import "Projectile.h"

@interface Playfield : NSObject

@property (nonatomic, assign) int progress;
@property (nonatomic, assign) int score;
@property (nonatomic, assign) int health;
@property (nonatomic, assign) int enemyCountdown;
@property (nonatomic, retain) Cannon *cannon;
@property (nonatomic, retain) NSMutableArray *enemies;
@property (nonatomic, retain) NSMutableArray *enemyProjectiles;
@property (nonatomic, retain) NSMutableArray *objects;
@property (nonatomic, retain) NSMutableDictionary *leveldata;
//@property (nonatomic, retain) NSMutableDictionary *gameData;

- (Playfield *)init : (int)maxHealth : (int)FireRate : (int)MoveSpeed : (int)Power : (int)RotSpeed;
-(void)update:(float)angle;

@end
