//
//  Projectile1.m
//  Super Defender
//
//  Created by Furkan on 10/14/13.
//  Copyright (c) 2013 RoFuPaNi. All rights reserved.
//

#import "DefaultProjectile.h"

@implementation DefaultProjectile

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
    return self;
}


@end
