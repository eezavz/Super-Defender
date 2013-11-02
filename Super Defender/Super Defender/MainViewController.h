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
#import "DefaultProjectile.h"
#import "PowerProjectile.h"
#import "FrequentProjectile.h"
#import "LightningProjectile.h"
#import "UnstoppableProjectile.h"
#import "DarkMatterProjectile.h"
@interface MainViewController : UIViewController <MenuViewControllerDelegate>

@property (atomic, retain) Playfield *playfield;
@property (atomic, retain) UISlider *slider;
@property (atomic, retain) NSTimer *timer;
@property (atomic, retain) UIImageView *cannonBody;
@property (atomic, retain) UIImageView *cannonBarrel;
@property (atomic, retain) UIImage *enemyImage;

@property (atomic, retain) UIImage *defaultProjectileImage;
@property (atomic, retain) UIImage *powerProjectileImage;
@property (atomic, retain) UIImage *frequentProjectileImage;
@property (atomic, retain) UIImage *lightningProjectileImage;
@property (atomic, retain) UIImage *unstoppableProjectileImage;
@property (atomic, retain) UIImage *darkMatterProjectileImage;
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

@property (nonatomic, strong) UIButton *powerProjectileActivator;
@property (nonatomic, strong) UIButton *frequentProjectileActivator;
@property (nonatomic, strong) UIButton *lightningProjectileActivator;
@property (nonatomic, strong) UIButton *unstoppableProjectileActivator;
@property (nonatomic, strong) UIButton *darkmatterProjectileActivator;

- (void) newGame:(UIImage *)beloved;
- (BOOL) runningGame;
- (void) update:(NSTimer *)timer;
- (void) render;
- (void) startTimer;
- (void) stopTimer;
- (IBAction) objectPressed:(id)sender;
- (void) loadGameData;
- (void)saveGame;
@end
