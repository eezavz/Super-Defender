//
//  MainViewController.m
//  Super Defender
//
//  Created by Furkan on 10/14/13.
//  Copyright (c) 2013 RoFuPaNi. All rights reserved.
//

#import "MainViewController.h"
#import "MenuViewController.h"
#import "Projectile.h"
#import <CoreMotion/CoreMotion.h>

@interface MainViewController ()
@property (strong, nonatomic) CMMotionManager *motionManager;
@property (nonatomic, assign) BOOL accelerometer;
@end

@implementation MainViewController

@synthesize playfield;
@synthesize slider;
@synthesize timer;
@synthesize cannonBody;
@synthesize cannonBarrel;
@synthesize projectileImage;
@synthesize renderedObjects;


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
    self.motionManager = [[CMMotionManager alloc] init];
    if (self.motionManager.accelerometerAvailable) {
        [self.motionManager stopAccelerometerUpdates];
        self.motionManager.accelerometerUpdateInterval = 1.0 / 60.0;
        [self.motionManager startAccelerometerUpdates];
        self.accelerometer = YES;
    } else {
        NSLog(@"Ik heb geen accelerometer!");
        self.accelerometer = NO;
    }
    /*if (self.motionManager.gyroAvailable) {
     [self.motionManager stopGyroUpdates];
     self.motionManager.gyroUpdateInterval = 1.0 / 60.0;
     [self.motionManager startGyroUpdates];
     } else {
     NSLog(@"Ik heb geen gyroscoop!");
     }*/
    
    self.renderedObjects = [[NSMutableArray alloc] init];
    
    self.enemyImage = [UIImage imageNamed:@"enemy"];
    //self.drawnEnemies = [[NSMutableArray alloc] init];
    
    self.projectileImage = [UIImage imageNamed:@"projectile.png"];
    //projectileCountdown = 50;
    //projectiles = [[NSMutableArray alloc]init];
    
    self.playfield = [[Playfield alloc]init];
    CGRect frame = CGRectMake(0.0f, 435.0f, 320.0f, 20.0f);
    if(!self.accelerometer) {
        slider = [[UISlider alloc]initWithFrame:frame];
        slider.minimumValue = 0;
        slider.maximumValue = 180;
        slider.value = 90;
    }
    
    cannonBarrel = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"barrel"]];
    cannonBarrel.frame = CGRectMake(52, 372, 216, 216);
    cannonBody = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"base"]];
    cannonBody.frame = CGRectMake(110, 380, 100, 100);
    
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
    background.frame = CGRectMake(0, 0, 320, 480);
    [self.view insertSubview:background atIndex:0];
    
    [self.view addSubview:cannonBarrel];
    [self.view addSubview:cannonBody];
    if(!self.accelerometer) {
        [self.view insertSubview:slider aboveSubview:cannonBody];
    }
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f/60.0f target:self selector:@selector(update:) userInfo:nil repeats:YES];
}

- (void)update:(NSTimer *)timer
{
    if(!self.accelerometer) {
        [playfield update:slider.value];
    } else {
        float x = self.motionManager.accelerometerData.acceleration.x;
        x = roundf(x*100)/100;
        float bla = 0.5 + x/3;
        [playfield update:bla*180];
    }
    [self render];
    //[self renderProjectiles];
    //[self collisionDetect];
}

- (void) render
{
    float angle = playfield.cannon.angle;
    CGAffineTransform trans = CGAffineTransformMakeRotation(degrees(angle));
    cannonBarrel.transform = trans;
    
    int objects = playfield.enemies.count + playfield.cannon.shotProjectiles.count;
    if(renderedObjects.count < objects) {
        int difference = objects-renderedObjects.count;
        for (int i = 0; i < difference; i++) {
            UIImageView *new = [[UIImageView alloc] init];
            
            //[new setImage:self.enemyImage];
            [renderedObjects addObject:new];
            [self.view addSubview:new];
        }
    }
    if(renderedObjects.count > objects) {
        int difference = renderedObjects.count - objects;
        for (int i = 0; i < difference; i++) {
            UIImageView *old = [renderedObjects objectAtIndex:0];
            [old removeFromSuperview];
            [renderedObjects removeObject:old];
            [old dealloc];
        }
    }
    
    int currentAmount = 0;
    int toLimit = playfield.enemies.count;
    for (int i = currentAmount; i < toLimit; i++) {
        UIImageView *current = [renderedObjects objectAtIndex:i];
        [current setImage:self.enemyImage];
        [current sizeToFit];
        current.center = CGPointMake([[playfield.enemies objectAtIndex:i-currentAmount] centerX], [[playfield.enemies objectAtIndex:i-currentAmount] centerY]);
        float rotation = [[playfield.enemies objectAtIndex:i-currentAmount] angle];
        CGAffineTransform rot = CGAffineTransformMakeRotation(degrees(rotation));
        current.transform = rot;
    }
    currentAmount += playfield.enemies.count;
    
    toLimit+=playfield.cannon.shotProjectiles.count;
    for (int i = currentAmount; i < toLimit; i++) {
        UIImageView *current = [renderedObjects objectAtIndex:i];
        [current setImage:self.projectileImage];
        [current sizeToFit];
        Projectile *meh = [playfield.cannon.shotProjectiles objectAtIndex:i-currentAmount];
        current.center = CGPointMake(meh.centerX, meh.centerY);
    }
    currentAmount += playfield.cannon.shotProjectiles.count;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
