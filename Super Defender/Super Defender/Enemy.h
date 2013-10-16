//
//  Enemy.h
//  Super Defender
//
//  Created by Furkan on 10/14/13.
//  Copyright (c) 2013 RoFuPaNi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Enemy : NSObject 
@property (nonatomic, assign) float speed;
@property (nonatomic, assign) int health;
@property (nonatomic, assign) BOOL mustDie;
@property (nonatomic, assign) float x;
@property (nonatomic, assign) float y;
@property (nonatomic, assign) float angle;
@property (nonatomic, assign) BOOL rotatesLeft;

- (Enemy *)init;
- (Enemy *) initWithX:(float)x y:(float) y;
- (void) AI;

@end
