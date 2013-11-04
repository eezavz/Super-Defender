//
//  Playfield.m
//  Super Defender
//
//  Created by Furkan on 10/14/13.
//  Copyright (c) 2013 RoFuPaNi. All rights reserved.
//

#import "Playfield.h"
#import "Enemy1.h"
#import "Enemy2.h"
#import "Object.h"
#import "Heart.h"
#import "UnstoppableProjectile.h"
#define degrees(x) (M_PI * (x) / 180)

@interface Playfield ()
@property (nonatomic, assign) int runTime;
@property (nonatomic, assign) int spawnTick;
@end
@implementation Playfield

@synthesize progress;
@synthesize score;
@synthesize health;
@synthesize enemyCountdown;
@synthesize cannon;
@synthesize enemies;
@synthesize enemyProjectiles;
@synthesize objects;
@synthesize leveldata;

- (Playfield *)init : (int)maxHealth : (int)FireRate : (int)MoveSpeed : (int)Power : (int)RotSpeed;
{
    self.cannon = [[Cannon alloc]init : maxHealth : FireRate : MoveSpeed : Power : RotSpeed];
    cannon.posX = 160;
    cannon.posY = 405;
    cannon.width = 100;
    cannon.height = 50;
    enemies = [[NSMutableArray alloc] init];
    self.score = 0;
    self.enemyProjectiles = [[NSMutableArray alloc] init];
    objects = [[NSMutableArray alloc]init];
    self.runTime = 0;
    self.leveldata = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Levels" ofType:@"plist"]];
    return [super init];
}

-(void)update:(float)angle;
{
    [self.cannon update:angle];
    int screenlimit = 1 + self.runTime / 240;
    if (screenlimit > 30) {
        screenlimit = 30;
    }
    
    if (self.enemies.count < screenlimit && self.spawnTick == -1) {
        self.spawnTick = 0;
    }
    
    if (self.spawnTick > -1) {
        self.spawnTick++;
        if (self.spawnTick % [[[self.leveldata objectForKey:@"Level 1"] objectForKey:@"tickdelay"] intValue] == 0) {
            int tick = self.spawnTick / [[[self.leveldata objectForKey:@"Level 1"] objectForKey:@"tickdelay"] intValue] - 1;
            NSArray *enemiesDataForTick = [[[self.leveldata objectForKey:@"Level 1"] objectForKey:@"ticks"] objectAtIndex:tick];
            for (int i = 0; i < enemiesDataForTick.count; i++) {
                NSDictionary *enemyData = [enemiesDataForTick objectAtIndex:i];
                Enemy1 *customNoob = [[Enemy1 alloc] initWithX:[[enemyData objectForKey:@"spawnx"] intValue] Y:-16];
                customNoob.sideways = [[enemyData objectForKey:@"sideways"] floatValue];
                customNoob.yLimit = [[enemyData objectForKey:@"ylimit"] floatValue];
                customNoob.lowerXLimit = [[enemyData objectForKey:@"lowerxlimit"] floatValue];
                customNoob.higherXLimit = [[enemyData objectForKey:@"higherxlimit"] floatValue];
                customNoob.movesLeft = [[enemyData objectForKey:@"movesleft"] boolValue];
                [self.enemies addObject:customNoob];
                //[enemyData release];
            }
            //[enemiesDataForTick release];
            if (tick == [[[self.leveldata objectForKey:@"Level 1"] objectForKey:@"ticks"] count] - 1) {
                self.spawnTick = -1;
            }
        }
    }
    
    for (int i = 0; i < enemies.count; i++) {
        [[enemies objectAtIndex:i] AI];
        if ([[enemies objectAtIndex:i] myProjectile]) {
            [self.enemyProjectiles addObject:[[enemies objectAtIndex:i] myProjectile]];
            [[enemies objectAtIndex:i] setMyProjectile:nil];
        }
        if([[enemies objectAtIndex:i] shouldDie])
        {
            Enemy *temp = [enemies objectAtIndex:i];
            [enemies removeObject:temp];
            if(arc4random() % 30 == 1)
            {
                Heart *heart = [[Heart alloc]init:[temp centerX] Y: [temp centerY]];
                [self.objects addObject:heart];
            }
            [temp dealloc];
            i--;
        }
    }
    for (int i = 0; i < cannon.shotProjectiles.count; i++) {
        for (int j = 0; j < enemies.count; j++) {
            if([[enemies objectAtIndex:j] collides]){
                if([self checkHitEnemy:[enemies objectAtIndex:j] Projectile:[self.cannon.shotProjectiles objectAtIndex:i]]) {
                    Projectile *pHit = [self.cannon.shotProjectiles objectAtIndex:i];
                    Enemy *eHit = [enemies objectAtIndex:j];
                    [eHit damageAmount:pHit.power];
                    if(eHit.health == 0) {
                        self.score+=eHit.score;
                    }
                    if (![pHit isMemberOfClass:[UnstoppableProjectile class]]) {
                        [self.cannon.shotProjectiles removeObject:pHit];
                        [pHit dealloc];
                        i--;
                        break;//een projectile kan maar 1 enemy raken voorlopig.
                    }
                }
            }
        }
    }
    
    for(int i =0; i < objects.count; i++)
    {
        [[objects objectAtIndex:i]update];
    }
    
    for (int i = 0; i < self.enemyProjectiles.count; i++) {
        [[self.enemyProjectiles objectAtIndex:i] update];
        if ([[self.enemyProjectiles objectAtIndex:i] shouldDie]) {
            EnemyProjectile *hit = [self.enemyProjectiles objectAtIndex:i];
            [self.enemyProjectiles removeObject:hit];
            [hit dealloc];
            i--;
        } else {
            CGRect cannonRect = CGRectMake(cannon.posX - cannon.width / 2, cannon.posY - cannon.height / 2, cannon.width, cannon.height);
            float x = [[self.enemyProjectiles objectAtIndex:i] centerX];
            float y = [[self.enemyProjectiles objectAtIndex:i] centerY];
            float width = [(EnemyProjectile *)[self.enemyProjectiles objectAtIndex:i] width];
            float height = [(EnemyProjectile *)[self.enemyProjectiles objectAtIndex:i] height];
            CGPoint projBotLeft = CGPointMake(x - width / 2, y + height / 2);
            CGPoint projBotRight = CGPointMake(x + width / 2, y + height / 2);
            CGPoint projTopLeft = CGPointMake(x - width / 2, y - height / 2);
            CGPoint projTopRight = CGPointMake(x + width / 2, y - height / 2);
            BOOL hit = NO;
            if (CGRectContainsPoint(cannonRect, projBotLeft)) {
                hit = YES;
            } else if (CGRectContainsPoint(cannonRect, projBotRight)) {
                hit = YES;
            } else if (CGRectContainsPoint(cannonRect, projTopLeft)) {
                hit = YES;
            } else if (CGRectContainsPoint(cannonRect, projTopRight)) {
                hit = YES;
            }
            if (hit) {
                cannon.health -= [[self.enemyProjectiles objectAtIndex:i] power];
                EnemyProjectile *hit = [self.enemyProjectiles objectAtIndex:i];
                [self.enemyProjectiles removeObject:hit];
                [hit dealloc];
                i--;
            }
        }
    }
    self.runTime++;
}

