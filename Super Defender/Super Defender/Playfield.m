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
@synthesize projectiles;
@synthesize projectileCountdown;
@synthesize projectileImage;

- (Playfield *)init
{
    self.cannon = [[Cannon alloc]init];
    enemies = [[NSMutableArray alloc] init];
    projectiles = [[NSMutableArray alloc]init];
    return [super init];
}

-(void)update:(float)angle;
{
    [self updateProjectiles : angle];
    [self collisionDetect];
    //NSLog(@"Angle %f", angle);
    [self.cannon update:angle];
    
    if(enemyCountdown == 0) {
        int random = arc4random() % 100;
        //NSLog(@"Random: %d", random);
        enemyCountdown = random;
        Enemy1 *lwut = [[Enemy1 alloc] initWithX: arc4random() % (320-32) y:-17];
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

- (void) updateProjectiles : (float)angle
{
    float tempAngle = angle-90;
    for(int i = 0; i<projectiles.count; i++)
    {
        UIImageView *tempImage = [projectiles objectAtIndex:i];
        tempImage.center = CGPointMake(tempImage.frame.origin.x+tempImage.frame.size.width/2+tempAngle/3.6, tempImage.frame.origin.y+tempImage.frame.size.height/2-12);
    }
}

- (int) distanceFromPoint:(int)p2x : (int)p2y : (int)p1x : (int)p1y
{
    int xDist = (p1x - p2x);
    int yDist = (p1y - p2y);
    return sqrt((xDist * xDist) + (yDist * yDist));
}

- (void) collisionDetect
{
    for(int i = 0; i<projectiles.count; i++)
    {
        UIImageView *tempImage = [projectiles objectAtIndex:i];
        //NSLog(@"Enemies count: %i", playfield.enemies.count);
        for(int b = 0; b<enemies.count; b++)
        {
            if([self distanceFromPoint:[[enemies objectAtIndex:b] x] :[[enemies objectAtIndex:b] y] :tempImage.frame.origin.x : tempImage.frame.origin.y] < 35)
            {
                [tempImage removeFromSuperview];
                [tempImage release];
                [projectiles removeObjectAtIndex:i];
                [enemies removeObjectAtIndex:b];
                b--;
                i--;
                break;
            }
        }
    }
}

@end
