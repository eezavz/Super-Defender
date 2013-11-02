//
//  PowerProjectile.m
//  Super Defender
//
//  Created by ManIkWeet on 02-11-13.
//  Copyright (c) 2013 RoFuPaNi. All rights reserved.
//

#import "PowerProjectile.h"

@implementation PowerProjectile
- (Projectile *) initWithX:(float) x Y:(float) y Angle:(float) angle
{
    self.power = 10;
    self.centerX = x;
    self.centerY = y;
    self.width = 20;
    self.height = 20;
    self.angle = angle;
    self.velX = -cos(degrees(angle))*4;
    self.velY = -sin(degrees(angle))*4;
    return self;
}
@end
