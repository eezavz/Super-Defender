//
//  Projectile2.m
//  Super Defender
//
//  Created by Furkan on 10/14/13.
//  Copyright (c) 2013 RoFuPaNi. All rights reserved.
//

#import "EnemyProjectile.h"

@implementation EnemyProjectile
- (Projectile *) initWithX:(float) x Y:(float) y Angle:(float) angle
{
    self.power = 1;
    self.centerX = x;
    self.centerY = y;
    self.width = 20;
    self.height = 17;
    self.angle = angle;
    self.velX = +cos(degrees(angle))*4;
    self.velY = +sin(degrees(angle))*4;
    return self;
}

- (void)update
{
    self.centerX += self.velX;
    self.centerY += self.velY;
    
    if (self.centerX < 0 - self.width / 2 || self.centerY - self.height / 2 < 0 || self.centerX > 320 + self.width / 2 || self.centerY + self.height / 2 > 430) {
        self.shouldDie = YES;
    }
}
@end
