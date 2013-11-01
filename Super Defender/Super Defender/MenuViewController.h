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
- (BOOL)runningGame;
- (void)newGame:(UIImage *)beloved;
- (void)menuClosed;
@end

@interface MenuViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet UIButton *resumeKnop;
@property (strong, nonatomic) IBOutlet UIButton *imageKnop;
@property (strong, nonatomic) IBOutlet UIButton *useCamera;
@property (strong, nonatomic) IBOutlet UIButton *useLibrary;
@property (strong, nonatomic) IBOutlet UIButton *doneSelecting;
@property (strong, nonatomic) IBOutlet UIButton *newgame;
@property (assign) id <MenuViewControllerDelegate> delegate;
@property (atomic, retain) IBOutlet UIView *menuView;
@property (atomic, retain) IBOutlet UIView *upgradeView;
@property (nonatomic, strong) IBOutlet UIView *pickImageView;
@property (nonatomic, strong) UIImagePickerController *picker;
@property (nonatomic, strong) IBOutlet UIImageView *selectedImage;
@property (nonatomic, strong) IBOutlet UILabel *selectedImageLabel;
@property (nonatomic, assign) BOOL firstTime;


- (IBAction)tap:(id)sender;
- (IBAction) upgradeButtonTapped:(id) sender;
- (void) visible;
@end
