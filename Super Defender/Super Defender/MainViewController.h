//
//  MainViewController.h
//  Super Defender
//
//  Created by Furkan on 10/14/13.
//  Copyright (c) 2013 RoFuPaNi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Playfield.h"
#import "MenuViewController.h"
#import "Projectile.h"
#import "Enemy.h"
#import "Enemy2.h"
#import <CoreMotion/CoreMotion.h>
#import "MenuViewController.h"
#import "Heart.h"

@interface MainViewController : UIViewController <MenuViewControllerDelegate>

@property (atomic, retain) Playfield *playfield;
@property (atomic, retain) UISlider *slider;
@property (atomic, retain) NSTimer *timer;
@property (atomic, retain) UIImageView *cannonBody;
@property (atomic, retain) UIImageView *cannonBarrel;
@property (atomic, retain) UIImage *enemyImage;
@property (atomic, retain) UIImage *projectileImage;
@property (atomic, retain) UIImage *enemyProjectileImage;
@property (nonatomic, strong) NSMutableArray *renderedObjects;
@property (nonatomic, strong) UILabel *scoreLabel;
@property (nonatomic, strong) NSMutableArray *damageImages;
@property (nonatomic, strong) UIImage *explosion;
@property (nonatomic, strong) UIImage *bigExplosion;
@property (nonatomic, strong) UIImage *bossImage;
@property (nonatomic, strong) UIImageView *cannonHealth;
@property (nonatomic, strong) UIButton *pauseButton;
@property (nonatomic, strong) UIImage *heartImage;
@property (nonatomic, strong) NSMutableArray *objectButtons;
@property (nonatomic, strong) NSMutableDictionary *gameData;
@property (nonatomic, strong) MenuViewController *mvc;
@property (nonatomic, strong) UIImageView *beloved;

- (void) newGame:(UIImage *)beloved;
- (BOOL) runningGame;
- (void) update:(NSTimer *)timer;
- (void) render;
- (void) startTimer;
- (void) stopTimer;
- (IBAction) objectPressed:(id)sender;
- (void)saveGame;
@end
