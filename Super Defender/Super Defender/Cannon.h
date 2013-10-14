//
//  Cannon.h
//  Super Defender
//
//  Created by Furkan on 10/14/13.
//  Copyright (c) 2013 RoFuPaNi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cannon : NSObject

@property (nonatomic, assign) int aimspeed;
@property (nonatomic, assign) int rateOffFire;
@property (nonatomic, retain) UIImage *image;

-(void)update;

@end
