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

#define degrees(x) (100 * x / M_PI)

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
    [self.view addSubview:slider];
    slider.minimumValue = 0;
    slider.maximumValue = 180;
    slider.value = 90;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f/30.0f target:self selector:@selector(update:) userInfo:nil repeats:YES];
}

- (void)update:(NSTimer *)timer
{
    [playfield update:slider.value];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
