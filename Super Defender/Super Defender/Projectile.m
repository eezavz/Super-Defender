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
    
    if (self.centerX < 0 - self.width / 2 || self.centerY < - self.height / 2 || self.centerX > 320 + self.width / 2) {
        self.shouldDie = YES;
    }
}

- (Projectile *) init
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"Use initWithX!!!"]
                                 userInfo:nil];
}

- (Projectile *) initWithX:(float) x Y:(float) y Width:(int) width Height:(int) height
{
    self.centerX = x;
    self.centerY = y;
    self.width = width;
    self.height = height;
    return self;
}
@end
