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

- (Enemy *)initWithX:(float)x y:(float) y {
    self.x = x;
    self.y = y;
    if(arc4random() % 2 == 0) {
        self.rotatesLeft = YES;
        self.angle = 20;
    } else {
        self.angle = -20;
    }
    return self;
}

- (void) AI
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

@end
