//
//  Cannon.m
//  Super Defender
//
//  Created by Furkan on 10/14/13.
//  Copyright (c) 2013 RoFuPaNi. All rights reserved.
//

#import "Cannon.h"
#import "Projectile.h"
#import "Projectile1.h"
#define degrees(x) (M_PI * (x) / 180)
@implementation Cannon

@synthesize aimspeed;
@synthesize rateOfFire;
@synthesize angle;
@synthesize shotProjectiles;
@synthesize health;
@synthesize maxHealth;

- (Cannon *)init
{
    maxHealth = 100;
    health = maxHealth;
    shotProjectiles = [[NSMutableArray alloc] init];
    return [super init];
}

-(void)update:(float) angle2
{
    static int countdown = 15;
    if (angle2 > 45 && angle2 < 135) {
        angle = angle2;
    } else {
        if (angle2 < 45) {
            angle = 45;
        } else {
            angle = 135;
        }
    }
    if(countdown <= 0) {
        int spawnX = -cos(degrees(angle)) * 108;
        int spawnY = -sin(degrees(angle)) * 108;
        Projectile1 *new = [[Projectile1 alloc] initWithX:160+spawnX Y:430+spawnY Angle:angle];
        [shotProjectiles addObject:new];
        countdown = 15;
    } else {
        countdown--;
    }
    for (int i = 0; i < shotProjectiles.count; i++) {
        [[shotProjectiles objectAtIndex:i] update];
        if([[shotProjectiles objectAtIndex:i] shouldDie]) {
            Projectile *old = [shotProjectiles objectAtIndex:i];
            [shotProjectiles removeObject:old];
            [old dealloc];
            i--;
        }
    }
}

- (void) dealloc
{
    NSLog(@"Cannon dealloc");
    [self.shotProjectiles dealloc];
    [super dealloc];
}

@end
