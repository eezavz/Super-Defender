//
//  Projectile.h
//  Super Defender
//
//  Created by Furkan on 10/14/13.
//  Copyright (c) 2013 RoFuPaNi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Projectile : NSObject
@property (nonatomic, assign) float centerX;
@property (nonatomic, assign) float centerY;
@property (nonatomic, assign) float velX;
@property (nonatomic, assign) float velY;
@property (nonatomic, assign) int width;
@property (nonatomic, assign) int height;
@property (nonatomic, assign) BOOL shouldDie;
- (void) update;
- (Projectile *) initWithX:(float) x Y:(float) y Width:(int) width Height:(int) height;
@end
