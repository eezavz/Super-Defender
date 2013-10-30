//
//  MainViewController.m
//  Super Defender
//
//  Created by Furkan on 10/14/13.
//  Copyright (c) 2013 RoFuPaNi. All rights reserved.
//

#import "MainViewController.h"
#define degrees(x) (M_PI * (x) / 180)

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
@synthesize scoreLabel;
@synthesize damageImages;
@synthesize pauseButton;
@synthesize heartImage;
@synthesize objectButtons;
@synthesize gameData;

- (void) buttonTap:(id) sender {
    NSLog(@"Asdjke");
    [self stopTimer];
    self.mvc = [[MenuViewController alloc] init];
    self.mvc.delegate = self;
    pauseButton.hidden = YES;
    scoreLabel.hidden = YES;
    [self.view addSubview:self.mvc.view];
}

- (void) menuClosed
{
    NSLog(@"YESSSSSS");
    [self.mvc release];
    pauseButton.hidden = NO;
    scoreLabel.hidden = NO;
    [self startTimer];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NSLog(@"Loadyload!");
        
        NSFileManager *filemanager = [NSFileManager defaultManager];
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
        path = [path stringByAppendingPathComponent:@"GameData.plist"];
        
        if([filemanager fileExistsAtPath:path])
        {
            gameData = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
            NSLog(@"%@", [gameData objectForKey:@"Score"]);
        }else{
            NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"GameData" ofType:@"plist"];
            gameData = [[NSMutableDictionary alloc] initWithContentsOfFile:sourcePath];
            NSLog(@"%@", gameData);
            [self saveGame];
        }

        
        heartImage = [UIImage imageNamed:@"Heart"];
        damageImages = [[NSMutableArray alloc] init];
        for (int i = 0; i < 110; i += 10) {
            [damageImages addObject:[UIImage imageNamed:[[NSString alloc] initWithFormat:@"%d", i]]];
        }
        self.cannonHealth = [[UIImageView alloc] initWithImage:[damageImages objectAtIndex:10]];
        self.cannonHealth.frame = CGRectMake(0, 430, 320, 50);
        self.explosion = [UIImage imageNamed:@"Explosion"];
        self.bigExplosion = [UIImage imageNamed:@"BigExplosion"];
        
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
        self.objectButtons = [[NSMutableArray alloc]init];
        
        self.enemyImage = [UIImage imageNamed:@"enemy"];
        self.bossImage = [UIImage imageNamed:@"enemyboss"];
        
        self.projectileImage = [UIImage imageNamed:@"projectile.png"];
        self.enemyProjectileImage = [UIImage imageNamed:@"enemyprojectile.png"];
        
        self.playfield = [[Playfield alloc] init:gameData];
        cannonBarrel = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"barrel"]];
        cannonBarrel.frame = CGRectMake(52, 322, 216, 216);
        cannonBody = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"base"]];
        cannonBody.frame = CGRectMake(playfield.cannon.posX - playfield.cannon.width / 2, playfield.cannon.posY - playfield.cannon.height / 2, playfield.cannon.width, playfield.cannon.height);
        if(!self.accelerometer) {
            CGRect frame = CGRectMake(0.0f, 435.0f, 320.0f, 20.0f);
            slider = [[UISlider alloc]initWithFrame:frame];
            slider.minimumValue = 0;
            slider.maximumValue = 180;
            slider.value = 90;
        }
        
        UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
        background.frame = CGRectMake(0, 0, 320, 480);
        [self.view insertSubview:background atIndex:0];
        
        [self.view addSubview:cannonBarrel];
        [self.view addSubview:cannonBody];
        if(!self.accelerometer) {
            [self.view insertSubview:slider aboveSubview:cannonBody];
        }
        
        scoreLabel = [[UILabel alloc] init];
        scoreLabel.textColor = [UIColor yellowColor];
        scoreLabel.backgroundColor = [UIColor clearColor];
        scoreLabel.text = @"Score: 0";
        scoreLabel.frame = CGRectMake(0, 0, 320, 20);
        scoreLabel.textAlignment = NSTextAlignmentRight;
        pauseButton = [[UIButton alloc] init];
        [pauseButton setTitle:@"II" forState:UIControlStateNormal];
        pauseButton.backgroundColor = [UIColor redColor];
        pauseButton.frame = CGRectMake(0, 0, 20, 20);
        [pauseButton addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view insertSubview:scoreLabel aboveSubview:cannonBody];
        [self.view insertSubview:pauseButton belowSubview:scoreLabel];
        [self.view insertSubview:self.cannonHealth aboveSubview:scoreLabel];
    }
    return self;
}

- (void)saveGame
{
    [gameData writeToFile:[self givePath] atomically:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSString *)givePath
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    path = [path stringByAppendingPathComponent:@"GameData.plist"];
    return path;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)startTimer
{
    if (!timer) {
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0f/60.0f target:self selector:@selector(update:) userInfo:nil repeats:YES];
    }
}

- (void)stopTimer
{
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
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
    if (playfield.cannon.health == 0) {
        [self stopTimer];
        [gameData setValue:[NSNumber numberWithInt:playfield.score] forKey:@"Score"];
        [self saveGame];
    }
    [self render];
}

