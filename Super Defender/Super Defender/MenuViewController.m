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
@synthesize curView;
@synthesize emptyView;
@synthesize menuView;
@synthesize projectileView;
@synthesize upgradeView;

@synthesize buttonUpgradeHealth;
@synthesize buttonUpgradeFireRate;
@synthesize buttonUpgradeMoveSpeed;
@synthesize buttonUpgradePower;
@synthesize buttonUpgradeRotSpeed;

@synthesize buttonProjectilePower;
@synthesize buttonProjectileFireRate;
@synthesize buttonProjectileMoveSpeed;
@synthesize buttonProjectileUnstopable;
@synthesize buttonProjectileDarkMatter;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //curView = menuView;
        [self.view addSubview:menuView];
        self.view.backgroundColor = [UIColor clearColor];
        menuView.backgroundColor = [UIColor clearColor];
        upgradeView.backgroundColor = [UIColor clearColor];
        
        [buttonUpgradeHealth setBackgroundImage:[UIImage imageNamed:@"health.png"] forState:UIControlStateNormal];
        [buttonUpgradeFireRate setBackgroundImage:[UIImage imageNamed:@"rateOfFire.png"] forState:UIControlStateNormal];
        [buttonUpgradeMoveSpeed setBackgroundImage:[UIImage imageNamed:@"moveSpeed.png"] forState:UIControlStateNormal];
        [buttonUpgradePower setBackgroundImage:[UIImage imageNamed:@"power.png"] forState:UIControlStateNormal];
        [buttonUpgradeRotSpeed setBackgroundImage:[UIImage imageNamed:@"rotSpeed.png"] forState:UIControlStateNormal];
        
        [buttonProjectilePower setBackgroundImage:[UIImage imageNamed:@"Ppower.png"] forState:UIControlStateNormal];
        [buttonProjectileFireRate setBackgroundImage:[UIImage imageNamed:@"PrateOfFire.png"] forState:UIControlStateNormal];
        [buttonProjectileMoveSpeed setBackgroundImage:[UIImage imageNamed:@"PmoveSpeed.png"] forState:UIControlStateNormal];
        [buttonProjectileUnstopable setBackgroundImage:[UIImage imageNamed:@"Punstoppable.png"] forState:UIControlStateNormal];
        [buttonProjectileDarkMatter setBackgroundImage:[UIImage imageNamed:@"PdarkMatter.png"] forState:UIControlStateNormal];
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
    //[self.view addSubview:emptyView];
    [self.view addSubview:upgradeView];
    [menuView removeFromSuperview];
    //curView = upgradeView;
    //self.view.frame = upgradeView.frame;
}

- (IBAction) projectileButtonTapped:(id) sender {
    //[self.view addSubview:emptyView];
    [self.view addSubview:projectileView];
    [menuView removeFromSuperview];
    //curView = projectileView;
}


@end
