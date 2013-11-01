//
//  UpgradeViewController.m
//  Super Defender
//
//  Created by Furkan on 10/14/13.
//  Copyright (c) 2013 RoFuPaNi. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController
@synthesize delegate;
@synthesize menuView;
@synthesize upgradeView;

@synthesize buttonHealth;
@synthesize buttonFireRate;
@synthesize buttonmoveSpeed;
@synthesize buttonPower;
@synthesize buttonRotSpeed;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.view addSubview:menuView];
        self.view.backgroundColor = [UIColor clearColor];
        menuView.backgroundColor = [UIColor clearColor];
        upgradeView.backgroundColor = [UIColor clearColor];
        
        [buttonHealth setBackgroundImage:[UIImage imageNamed:@"health.png"] forState:UIControlStateNormal];
        [buttonFireRate setBackgroundImage:[UIImage imageNamed:@"rateOfFire.png"] forState:UIControlStateNormal];
        [buttonmoveSpeed setBackgroundImage:[UIImage imageNamed:@"moveSpeed.png"] forState:UIControlStateNormal];
        [buttonPower setBackgroundImage:[UIImage imageNamed:@"power.png"] forState:UIControlStateNormal];
        [buttonRotSpeed setBackgroundImage:[UIImage imageNamed:@"rotSpeed.png"] forState:UIControlStateNormal];
    }
    return self;
}

- (void)tap:(id)sender
{
    NSLog(@"Tappy");
    [self.view removeFromSuperview];
    [delegate menuClosed];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) upgradeButtonTapped:(id) sender {
    NSLog(@"Asdjke");
    //UpgradeViewController *mvc = [[UpgradeViewController alloc] init];
    //mvc.delegate = self;
    //pauseButton.hidden = YES;
    //scoreLabel.hidden = YES;
    //[self.view addSubview:mvc.view];
    //self.view = mvc.view;
    //self.view.hidden = YES;
    [self.view addSubview:upgradeView];
    [menuView removeFromSuperview];
    //self.view.frame = upgradeView.frame;
}


@end
