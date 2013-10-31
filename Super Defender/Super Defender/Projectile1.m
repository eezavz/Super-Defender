//
//  Projectile1.m
//  Super Defender
//
//  Created by Furkan on 10/14/13.
//  Copyright (c) 2013 RoFuPaNi. All rights reserved.
//

#import "Projectile1.h"

@implementation Projectile1

- (Projectile *) initWithX:(float) x Y:(float) y Angle:(float) angle
{
    self.power = 1;
    self.centerX = x;
    self.centerY = y;
    self.width = 20;
    self.height = 20;
    self.angle = angle;
    self.velX = -cos(degrees(angle))*4;
    self.velY = -sin(degrees(angle))*4;
    return self;
}

- (void)update
{
    self.centerX += self.velX;
    self.centerY += self.velY;
    
    if (self.centerX < 0 - self.width / 2 || self.centerY < - self.height / 2 || self.centerX > 320 + self.width / 2) {
        self.shouldDie = YES;
    }
}

@end
