//
//  UpgradeViewController.h
//  Super Defender
//
//  Created by Furkan on 10/14/13.
//  Copyright (c) 2013 RoFuPaNi. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "UpgradeViewController.h"

@protocol MenuViewControllerDelegate <NSObject>
- (void)menuClosed;
@end

@interface MenuViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *knop;
@property (assign) id <MenuViewControllerDelegate> delegate;

@property (atomic, retain) IBOutlet UIView *curView;
@property (atomic, retain) IBOutlet UIView *emptyView;
@property (atomic, retain) IBOutlet UIView *menuView;
@property (atomic, retain) IBOutlet UIView *projectileView;
@property (atomic, retain) IBOutlet UIView *upgradeView;

@property (atomic, retain) IBOutlet UIButton *buttonUpgradeHealth;
@property (atomic, retain) IBOutlet UIButton *buttonUpgradeFireRate;
@property (atomic, retain) IBOutlet UIButton *buttonUpgradeMoveSpeed;
@property (atomic, retain) IBOutlet UIButton *buttonUpgradePower;
@property (atomic, retain) IBOutlet UIButton *buttonUpgradeRotSpeed;

@property (atomic, retain) IBOutlet UIButton *buttonProjectilePower;
@property (atomic, retain) IBOutlet UIButton *buttonProjectileFireRate;
@property (atomic, retain) IBOutlet UIButton *buttonProjectileMoveSpeed;
@property (atomic, retain) IBOutlet UIButton *buttonProjectileUnstopable;
@property (atomic, retain) IBOutlet UIButton *buttonProjectileDarkMatter;

- (IBAction)tap:(id)sender;
- (IBAction) upgradeButtonTapped:(id) sender;
@end