- (void) render
{
    float angle = playfield.cannon.angle;
    CGAffineTransform trans = CGAffineTransformMakeRotation(degrees(angle));
    cannonBarrel.transform = trans;
    
    int objects = (playfield.enemies.count * 2) + playfield.cannon.shotProjectiles.count + playfield.enemyProjectiles.count;
    if(renderedObjects.count < objects) {
        int difference = objects-renderedObjects.count;
        for (int i = 0; i < difference; i++) {
            UIImageView *new = [[UIImageView alloc] init];
            [renderedObjects addObject:new];
            [self.view insertSubview:new belowSubview:self.scoreLabel];
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
    int toLimit = playfield.enemies.count * 2;
    for (int i = currentAmount; i < toLimit-1; i += 2) {
        UIImageView *current = [renderedObjects objectAtIndex:i];
        if ([[playfield.enemies objectAtIndex:i/2] isMemberOfClass:[Enemy2 class]]) {
            if ([[playfield.enemies objectAtIndex:i/2] health] == 0) {
                [current setImage:self.bigExplosion];
            } else {
                [current setImage:self.bossImage];
            }
        } else {
            if ([[playfield.enemies objectAtIndex:i/2] health] == 0) {
                [current setImage:self.explosion];
            } else {
                [current setImage:self.enemyImage];
            }
        }
        [current sizeToFit];
        current.center = CGPointMake([[playfield.enemies objectAtIndex:i/2] centerX], [[playfield.enemies objectAtIndex:i/2] centerY]);
        float rotation = [[playfield.enemies objectAtIndex:i/2] angle];
        CGAffineTransform rot = CGAffineTransformMakeRotation(degrees(rotation));
        current.transform = rot;
        UIImageView *health = [renderedObjects objectAtIndex:i+1];
        health.transform = CGAffineTransformIdentity;
        int percentage = (float)[[playfield.enemies objectAtIndex:i/2] health] / (float)[[playfield.enemies objectAtIndex:i/2] maxHealth] * 100;
        [health setImage:[self.damageImages objectAtIndex:round(percentage/10)]];
        [health sizeToFit];
        health.center = CGPointMake([[playfield.enemies objectAtIndex:i/2] centerX], [[playfield.enemies objectAtIndex:i/2] centerY] + [[playfield.enemies objectAtIndex:i/2] height]/2 + 10);

    }
    currentAmount += playfield.enemies.count * 2;
    
    toLimit += playfield.cannon.shotProjectiles.count;
    for (int i = currentAmount; i < toLimit; i++) {
        UIImageView *current = [renderedObjects objectAtIndex:i];
        [current setImage:self.projectileImage];
        [current sizeToFit];
        float centerX = [[playfield.cannon.shotProjectiles objectAtIndex:i-currentAmount] centerX];
        float centerY = [[playfield.cannon.shotProjectiles objectAtIndex:i-currentAmount] centerY];
        current.center = CGPointMake(centerX, centerY);
    }
    currentAmount += playfield.cannon.shotProjectiles.count;
    
    
    toLimit += playfield.enemyProjectiles.count;
    for (int i = currentAmount; i < toLimit; i++) {
        UIImageView *current = [renderedObjects objectAtIndex:i];
        [current setImage:self.enemyProjectileImage];
        [current sizeToFit];
        float centerX = [[playfield.enemyProjectiles objectAtIndex:i-currentAmount] centerX];
        float centerY = [[playfield.enemyProjectiles objectAtIndex:i-currentAmount] centerY];
        current.center = CGPointMake(centerX, centerY);
    }
    currentAmount += playfield.enemyProjectiles.count;
    [scoreLabel setText:[[NSString alloc] initWithFormat:@"Score: %d", playfield.score]];
    float percentage = (float)playfield.cannon.health / (float)playfield.cannon.maxHealth * 100;
    self.cannonHealth.image = [damageImages objectAtIndex:percentage/10];
    
    if(playfield.objects.count > self.objectButtons.count)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake([[playfield.objects objectAtIndex:playfield.objects.count-1]centerX]-20, [[playfield.objects objectAtIndex:playfield.objects.count-1]centerY]-20, 40, 40);
        [button addTarget:self action:@selector(objectPressed:) forControlEvents:UIControlEventTouchDown];
        [button setImage:heartImage forState:UIControlStateNormal];
        [self.objectButtons addObject:button];
        [self.view addSubview:button];
    }
    
    if(playfield.objects.count < self.objectButtons.count) {
        int diff = self.objectButtons.count - playfield.objects.count;
        for (int i = 0; i < diff; i++) {
            UIButton *delete = [self.objectButtons objectAtIndex:i];
            [self.objectButtons delete:delete];
            [delete removeFromSuperview];
            [delete dealloc];
        }
    }
    
    for(int i = 0; i<self.objectButtons.count; i++)
    {
        if([[playfield.objects objectAtIndex:i] centerY] <450)
        {
            [[self.objectButtons objectAtIndex:i] setCenter:CGPointMake([[playfield.objects objectAtIndex:i] centerX], [[playfield.objects objectAtIndex:i] centerY])];
        }
    }
}

- (IBAction) objectPressed:(id)sender
{
    for(int i = 0; i<playfield.objects.count; i++)
    {
        if(sender == [objectButtons objectAtIndex:i])
        {
            [objectButtons removeObject:sender];
            [sender removeFromSuperview];
            [sender release];
            Heart *tempObject = [playfield.objects objectAtIndex:i];
            [playfield.cannon gainHealth:tempObject.health];
            [playfield.objects removeObject:tempObject];
            [tempObject dealloc];
            i--;
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dealloc
{
    NSLog(@"MainViewController dealloc");
    [self.playfield dealloc];
    [self.slider dealloc];
    if (self.timer) {
        [self.timer dealloc];
    }
    [self.cannonBody dealloc];
    [self.cannonBarrel dealloc];
    [self.enemyImage dealloc];
    [self.projectileImage dealloc];
    [self.enemyProjectileImage dealloc];
    [self.renderedObjects dealloc];
    [self.scoreLabel dealloc];
    [self.damageImages dealloc];
    [self.explosion dealloc];
    [self.bossImage dealloc];
    [self.cannonHealth dealloc];
    [self.pauseButton dealloc];
    [self.heartImage dealloc];
    [super dealloc];
}

@end
