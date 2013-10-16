//
//  Enemy1.m
//  Super Defender
//
//  Created by Furkan on 10/14/13.
//  Copyright (c) 2013 RoFuPaNi. All rights reserved.
//

#import "Enemy1.h"

@implementation Enemy1

- (void) dealloc
{
    NSLog(@"Enemy1 dealloc");
    [super dealloc];
}

- (void) AI
{
    //NSLog(@"Enemy1 AI: %f,%f, %s", self.x, self.y, self.mustDie ? "true" : "false");
    self.y++;
    if(self.y > 480)
    {
        self.mustDie = YES;
    }
    if(self.rotatesLeft) {
        if(self.angle < -10) {
            self.rotatesLeft = NO;
        } else {
            self.angle--;
        }
    } else {
        if(self.angle > 10) {
            self.rotatesLeft = YES;
        } else {
            self.angle++;
        }
    }
    //NSLog(@"Angle: %f", self.angle);
}

@end
