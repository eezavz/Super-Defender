//
//  UpgradeViewController.h
//  Super Defender
//
//  Created by Furkan on 10/31/13.
//  Copyright (c) 2013 RoFuPaNi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UpgradeViewControllerDelegate <NSObject>
- (void)menuClosed;
@end

@interface UpgradeViewController : UIViewController
@property (assign) id <UpgradeViewControllerDelegate> delegate;

@end
