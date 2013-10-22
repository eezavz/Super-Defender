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
    //NSLog(@"Enemy1 dealloc");
    [super dealloc];
}

- (Enemy *) initWithX:(float)x Y:(float)y
{
    self.centerX = x;
    self.centerY = y;
    self.width = 64;
    self.height = 34;
    if(arc4random() % 2 == 0) {
        self.rotatesLeft = YES;
        self.angle = 10;
    } else {
        self.angle = -10;
    }
    return self;
}

- (void) AI
{
    self.centerY++;
    if(self.centerY > 480 + self.height / 2)
    {
        self.shouldDie = YES;
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
}

@end