- (BOOL) checkHitEnemy:(Enemy *)enemy Projectile:(Projectile *)projectile
{
    //Ik maak deze punten aan zodat we ook draaing toe kunnen passen...
    CGPoint projTopLeft = CGPointMake(projectile.centerX - projectile.width / 2, projectile.centerY - projectile.height / 2);
    CGPoint projTopRight = CGPointMake(projectile.centerX + projectile.width / 2, projectile.centerY - projectile.height / 2);
    CGPoint projBotLeft = CGPointMake(projectile.centerX - projectile.width / 2, projectile.centerY + projectile.height / 2);
    CGPoint projBotRight = CGPointMake(projectile.centerX + projectile.width / 2, projectile.centerY + projectile.height / 2);
    
    CGRect enemyRect = CGRectMake(enemy.centerX, enemy.centerY, enemy.width, enemy.height);
    if ([self isPoint:projTopLeft inCenteredRect:enemyRect withRotation:enemy.angle]) {
        return YES;
    } else if ([self isPoint:projTopRight inCenteredRect:enemyRect withRotation:enemy.angle]) {
        return YES;
    } else if ([self isPoint:projBotLeft inCenteredRect:enemyRect withRotation:enemy.angle]) {
        return YES;
    } else if ([self isPoint:projBotRight inCenteredRect:enemyRect withRotation:enemy.angle]) {
        return YES;
    }
    
    return NO;
}

-(BOOL) isPoint:(CGPoint)point inCenteredRect:(CGRect)obj withRotation:(float)angle {
    double c = cos(-degrees(angle));
    double s = sin(-degrees(angle));
    float rotatedX = obj.origin.x + c * (point.x - obj.origin.x) - s * (point.y - obj.origin.y);
    float rotatedY = obj.origin.y + s * (point.x - obj.origin.x) + c * (point.y - obj.origin.y);
    
    float leftX = obj.origin.x - obj.size.width/2;
    float rightX = obj.origin.x + obj.size.width /2;
    float topY = obj.origin.y  - obj.size.height /2;
    float bottomY = obj.origin.y + obj.size.height /2;
    
    return (leftX <= rotatedX && rotatedX <= rightX && topY <= rotatedY && rotatedY <= bottomY);
}

- (void) dealloc
{
    [self.cannon dealloc];
    [self.enemies dealloc];
    [self.enemyProjectiles dealloc];
    [self.objects dealloc];
    [super dealloc];
}

@end
