//
//  DarkMatterProjectile.m
//  Super Defender
//
//  Created by ManIkWeet on 02-11-13.
//  Copyright (c) 2013 RoFuPaNi. All rights reserved.
//

#import "DarkMatterProjectile.h"

@interface DarkMatterProjectile()
@property (nonatomic, assign) int countdown;
@end

@implementation DarkMatterProjectile
- (Projectile *) initWithX:(float) x Y:(float) y Angle:(float) angle
{
    self.power = 1;
    self.centerX = x;
    self.centerY = y;
    self.width = 20;
    self.height = 20;
    self.angle = angle;
    self.velX = -cos(degrees(angle))*8;
    self.velY = -sin(degrees(angle))*8;
    self.countdown = 60;
    return self;
}

- (void) update
{
    //het idee is dat deze naar het midden gaat en dan een enorme explosie doet ofzo...
    if (self.centerX > 160) {
        self.centerX--;
        if (self.centerX < 160) {
            self.centerX = 160;
        }
    } else if (self.centerX < 160) {
        self.centerX++;
        if (self.centerX > 160) {
            self.centerX = 160;
        }
    }
    self.centerY--;
    if (self.centerY < 150) {
        self.centerY = 150;
    }
    
    if (self.centerX == 160 && self.centerY == 150) {
        self.countdown--;
        if (self.countdown <= 0) {
            self.explode = YES;
        }
    }
}

@end
