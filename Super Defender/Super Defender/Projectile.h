//
//  Projectile.h
//  Super Defender
//
//  Created by Furkan on 10/14/13.
//  Copyright (c) 2013 RoFuPaNi. All rights reserved.
//

#import <Foundation/Foundation.h>
#define degrees(x) (M_PI * (x) / 180)
@interface Projectile : NSObject
@property (nonatomic, assign) float centerX;
@property (nonatomic, assign) float centerY;
@property (nonatomic, assign) float velX;
@property (nonatomic, assign) float velY;
@property (nonatomic, assign) float angle;
@property (nonatomic, assign) int width;
@property (nonatomic, assign) int height;
@property (nonatomic, assign) BOOL shouldDie;
@property (nonatomic, assign) int power;
- (void) update;
- (Projectile *) initWithX:(float) x Y:(float) y Angle:(float) angle;
@end
