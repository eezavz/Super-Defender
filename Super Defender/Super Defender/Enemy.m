//
//  Enemy.m
//  Super Defender
//
//  Created by Furkan on 10/14/13.
//  Copyright (c) 2013 RoFuPaNi. All rights reserved.
//

#import "Enemy.h"

@implementation Enemy;

- (Enemy *)init
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"Use initWithX"]
                                 userInfo:nil];
}

- (Enemy *)initWithX:(float)x Y:(float) y {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

- (void) AI
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

- (void)damageAmount:(int)damage
{
    self.health -= damage;
    if (self.health < 0) {
        self.health = 0;
    }
}

- (void) dealloc
{
    if(self.myProjectile) {
        [self.myProjectile dealloc];
    }
    [super dealloc];
}

@end
