//
//  Enemy.h
//  Super Defender
//
//  Created by Furkan on 10/14/13.
//  Copyright (c) 2013 RoFuPaNi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EnemyProjectile.h"

@interface Enemy : NSObject
@property (nonatomic, assign) float speed;
@property (nonatomic, assign) int maxHealth;
@property (nonatomic, assign) int health;
@property (nonatomic, assign) BOOL shouldDie;
@property (nonatomic, assign) float centerX;
@property (nonatomic, assign) float centerY;
@property (nonatomic, assign) float angle;
@property (nonatomic, assign) int width;
@property (nonatomic, assign) int height;
@property (nonatomic, assign) BOOL collides;
@property (nonatomic, assign) int score;
@property (nonatomic, strong) EnemyProjectile *myProjectile;
@property (nonatomic, assign) float yLimit;
@property (nonatomic, assign) float lowerXLimit;
@property (nonatomic, assign) float higherXLimit;
@property (nonatomic, assign) BOOL sideways;
@property (nonatomic, assign) BOOL rotatesLeft;
@property (nonatomic, assign) int countdown;
@property (nonatomic, assign) BOOL movesLeft;


- (Enemy *) initWithX:(float)x Y:(float) y;
- (void) AI;
- (void) damageAmount:(int) damage;

@end
