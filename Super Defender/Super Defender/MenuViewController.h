//
//  UpgradeViewController.h
//  Super Defender
//
//  Created by Furkan on 10/14/13.
//  Copyright (c) 2013 RoFuPaNi. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "UpgradeViewController.h"
#include "GameData.h"


@protocol MenuViewControllerDelegate <NSObject>
- (BOOL)runningGame;
- (void)newGame:(UIImage *)beloved;
- (void)menuClosed;
@end

@interface MenuViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet UIButton *projectileBackButton;
@property (strong, nonatomic) IBOutlet UIButton *upgradeBackButton;
@property (strong, nonatomic) IBOutlet UIButton *resumeKnop;
@property (strong, nonatomic) IBOutlet UIButton *imageKnop;
@property (strong, nonatomic) IBOutlet UIButton *useCamera;
@property (strong, nonatomic) IBOutlet UIButton *useLibrary;
@property (strong, nonatomic) IBOutlet UIButton *doneSelecting;
@property (strong, nonatomic) IBOutlet UIButton *newgame;
@property (assign) id <MenuViewControllerDelegate> delegate;

@property (atomic, retain) IBOutlet UIView *curView;
@property (atomic, retain) IBOutlet UIView *emptyView;
@property (atomic, retain) IBOutlet UIView *menuView;
@property (atomic, retain) IBOutlet UIView *projectileView;
@property (atomic, retain) IBOutlet UIView *upgradeView;
@property (nonatomic, strong) IBOutlet UIView *pickImageView;
@property (nonatomic, strong) UIImagePickerController *picker;
@property (nonatomic, strong) IBOutlet UIImageView *selectedImage;
@property (nonatomic, strong) IBOutlet UILabel *selectedImageLabel;
@property (nonatomic, assign) BOOL firstTime;

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

@property (atomic, assign) int score;
@property (atomic, assign) NSNumber *scrap;
@property (atomic, retain) IBOutlet UILabel *projectileScoreLabel;
@property (atomic, retain) IBOutlet UILabel *upgradeScrapLabel;

@property (atomic, retain) IBOutlet UILabel *projectilePowerCost;
@property (atomic, retain) IBOutlet UILabel *projectileFirerateCost;
@property (atomic, retain) IBOutlet UILabel *projectileMoveSpeedCost;
@property (atomic, retain) IBOutlet UILabel *projectileUnstoppableCost;
@property (atomic, retain) IBOutlet UILabel *projectileDarkmMatterCost;

@property (atomic, retain) IBOutlet UILabel *upgradeHealthCost;
@property (atomic, retain) IBOutlet UILabel *upgradeFirerateCost;
@property (atomic, retain) IBOutlet UILabel *upgradeMoveSpeedCost;
@property (atomic, retain) IBOutlet UILabel *upgradePowerCost;
@property (atomic, retain) IBOutlet UILabel *upgradeRotSpeedCost;

@property (atomic, retain) IBOutlet UILabel *projectilePowerAmount;
@property (atomic, retain) IBOutlet UILabel *projectileFirerateAmount;
@property (atomic, retain) IBOutlet UILabel *projectileMoveSpeedAmount;
@property (atomic, retain) IBOutlet UILabel *projectileUnstoppableAmount;
@property (atomic, retain) IBOutlet UILabel *projectileDarkmMatterAmount;

@property (atomic, retain) IBOutlet UILabel *upgradeHealthAmount;
@property (atomic, retain) IBOutlet UILabel *upgradeFirerateAmount;
@property (atomic, retain) IBOutlet UILabel *upgradeMoveSpeedAmount;
@property (atomic, retain) IBOutlet UILabel *upgradePowerAmount;
@property (atomic, retain) IBOutlet UILabel *upgradeRotSpeedAmount;

@property (atomic, retain) NSMutableArray *projectileButtons;
@property (atomic, retain) NSMutableArray *projectileCostLabels;
@property (atomic, retain) NSMutableArray *projectileAmountLabels;

@property (atomic, retain) NSMutableArray *upgradeButtons;
@property (atomic, retain) NSMutableArray *upgradeCostLabels;
@property (atomic, retain) NSMutableArray *upgradeAmountLabels;

@property (atomic, retain) GameData *gameData;

- (MenuViewController *)init : (NSMutableDictionary *)gameData;
- (IBAction)tap:(id)sender;
- (void)saveGame;
- (void) loadProjectileViewData;
- (void) loadUpgradeViewData;
- (NSString *)givePath;
- (IBAction) projectileButtonTapped:(id)sender;
- (IBAction) projectileViewButtonTapped:(id) sender;
- (IBAction) upgradeViewButtonTapped:(id) sender;
- (IBAction) upgradeButtonTapped:(id)sender;
- (void) visible;
@end
