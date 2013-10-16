//
//  MainViewController.m
//  Super Defender
//
//  Created by Furkan on 10/14/13.
//  Copyright (c) 2013 RoFuPaNi. All rights reserved.
//

#import "MainViewController.h"
#import "MenuViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize playfield;
@synthesize slider;
@synthesize timer;
@synthesize cannonBody;
@synthesize cannonBarrel;


#define degrees(x) (M_PI * (x) / 180)

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.playfield = [[Playfield alloc]init];
    CGRect frame = CGRectMake(0.0f, 435.0f, 320.0f, 20.0f);
    slider = [[UISlider alloc]initWithFrame:frame];
    //[self.view addSubview:slider];
    slider.minimumValue = 0;
    slider.maximumValue = 180;
    slider.value = 90;
    
    cannonBarrel = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"barrel"]];
    cannonBarrel.frame = CGRectMake(10, 330, 300, 300);
    cannonBody = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"base"]];
    cannonBody.frame = CGRectMake(110, 380, 100, 100);
    
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
    background.frame = CGRectMake(0, 0, 320, 480);
    [self.view insertSubview:background atIndex:0];
    
    [self.view addSubview:cannonBarrel];
    [self.view addSubview:cannonBody];
    [self.view insertSubview:slider aboveSubview:cannonBody];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f/60.0f target:self selector:@selector(update:) userInfo:nil repeats:YES];
}

- (void)update:(NSTimer *)timer
{
    [playfield update:slider.value];
    float angle = playfield.cannon.angle;
    CGAffineTransform trans = CGAffineTransformMakeRotation(degrees(angle));
    cannonBarrel.transform = trans;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
