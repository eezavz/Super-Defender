//
//  UpgradeViewController.h
//  Super Defender
//
//  Created by Furkan on 10/14/13.
//  Copyright (c) 2013 RoFuPaNi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuViewControllerDelegate <NSObject>
- (void)menuClosed;
@end

@interface MenuViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *knop;
@property (assign) id <MenuViewControllerDelegate> delegate;

- (IBAction)tap:(id)sender;
@end
