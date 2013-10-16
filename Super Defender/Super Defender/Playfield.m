//
//  Playfield.m
//  Super Defender
//
//  Created by Furkan on 10/14/13.
//  Copyright (c) 2013 RoFuPaNi. All rights reserved.
//

#import "Playfield.h"

@implementation Playfield

@synthesize progress;
@synthesize score;
@synthesize health;
@synthesize enemyCountdown;
@synthesize cannon;

- (Playfield *)init
{
    self.cannon = [[Cannon alloc]init];
    return [super init];
}

-(void)update:(float)angle;
{
    //NSLog(@"Angle %f", angle);
    [self.cannon update:angle];
    enemyCountdown--;
    if(enemyCountdown <= 0) {
        int random = arc4random() % 50;
        NSLog(@"Random: %d", random);
        enemyCountdown = 50 + random;
    }
}

@end
