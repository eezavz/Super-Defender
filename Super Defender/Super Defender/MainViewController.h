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
#import "GameData.h"

@interface MainViewController : UIViewController <MenuViewControllerDelegate>
@property (nonatomic, strong) GameData *gameData;

@property (nonatomic, strong) Playfield *playfield;
@property (nonatomic, strong) UISlider *slider;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIImageView *cannonBody;
@property (nonatomic, strong) UIImageView *cannonBarrel;
@property (nonatomic, strong) UIImage *enemyImage;

@property (nonatomic, strong) UIImage *defaultProjectileImage;
@property (nonatomic, strong) UIImage *powerProjectileImage;
@property (nonatomic, strong) UIImage *frequentProjectileImage;
@property (nonatomic, strong) UIImage *lightningProjectileImage;
@property (nonatomic, strong) UIImage *unstoppableProjectileImage;
@property (nonatomic, strong) UIImage *darkMatterProjectileImage;
@property (nonatomic, strong) UIImage *enemyProjectileImage;

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
@property (nonatomic, strong) MenuViewController *mvc;
@property (nonatomic, strong) UIImageView *beloved;

@property (nonatomic, strong) UIButton *powerProjectileActivator;
@property (nonatomic, strong) UIButton *frequentProjectileActivator;
@property (nonatomic, strong) UIButton *lightningProjectileActivator;
@property (nonatomic, strong) UIButton *unstoppableProjectileActivator;
@property (nonatomic, strong) UIButton *darkMatterProjectileActivator;

- (void) newGame:(UIImage *)beloved;
- (BOOL) runningGame;
- (void) update:(NSTimer *)timer;
- (void) render;
- (void) startTimer;
- (void) stopTimer;
- (IBAction) objectPressed:(id)sender;
- (void)saveGame;
- (void)createPlayfield;
- (void)updateActivatorTitle :(int)par_number :(int)par_amount;
- (void) updateScore:(int) score;
@end
