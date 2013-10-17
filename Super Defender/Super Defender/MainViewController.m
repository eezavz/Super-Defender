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
@synthesize projectileCountdown;
@synthesize projectiles;
@synthesize projectileImage;


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
    
    self.enemyImage = [UIImage imageNamed:@"enemy"];
    self.drawnEnemies = [[NSMutableArray alloc] init];
    
    self.projectileImage = [UIImage imageNamed:@"projectile.png"];
    projectileCountdown = 50;
    projectiles = [[NSMutableArray alloc]init];
    
    self.playfield = [[Playfield alloc]init];
    CGRect frame = CGRectMake(0.0f, 435.0f, 320.0f, 20.0f);
    slider = [[UISlider alloc]initWithFrame:frame];
    //[self.view addSubview:slider];
    slider.minimumValue = 0;
    slider.maximumValue = 180;
    slider.value = 90;
    
    cannonBarrel = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"barrel"]];
    cannonBarrel.frame = CGRectMake(52, 372, 216, 216);
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
    [self render];
    [self renderProjectiles];
    [self collisionDetect];
}

- (void) render
{
    float angle = playfield.cannon.angle;
    CGAffineTransform trans = CGAffineTransformMakeRotation(degrees(angle));
    cannonBarrel.transform = trans;
    
    if(self.drawnEnemies.count < playfield.enemies.count) {
        int toAdd = playfield.enemies.count - self.drawnEnemies.count;
        for (int i = 0; i < toAdd; i++) {
            UIImageView *temp = [[UIImageView alloc] initWithImage:self.enemyImage];
            [self.drawnEnemies addObject:temp];
            [self.view addSubview:temp];
        }
    }
    if(self.drawnEnemies.count > playfield.enemies.count) {
        int toDelete = self.drawnEnemies.count - playfield.enemies.count;
        for (int i = 0; i < toDelete; i++) {
            UIImageView *temp = [self.drawnEnemies objectAtIndex:0];
            [temp removeFromSuperview];
            [self.drawnEnemies removeObject:temp];
            [temp dealloc];
        }
    }
    
    for (int i = 0; i < playfield.enemies.count; i++) {
        UIImageView *temp = [self.drawnEnemies objectAtIndex:i];
        temp.center = CGPointMake([[playfield.enemies objectAtIndex:i] x], [[playfield.enemies objectAtIndex:i] y]);
        float rotation = [[playfield.enemies objectAtIndex:i] angle];
        CGAffineTransform rot = CGAffineTransformMakeRotation(degrees(rotation));
        temp.transform = rot;
    }
}

- (int) distanceFromPoint:(int)p2x : (int)p2y : (int)p1x : (int)p1y
{
    int xDist = (p1x - p2x);
    int yDist = (p1y - p2y);
    return sqrt((xDist * xDist) + (yDist * yDist));
}

- (void) collisionDetect
{
    for(int i = 0; i<projectiles.count; i++)
    {
        UIImageView *tempImage = [projectiles objectAtIndex:i];
        //NSLog(@"Enemies count: %i", playfield.enemies.count);
        for(int b = 0; b<playfield.enemies.count; b++)
        {
            if([self distanceFromPoint:[[playfield.enemies objectAtIndex:b] x] :[[playfield.enemies objectAtIndex:b] y] :tempImage.frame.origin.x : tempImage.frame.origin.y] < 35)
            {
                [tempImage removeFromSuperview];
                [tempImage release];
                [projectiles removeObjectAtIndex:i];
                [playfield.enemies removeObjectAtIndex:b];
                b--;
                i--;
                break;
            }
        }
    }
}

- (void) renderProjectiles
{
    int test = slider.value-90;
    projectileCountdown--;
    for(int i = 0; i<projectiles.count; i++)
    {
        UIImageView *tempImage = [projectiles objectAtIndex:i];
        tempImage.center = CGPointMake(tempImage.frame.origin.x+tempImage.frame.size.width/2+test/3.6, tempImage.frame.origin.y+tempImage.frame.size.height/2-12);
    }
    
    if(projectileCountdown < 0)
    {
        UIImageView *tempImage = [[UIImageView alloc] initWithImage:self.projectileImage];
        [projectiles addObject:tempImage];
        [self.view addSubview:tempImage];
        tempImage.center = CGPointMake(cannonBody.frame.origin.x+cannonBody.frame.size.width/2, cannonBody.frame.origin.y+cannonBody.frame.size.height/2+38.5);
        projectileCountdown = 50;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
