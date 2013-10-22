//
//  Playfield.m
//  Super Defender
//
//  Created by Furkan on 10/14/13.
//  Copyright (c) 2013 RoFuPaNi. All rights reserved.
//

#import "Playfield.h"
#import "Enemy1.h"
#define degrees(x) (M_PI * (x) / 180)

@implementation Playfield

@synthesize progress;
@synthesize score;
@synthesize health;
@synthesize enemyCountdown;
@synthesize cannon;
@synthesize enemies;
@synthesize projectiles;

- (Playfield *)init
{
    self.cannon = [[Cannon alloc]init];
    enemies = [[NSMutableArray alloc] init];
    return [super init];
}

-(void)update:(float)angle;
{
    [self.cannon update:angle];
    
    if(enemyCountdown == 0) {
        int random = arc4random() % 100;
        enemyCountdown = random;
        Enemy1 *lwut = [[Enemy1 alloc] initWithX: arc4random() % (320-64)+32 Y:-17];
        [self.enemies addObject:lwut];
    } else {
        enemyCountdown--;
    }
    for (int i = 0; i < enemies.count; i++) {
        [[enemies objectAtIndex:i] AI];
        if([[enemies objectAtIndex:i] shouldDie])
        {
            Enemy *temp = [enemies objectAtIndex:i];
            [enemies removeObject:temp];
            [temp dealloc];
            i--;
        }
    }
    for (int i = 0; i < enemies.count; i++) {
        for (int j = 0; j < cannon.shotProjectiles.count; j++) {
            if([self checkHitEnemy:[enemies objectAtIndex:i] Projectile:[self.cannon.shotProjectiles objectAtIndex:j]]) {
                Enemy *eHit = [enemies objectAtIndex:i];
                [enemies removeObject:eHit];
                [eHit dealloc];
                Projectile *pHit = [self.cannon.shotProjectiles objectAtIndex:j];
                [self.cannon.shotProjectiles removeObject:pHit];
                [pHit dealloc];
                i--;
                break;//een enemy kan niet door 2 verschillende projectielen geraakt worden.
            }
        }
    }
}

- (BOOL) checkHitEnemy:(Enemy *)enemy Projectile:(Projectile *)projectile
{
    //Ik maak deze punten aan zodat we ook draaing toe kunnen passen...
    CGPoint projTopLeft = CGPointMake(projectile.centerX - projectile.width / 2, projectile.centerY - projectile.height / 2);
    CGPoint projTopRight = CGPointMake(projectile.centerX + projectile.width / 2, projectile.centerY - projectile.height / 2);
    CGPoint projBotLeft = CGPointMake(projectile.centerX - projectile.width / 2, projectile.centerY + projectile.height / 2);
    CGPoint projBotRight = CGPointMake(projectile.centerX + projectile.width / 2, projectile.centerY + projectile.height / 2);
    
    float angle = enemy.angle;
    float width = enemy.width;
    float height = enemy.height;
    float cosA = cos(degrees(angle));
    float sinA = sin(degrees(angle));
    float x = enemy.centerX;
    float y = enemy.centerY;
    
    CGPoint enemTopLeft  =  CGPointMake(x + ( width / 2 ) * cosA - ( height / 2 ) * sinA ,  y + ( height / 2 ) * cosA  + ( width / 2 ) * sinA);
    CGPoint enemTopRight  =  CGPointMake(x - ( width / 2 ) * cosA - ( height / 2 ) * sinA ,  y + ( height / 2 ) * cosA  - ( width / 2 ) * sinA);
    CGPoint enemBotLeft =   CGPointMake(x + ( width / 2 ) * cosA + ( height / 2 ) * sinA ,  y - ( height / 2 ) * cosA  + ( width / 2 ) * sinA);
    CGPoint enemBotRight  =  CGPointMake(x - ( width / 2 ) * cosA + ( height / 2 ) * sinA ,  y - ( height / 2 ) * cosA  - ( width / 2 ) * sinA);
    
    if([self lineCollision:enemBotLeft :enemBotRight :projTopRight :projBotLeft]) {
        return YES;
    } else if([self lineCollision:enemBotRight :enemBotLeft :projTopLeft :projBotRight]) {
        return YES;
    } else if([self lineCollision:enemTopRight :enemBotLeft :projTopLeft :projTopRight]) {
        return YES;
    } else if([self lineCollision:enemTopLeft :enemBotRight :projTopLeft :projTopRight]) {
        return YES;
    } else if ([self lineCollision:enemBotRight :enemBotLeft :projTopLeft :projTopRight]) {
        return YES;
    }
    
    return NO;
}

- (BOOL) lineCollision: (CGPoint) a : (CGPoint) b : (CGPoint) c : (CGPoint) d
{
    float denominator = ((b.x - a.x) * (d.y - c.y)) - ((b.y - a.y) * (d.x - c.x));
    float numerator1 = ((a.y - c.y) * (d.x - c.x)) - ((a.x - c.x) * (d.y - c.y));
    float numerator2 = ((a.y - c.y) * (b.x - a.x)) - ((a.x - c.x) * (b.y - a.y));
    
    float r = numerator1 / denominator;
    float s = numerator2 / denominator;
    
    return (r >= 0 && r <= 1) && (s >= 0 && s <= 1);
}

@end
