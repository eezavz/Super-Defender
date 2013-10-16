//
//  Playfield.m
//  Super Defender
//
//  Created by Furkan on 10/14/13.
//  Copyright (c) 2013 RoFuPaNi. All rights reserved.
//

#import "Playfield.h"
#import "Enemy1.h"

@implementation Playfield

@synthesize progress;
@synthesize score;
@synthesize health;
@synthesize enemyCountdown;
@synthesize cannon;
@synthesize enemies;

- (Playfield *)init
{
    self.cannon = [[Cannon alloc]init];
    enemies = [[NSMutableArray alloc] init];
    return [super init];
}

-(void)update:(float)angle;
{
    //NSLog(@"Angle %f", angle);
    [self.cannon update:angle];
    
    if(enemyCountdown == 0) {
        int random = arc4random() % 100;
        NSLog(@"Random: %d", random);
        enemyCountdown = random;
        Enemy1 *lwut = [[Enemy1 alloc] initWithX: arc4random() % 256 y:-34];
        [self.enemies addObject:lwut];
    } else {
        enemyCountdown--;
    }
    for (int i = 0; i < enemies.count; i++) {
        [[enemies objectAtIndex:i] AI];
        if([[enemies objectAtIndex:i] mustDie])
        {
            Enemy *temp = [enemies objectAtIndex:i];
            [enemies removeObject:temp];
            [temp dealloc];
            i--;
        }
    }
}

@end
