//
//  Object.m
//  Super Defender
//
//  Created by Furkan on 10/14/13.
//  Copyright (c) 2013 RoFuPaNi. All rights reserved.
//

#import "Object.h"

@implementation Object

@synthesize centerX;
@synthesize centerY;

-(Object *)init: (float)x Y:(float)y;
{
    self.centerX = x;
    self.centerY = y;
    return self;
}

-(void)update
{
    
}

@end
