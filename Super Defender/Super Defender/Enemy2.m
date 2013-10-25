//
//  Enemy2.m
//  Super Defender
//
//  Created by Furkan on 10/14/13.
//  Copyright (c) 2013 RoFuPaNi. All rights reserved.
//

#import "Enemy2.h"

@implementation Enemy2
- (Enemy *) initWithX:(float)x Y:(float)y
{
    self.score = 20;
    self.randomHeight = arc4random() % 100;
    self.maxHealth = 20;
    self.health = self.maxHealth;
    self.collides = YES;
    self.centerX = x;
    self.centerY = y;
    self.width = 128;
    self.height = 68;
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
    if(self.centerY > 250 - self.randomHeight + self.height / 2)
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
}

@end
