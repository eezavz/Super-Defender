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

@property (atomic, retain) IBOutlet UIView *menuView;
@property (atomic, retain) IBOutlet UIView *upgradeView;

@property (atomic, retain) IBOutlet UIButton *buttonHealth;
@property (atomic, retain) IBOutlet UIButton *buttonFireRate;
@property (atomic, retain) IBOutlet UIButton *buttonmoveSpeed;
@property (atomic, retain) IBOutlet UIButton *buttonPower;
@property (atomic, retain) IBOutlet UIButton *buttonRotSpeed;

- (IBAction)tap:(id)sender;
- (IBAction) upgradeButtonTapped:(id) sender;
@end
