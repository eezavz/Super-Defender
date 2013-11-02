//
//  Projectile.m
//  Super Defender
//
//  Created by Furkan on 10/14/13.
//  Copyright (c) 2013 RoFuPaNi. All rights reserved.
//

#import "Projectile.h"

@implementation Projectile
- (void) update
{
    self.centerX += self.velX;
    self.centerY += self.velY;
    
    if (self.centerX + self.width / 2 < 0 || self.centerY + self.height / 2 < 0 || self.centerX - self.width / 2 > 320 || self.centerY - self.height / 2 > 430) {
        self.shouldDie = YES;
    }
}

- (Projectile *) init
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"Use initWithX!!!"]
                                 userInfo:nil];
}

- (Projectile *) initWithX:(float) x Y:(float) y Angle:(float)angle
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}
@end
