//
//  Cannon.m
//  Super Defender
//
//  Created by Furkan on 10/14/13.
//  Copyright (c) 2013 RoFuPaNi. All rights reserved.
//

#import "Cannon.h"

@implementation Cannon

@synthesize aimspeed;
@synthesize rateOfFire;
@synthesize angle;
@synthesize image;

- (Cannon *)init
{
    return [super init];
}

-(void)update:(float) angle2
{
    if(angle2 > 37 && angle2 < 143)
    {
        self.angle = angle2;
    }
}

@end
