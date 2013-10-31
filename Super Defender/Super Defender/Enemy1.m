//
//  Enemy1.m
//  Super Defender
//
//  Created by Furkan on 10/14/13.
//  Copyright (c) 2013 RoFuPaNi. All rights reserved.
//

#import "Enemy1.h"

@implementation Enemy1

- (void) dealloc
{
    //NSLog(@"Enemy1 dealloc");
    [super dealloc];
}

- (Enemy *) initWithX:(float)x Y:(float)y
{
    self.score = 1;
    self.randomHeight = arc4random() % 100;
    self.maxHealth = 2;
    self.health = self.maxHealth;
    self.collides = YES;
    self.centerX = x;
    self.centerY = y;
    self.width = 64;
    self.height = 34;
    if(arc4random() % 2 == 0) {
        self.rotatesLeft = YES;
        self.angle = 10;
        self.movesLeft = YES;
    } else {
        self.angle = -10;
    }
    return self;
}

- (void) AI
{
    if(self.health <= 0) {
        if(self.collides)
        {
            self.collides = NO;
            self.countdown = 10;
        }
        if(self.countdown <= 0) {
            self.shouldDie = YES;
        } else {
            self.countdown--;
        }
    }
    self.centerY++;
    if(self.centerY > 150 - self.randomHeight + self.height / 2)
    {
        self.centerY--;
        if (self.movesLeft) {
            self.centerX--;
            if (self.centerX - self.width / 2 < 0) {
                self.movesLeft = NO;
            }
        } else {
            self.centerX++;
            if (self.centerX + self.width / 2 > 320) {
                self.movesLeft = YES;
            }
        }
    }
    if(self.rotatesLeft) {
        if(self.angle < -10) {
            self.rotatesLeft = NO;
        } else {
            self.angle--;
        }
    } else {
        if(self.angle > 10) {
            self.rotatesLeft = YES;
        } else {
            self.angle++;
        }
    }
    int random = arc4random() % 1200;
    if (random == 0) {
        if (self.myProjectile) {
            [self.myProjectile dealloc];
        } else {
            self.myProjectile = [[EnemyProjectile alloc] initWithX:self.centerX Y:self.centerY Angle:90];
        }
    }
}

@end
