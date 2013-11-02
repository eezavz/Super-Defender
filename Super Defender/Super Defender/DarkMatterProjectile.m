//
//  DarkMatterProjectile.m
//  Super Defender
//
//  Created by ManIkWeet on 02-11-13.
//  Copyright (c) 2013 RoFuPaNi. All rights reserved.
//

#import "DarkMatterProjectile.h"

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
    return self;
}

- (void) update
{
    //het idee is dat deze naar het midden gaat en dan een enorme explosie doet ofzo...
}

@end
