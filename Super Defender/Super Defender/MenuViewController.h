//
//  UpgradeViewController.h
//  Super Defender
//
//  Created by Furkan on 10/14/13.
//  Copyright (c) 2013 RoFuPaNi. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "GameData.h"


@protocol MenuViewControllerDelegate <NSObject>
- (BOOL)runningGame;
- (void)newGame:(UIImage *)beloved;
- (void)menuClosed;
- (void)createPlayfield;
- (void)updateActivatorTitle :(int)par_number :(int)par_amount;
- (void) updateScore:(int) score;
@end

@interface MenuViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) IBOutlet UIButton *projectileViewButton;
@property (nonatomic, strong) IBOutlet UIButton *projectileBackButton;
@property (nonatomic, strong) IBOutlet UIButton *upgradeBackButton;
@property (nonatomic, strong) IBOutlet UIButton *resumeKnop;
@property (nonatomic, strong) IBOutlet UIButton *imageKnop;
@property (nonatomic, strong) IBOutlet UIButton *useCamera;
@property (nonatomic, strong) IBOutlet UIButton *useLibrary;
@property (nonatomic, strong) IBOutlet UIButton *doneSelecting;
@property (nonatomic, strong) IBOutlet UIButton *newgame;
@property (nonatomic, assign) id <MenuViewControllerDelegate> delegate;

@property (nonatomic, strong) IBOutlet UIView *menuView;
@property (nonatomic, strong) IBOutlet UIView *projectileView;
@property (nonatomic, strong) IBOutlet UIView *upgradeView;
@property (nonatomic, strong) IBOutlet UIView *pickImageView;
@property (nonatomic, strong) UIImagePickerController *picker;
@property (nonatomic, strong) IBOutlet UIImageView *selectedImage;
@property (nonatomic, strong) IBOutlet UILabel *selectedImageLabel;
@property (nonatomic, assign) BOOL firstTime;

@property (nonatomic, strong) IBOutlet UIButton *buttonUpgradeHealth;
@property (nonatomic, strong) IBOutlet UIButton *buttonUpgradeFireRate;
@property (nonatomic, strong) IBOutlet UIButton *buttonUpgradeMoveSpeed;
@property (nonatomic, strong) IBOutlet UIButton *buttonUpgradePower;
@property (nonatomic, strong) IBOutlet UIButton *buttonUpgradeRotSpeed;

@property (nonatomic, strong) IBOutlet UIButton *buttonProjectilePower;
@property (nonatomic, strong) IBOutlet UIButton *buttonProjectileFireRate;
@property (nonatomic, strong) IBOutlet UIButton *buttonProjectileMoveSpeed;
@property (nonatomic, strong) IBOutlet UIButton *buttonProjectileUnstopable;
@property (nonatomic, strong) IBOutlet UIButton *buttonProjectileDarkMatter;

@property (nonatomic, assign) int score;
@property (nonatomic, assign) int scrap;
@property (nonatomic, strong) IBOutlet UILabel *projectileScoreLabel;
@property (nonatomic, strong) IBOutlet UILabel *upgradeScrapLabel;

@property (nonatomic, strong) IBOutlet UILabel *projectilePowerCost;
@property (nonatomic, strong) IBOutlet UILabel *projectileFirerateCost;
@property (nonatomic, strong) IBOutlet UILabel *projectileMoveSpeedCost;
@property (nonatomic, strong) IBOutlet UILabel *projectileUnstoppableCost;
@property (nonatomic, strong) IBOutlet UILabel *projectileDarkmMatterCost;

@property (nonatomic, strong) IBOutlet UILabel *upgradeHealthCost;
@property (nonatomic, strong) IBOutlet UILabel *upgradeFirerateCost;
@property (nonatomic, strong) IBOutlet UILabel *upgradeMoveSpeedCost;
@property (nonatomic, strong) IBOutlet UILabel *upgradePowerCost;
@property (nonatomic, strong) IBOutlet UILabel *upgradeRotSpeedCost;

@property (nonatomic, strong) IBOutlet UILabel *projectilePowerAmount;
@property (nonatomic, strong) IBOutlet UILabel *projectileFirerateAmount;
@property (nonatomic, strong) IBOutlet UILabel *projectileMoveSpeedAmount;
@property (nonatomic, strong) IBOutlet UILabel *projectileUnstoppableAmount;
@property (nonatomic, strong) IBOutlet UILabel *projectileDarkmMatterAmount;

@property (nonatomic, strong) IBOutlet UILabel *upgradeHealthAmount;
@property (nonatomic, strong) IBOutlet UILabel *upgradeFirerateAmount;
@property (nonatomic, strong) IBOutlet UILabel *upgradeMoveSpeedAmount;
@property (nonatomic, strong) IBOutlet UILabel *upgradePowerAmount;
@property (nonatomic, strong) IBOutlet UILabel *upgradeRotSpeedAmount;

@property (nonatomic, strong) NSMutableArray *projectileButtons;
@property (nonatomic, strong) NSMutableArray *projectileCostLabels;
@property (nonatomic, strong) NSMutableArray *projectileAmountLabels;

@property (nonatomic, strong) NSMutableArray *upgradeButtons;
@property (nonatomic, strong) NSMutableArray *upgradeCostLabels;
@property (nonatomic, strong) NSMutableArray *upgradeAmountLabels;

@property (nonatomic, strong) GameData *gameData;

- (MenuViewController *)init : (GameData *)gameData;
- (IBAction)tap:(id)sender;
- (void)saveGame;
- (void) loadProjectileViewData;
- (void) loadUpgradeViewData;
- (IBAction) projectileButtonTapped:(id)sender;
- (IBAction) projectileViewButtonTapped:(id) sender;
- (IBAction) upgradeButtonTapped:(id)sender;
- (void) visible;
-(IBAction)projectileMenuClosed:(id)sender;
-(IBAction)upgradeMenuClosed:(id)sender;
@end
