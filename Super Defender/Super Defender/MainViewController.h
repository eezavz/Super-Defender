//
//  MainViewController.h
//  Super Defender
//
//  Created by Furkan on 10/14/13.
//  Copyright (c) 2013 RoFuPaNi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Playfield.h"

@interface MainViewController : UIViewController

@property (atomic, retain) Playfield *playfield;
@property (atomic, retain) UISlider *slider;
@property (atomic, retain) NSTimer * timer;
@property (atomic, retain) UIImageView *cannonBody;
@property (atomic, retain) UIImageView *cannonBarrel;
@property (atomic, retain) UIImage *enemyImage;
@property (atomic, retain) UIImage *projectileImage;
@property (atomic, retain) NSMutableArray *drawnEnemies;
@property (atomic, assign) int projectileCountdown;
//@property (atomic, retain) NSMutableArray *projectiles;

- (void)update:(NSTimer *)timer;
- (void)render;
- (void)renderProjectiles;
- (void) collisionDetect;
- (int) distanceFromPoint:(int)p2x : (int)p2y : (int)p1x : (int)p1y;

@end
