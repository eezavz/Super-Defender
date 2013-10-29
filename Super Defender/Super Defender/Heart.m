//
//  Heart.m
//  Super Defender
//
//  Created by Furkan on 10/28/13.
//  Copyright (c) 2013 RoFuPaNi. All rights reserved.
//

#import "Heart.h"

@implementation Heart

@synthesize health;

-(Object *)init: (float)x Y:(float)y;
{
    self.centerX = x;
    self.centerY = y;
    health = 3;
    return self;
}

-(void)update
{
    self.centerY++;
}

@end
