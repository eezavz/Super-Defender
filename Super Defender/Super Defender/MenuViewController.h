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

- (IBAction)tap:(id)sender;
- (IBAction) upgradeButtonTapped:(id) sender;
@end
