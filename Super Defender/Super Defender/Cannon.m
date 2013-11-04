//
//  Cannon.m
//  Super Defender
//
//  Created by Furkan on 10/14/13.
//  Copyright (c) 2013 RoFuPaNi. All rights reserved.
//

#import "Cannon.h"
#import "Projectile.h"
#import "DefaultProjectile.h"
#import "PowerProjectile.h"
#import "FrequentProjectile.h"
#import "LightningProjectile.h"
#import "UnstoppableProjectile.h"
#import "DarkMatterProjectile.h"
#define degrees(x) (M_PI * (x) / 180)
@implementation Cannon

@synthesize aimspeed;
@synthesize rateOfFire;
@synthesize angle;
@synthesize shotProjectiles;
@synthesize health;
@synthesize maxHealth;
@synthesize specialProjectile;
@synthesize specialAmount;
@synthesize firePower;
@synthesize strength;

- (Cannon *)init : (int)par_maxHealth : (int)par_FireRate : (int)par_MoveSpeed : (int)par_Power : (int)par_RotSpeed
{
    par_maxHealth++;
    maxHealth = 100 * par_maxHealth;
    health = maxHealth;
    rateOfFire = par_FireRate+1;
    firePower = par_MoveSpeed+8;
    strength = par_Power+1;
    aimspeed = par_RotSpeed+1;
    shotProjectiles = [[NSMutableArray alloc] init];
    angle = 90;
    return [super init];
}

-(void)gainHealth:(int) par_health
{
    if(health < maxHealth)
    {
        health += par_health;
    }
}

-(void)setHealth:(int)par_health
{
    if(par_health >= 0)
    {
        health = par_health;
    } else {
        health = 0;
    }
}

-(void)update:(float) angle2
{
    static int countdown = 0;
    if (angle2 > angle) {
        if (angle + aimspeed > angle2) {
            angle = angle2;
        } else {
            angle += aimspeed;
        }
    } else {
        if (angle - aimspeed < angle2) {
            angle = angle2;
        } else {
            angle -= aimspeed;
        }
    }
    
    if (angle < 45) {
        angle = 45;
    } else if (angle > 135) {
        angle = 135;
    }
    
    if(countdown <= 0) {
        int spawnX = -cos(degrees(angle)) * 108;
        int spawnY = -sin(degrees(angle)) * 108;
        switch (specialProjectile) {
            case 1:
            {
                Projectile *new = [[PowerProjectile alloc] initWithX:160+spawnX Y:430+spawnY Angle:angle];
                [shotProjectiles addObject:new];
                if(rateOfFire / 2 == 0)
                {
                    countdown = 30;
                }else{
                    countdown = 30 / (rateOfFire / 2);
                }
            }
                break;
            case 2:
            {
                Projectile *new = [[FrequentProjectile alloc] initWithX:160+spawnX Y:430+spawnY Angle:angle];
                [shotProjectiles addObject:new];
                countdown = 3;
            }
                break;
            case 3:
            {
                Projectile *new = [[LightningProjectile alloc] initWithX:160+spawnX Y:430+spawnY Angle:angle];
                [shotProjectiles addObject:new];
                countdown = 15;
            }
                break;
            case 4:
            {
                Projectile *new = [[UnstoppableProjectile alloc] initWithX:160+spawnX Y:430+spawnY Angle:angle];
                [shotProjectiles addObject:new];
                countdown = 30;
            }
                break;
            case 5:
            {
                Projectile *new = [[DarkMatterProjectile alloc] initWithX:160+spawnX Y:430+spawnY Angle:angle];
                [shotProjectiles addObject:new];
                countdown = 300;
            }
                break;
                
            default:
            {
                Projectile *new = [[DefaultProjectile alloc] initWithX:160+spawnX Y:430+spawnY Angle:angle Speed:firePower Power:strength];
                [shotProjectiles addObject:new];
                countdown = 30 / rateOfFire;
            }
                break;
        }
        if (specialAmount > 0) {
            specialAmount--;
            if (specialAmount == 0) {
                specialProjectile = 0;
            }
        }
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
