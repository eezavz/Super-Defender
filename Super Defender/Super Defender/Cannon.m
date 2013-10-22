//
//  Cannon.m
//  Super Defender
//
//  Created by Furkan on 10/14/13.
//  Copyright (c) 2013 RoFuPaNi. All rights reserved.
//

#import "Cannon.h"
#import "Projectile.h"
#define degrees(x) (M_PI * (x) / 180)
@implementation Cannon

@synthesize aimspeed;
@synthesize rateOfFire;
@synthesize angle;
@synthesize image;
@synthesize shotProjectiles;

- (Cannon *)init
{
    shotProjectiles = [[NSMutableArray alloc] init];
    return [super init];
}

-(void)update:(float) angle2
{
    static int countdown = 30;
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
        Projectile *new = [[Projectile alloc] initWithX:160+spawnX Y:480+spawnY Width:20 Height:17];
        new.velX = -cos(degrees(angle))*2;
        new.velY = -sin(degrees(angle))*2;
        [shotProjectiles addObject:new];
        countdown = 30;
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

@end
