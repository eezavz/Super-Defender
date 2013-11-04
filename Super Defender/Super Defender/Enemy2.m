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
    self.yLimit = 250 - arc4random() % 100;
    self.maxHealth = 20;
    self.health = self.maxHealth;
    self.collides = YES;
    self.centerX = x;
    self.centerY = y;
    self.width = 128;
    self.height = 68;
    self.lowerXLimit = 0 + self.width / 2;
    self.higherXLimit = 320 - self.width / 2;
    self.sideways = YES;
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
            self.countdown = 5;
        }
        if(self.countdown <= 0) {
            self.shouldDie = YES;
        } else {
            self.countdown--;
        }
    }
    
    if (self.centerY < self.yLimit) {
        self.centerY++;
    } else {
        if (self.sideways) {
            if (self.movesLeft) {
                self.centerX-=2;
                if (self.centerX < self.lowerXLimit) {
                    self.movesLeft = NO;
                }
            } else {
                self.centerX+=2;
                if (self.centerX > self.higherXLimit) {
                    self.movesLeft = YES;
                }
            }
        }
    }
    
    if(self.rotatesLeft) {
        if(self.angle < -10) {
            self.rotatesLeft = NO;
        } else {
            self.angle-=2;
        }
    } else {
        if(self.angle > 10) {
            self.rotatesLeft = YES;
        } else {
            self.angle+=2;
        }
    }
}

@end
