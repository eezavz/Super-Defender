//
//  MainViewController.h
//  Super Defender
//
//  Created by Furkan on 10/14/13.
//  Copyright (c) 2013 RoFuPaNi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Playfield.h"

@interface MainViewController : UIViewController

@property (atomic, retain) Playfield *playfield;
@property (atomic, retain) UISlider *slider;
@property (atomic, retain) NSTimer * timer;

- (void)update:(NSTimer *)timer;

@end
