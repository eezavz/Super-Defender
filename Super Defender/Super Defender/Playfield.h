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

-(void)update:(float)angle;
-(BOOL)checkHitEnemy: (Enemy *) enemy Projectile:(Projectile *) projectile;

@end
