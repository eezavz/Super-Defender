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
@property (atomic, assign) int projectileCountdown;
@property (atomic, retain) UIImage *projectileImage;

-(void)update:(float)angle;
- (int) distanceFromPoint:(int)p2x : (int)p2y : (int)p1x : (int)p1y;
- (void) collisionDetect;
- (void) updateProjectiles : (float)angle;

@end
