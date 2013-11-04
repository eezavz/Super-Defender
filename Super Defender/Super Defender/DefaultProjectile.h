//
//  Projectile1.h
//  Super Defender
//
//  Created by Furkan on 10/14/13.
//  Copyright (c) 2013 RoFuPaNi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Projectile.h"

@interface DefaultProjectile : Projectile

- (Projectile *) initWithX:(float) x Y:(float) y Angle:(float) angle Speed:(int) speed Power:(int)par_power;

@end
