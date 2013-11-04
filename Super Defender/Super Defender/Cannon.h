//
//  Cannon.h
//  Super Defender
//
//  Created by Furkan on 10/14/13.
//  Copyright (c) 2013 RoFuPaNi. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <math.h>

@interface Cannon : NSObject

@property (nonatomic, assign) int aimspeed;
@property (nonatomic, assign) int rateOfFire;
@property (nonatomic, assign) float angle;
@property (nonatomic, strong) NSMutableArray *shotProjectiles;
@property (nonatomic, assign) int maxHealth;
@property (nonatomic, assign) int health;
@property (nonatomic, assign) int posX;
@property (nonatomic, assign) int posY;
@property (nonatomic, assign) int width;
@property (nonatomic, assign) int height;
@property (nonatomic, assign) int specialProjectile;
@property (nonatomic, assign) int specialAmount;
@property (nonatomic, assign) int endBurstSpecialAmount;


-(void)update:(float) angle2;
-(void)gainHealth:(int) par_health;
-(void)setSpecialAmounts : (int)par_specialAmount;

@end
