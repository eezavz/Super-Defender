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
@synthesize defaultProjectileImage;
@synthesize renderedObjects;
@synthesize scoreLabel;
@synthesize damageImages;
@synthesize pauseButton;
@synthesize heartImage;
@synthesize objectButtons;
@synthesize gameData;
@synthesize powerProjectileActivator;
@synthesize frequentProjectileActivator;
@synthesize lightningProjectileActivator;
@synthesize unstoppableProjectileActivator;
@synthesize darkMatterProjectileActivator;

- (void) buttonTap:(id) sender {
    NSNumber *tempNumber = [[NSNumber alloc]init];
    NSString *tempString;
    if (sender == self.pauseButton) {
        [self stopTimer];
        self.mvc.score = playfield.score+499;
        self.mvc.projectileScoreLabel.text = [NSString stringWithFormat:@"SCORE: %i", playfield.score+499];
        pauseButton.hidden = YES;
        scoreLabel.hidden = YES;
        self.mvc.upgradeViewButton.hidden = YES;
        self.mvc.projectileViewButton.hidden = NO;
        [self.view addSubview:self.mvc.view];
        [self.mvc visible];
    } else if (sender == self.powerProjectileActivator) {
        if (self.playfield.cannon.specialProjectile == 0) {
            tempNumber = [[gameData.gameData objectForKey:@"projectilePower"] objectForKey:@"amount"];
    
            if([tempNumber intValue] >= 10)
            {
                self.playfield.cannon.specialProjectile = 1;
                int tempInt = [tempNumber intValue];
                [[gameData.gameData objectForKey:@"projectilePower"] setObject:[NSNumber numberWithInt:tempInt-10] forKey:@"amount"];
                tempString = [NSString stringWithFormat:@"%i", tempInt-10];
                [powerProjectileActivator setTitle:[NSString stringWithFormat:@"%i", tempInt-10] forState:UIControlStateNormal];
                self.playfield.cannon.specialAmount = 10;
                [self saveGame];
            }
        }
    } else if (sender == self.frequentProjectileActivator) {
        if (self.playfield.cannon.specialProjectile == 0) {
            tempNumber = [[gameData.gameData objectForKey:@"projectileFireRate"] objectForKey:@"amount"];
            if([tempNumber intValue] >= 30)
            {
                self.playfield.cannon.specialProjectile = 2;
                int tempInt = [tempNumber intValue];
                [[gameData.gameData objectForKey:@"projectileFireRate"] setObject:[NSNumber numberWithInt:tempInt-30] forKey:@"amount"];
                [frequentProjectileActivator setTitle:[NSString stringWithFormat:@"%i", tempInt-30] forState:UIControlStateNormal];
                self.playfield.cannon.specialAmount = 30;
                [self saveGame];
            }
        }
    } else if (sender == self.lightningProjectileActivator) {
        if (self.playfield.cannon.specialProjectile == 0) {
            tempNumber = [[gameData.gameData objectForKey:@"projectileMoveSpeed"] objectForKey:@"amount"];
            if([tempNumber intValue] >= 20)
            {
                self.playfield.cannon.specialProjectile = 3;
                int tempInt = [tempNumber intValue];
                [[gameData.gameData objectForKey:@"projectileMoveSpeed"] setObject:[NSNumber numberWithInt:tempInt-20] forKey:@"amount"];
                [lightningProjectileActivator setTitle:[NSString stringWithFormat:@"%i", tempInt-20] forState:UIControlStateNormal];
                self.playfield.cannon.specialAmount = 20;
                [self saveGame];
            }
        }
    } else if (sender == self.unstoppableProjectileActivator) {
        if (self.playfield.cannon.specialProjectile == 0) {
            tempNumber = [[gameData.gameData objectForKey:@"projectileUnstoppable"] objectForKey:@"amount"];
            if([tempNumber intValue] >= 1)
            {
                self.playfield.cannon.specialProjectile = 4;
                int tempInt = [tempNumber intValue];
                [[gameData.gameData objectForKey:@"projectileUnstoppable"] setObject:[NSNumber numberWithInt:tempInt-1] forKey:@"amount"];
                [unstoppableProjectileActivator setTitle:[NSString stringWithFormat:@"%i", tempInt-1] forState:UIControlStateNormal];
                self.playfield.cannon.specialAmount = 1;
                [self saveGame];
            }
        }
    } else if (sender == self.darkMatterProjectileActivator) {
        if (self.playfield.cannon.specialProjectile == 0) {
            tempNumber = [[gameData.gameData objectForKey:@"projectileDarkMatter"] objectForKey:@"amount"];
            if([tempNumber intValue] >=1 )
            {
                self.playfield.cannon.specialProjectile = 5;
                int tempInt = [tempNumber intValue];
                [[gameData.gameData objectForKey:@"projectileDarkMatter"] setObject:[NSNumber numberWithInt:tempInt-1] forKey:@"amount"];
                [darkMatterProjectileActivator setTitle:[NSString stringWithFormat:@"%i", tempInt-1] forState:UIControlStateNormal];
                self.playfield.cannon.specialAmount = 1;
                [self saveGame];
            }
        }
    }
}

- (void) menuClosed
{
    pauseButton.hidden = NO;
    scoreLabel.hidden = NO;
    powerProjectileActivator.hidden = NO;
    frequentProjectileActivator.hidden = NO;
    lightningProjectileActivator.hidden = NO;
    unstoppableProjectileActivator.hidden = NO;
    darkMatterProjectileActivator.hidden = NO;
    
    [self startTimer];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        gameData = [[GameData alloc] init];
        heartImage = [UIImage imageNamed:@"DefenderHeart"];
        damageImages = [[NSMutableArray alloc] init];
        for (int i = 0; i < 110; i += 10) {
            [damageImages addObject:[UIImage imageNamed:[[NSString alloc] initWithFormat:@"%d", i]]];
        }
        self.cannonHealth = [[UIImageView alloc] initWithImage:[damageImages objectAtIndex:10]];
        self.cannonHealth.frame = CGRectMake(0, 430, 320, 10);
        self.explosion = [UIImage imageNamed:@"Explosion"];
        self.bigExplosion = [UIImage imageNamed:@"BigExplosion"];
        
        self.motionManager = [[CMMotionManager alloc] init];
        if (self.motionManager.accelerometerAvailable) {
            [self.motionManager stopAccelerometerUpdates];
            self.motionManager.accelerometerUpdateInterval = 1.0 / 30.0;
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
        self.objectButtons = [[NSMutableArray alloc] init];
        
        self.enemyImage = [UIImage imageNamed:@"EasyEnemy"];
        self.bossImage = [UIImage imageNamed:@"HardEnemy"];
        
        self.defaultProjectileImage = [UIImage imageNamed:@"NormalProjectile.png"];
        self.powerProjectileImage = [UIImage imageNamed:@"PowerProjectile.png"];
        self.frequentProjectileImage = [UIImage imageNamed:@"FrequentProjectile.png"];
        self.lightningProjectileImage = [UIImage imageNamed:@"LightningProjectile.png"];
        self.unstoppableProjectileImage = [UIImage imageNamed:@"UnstoppableProjectile.png"];
        self.darkMatterProjectileImage = [UIImage imageNamed:@"DarkMatterProjectile.png"];
        self.enemyProjectileImage = [UIImage imageNamed:@"EnemyProjectile.png"];
        
        
        cannonBarrel = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"barrel"]];
        cannonBarrel.frame = CGRectMake(52, 322, 216, 216);
        cannonBody = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"base"]];
        
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
        [pauseButton setImage:[UIImage imageNamed:@"pauzebutton"] forState:UIControlStateNormal];
        pauseButton.frame = CGRectMake(0, 0, 40, 40);
        [pauseButton addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
        
        self.beloved = [[UIImageView alloc] initWithFrame:CGRectMake(140, 390, 40, 40)];
        self.beloved.hidden = YES;
        
        [self.view insertSubview:scoreLabel aboveSubview:cannonBody];
        [self.view insertSubview:pauseButton belowSubview:scoreLabel];
        [self.view insertSubview:self.cannonHealth aboveSubview:scoreLabel];
        [self.view insertSubview:self.beloved aboveSubview:cannonBody];
        
        powerProjectileActivator = [[UIButton alloc] initWithFrame:CGRectMake(75, 445, 30, 30)];
        frequentProjectileActivator = [[UIButton alloc] initWithFrame:CGRectMake(110, 445, 30, 30)];
        lightningProjectileActivator = [[UIButton alloc] initWithFrame:CGRectMake(145, 445, 30, 30)];
        unstoppableProjectileActivator = [[UIButton alloc] initWithFrame:CGRectMake(180, 445, 30, 30)];
        darkMatterProjectileActivator = [[UIButton alloc] initWithFrame:CGRectMake(215, 445, 30, 30)];
        
        [powerProjectileActivator setBackgroundImage:[UIImage imageNamed:@"Ppower"] forState:UIControlStateNormal];
        [frequentProjectileActivator setBackgroundImage:[UIImage imageNamed:@"PrateOfFire"] forState:UIControlStateNormal];
        [lightningProjectileActivator setBackgroundImage:[UIImage imageNamed:@"PmoveSpeed"] forState:UIControlStateNormal];
        [unstoppableProjectileActivator setBackgroundImage:[UIImage imageNamed:@"Punstoppable"] forState:UIControlStateNormal];
        [darkMatterProjectileActivator setBackgroundImage:[UIImage imageNamed:@"PdarkMatter"] forState:UIControlStateNormal];
        
        [powerProjectileActivator addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
        [frequentProjectileActivator addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
        [lightningProjectileActivator addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
        [unstoppableProjectileActivator addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
        [darkMatterProjectileActivator addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
        
        [powerProjectileActivator setTitle:[NSString stringWithFormat:@"0"] forState:UIControlStateNormal];
        [frequentProjectileActivator setTitle:[NSString stringWithFormat:@"0"] forState:UIControlStateNormal];
        [lightningProjectileActivator setTitle:[NSString stringWithFormat:@"0"] forState:UIControlStateNormal];
        [unstoppableProjectileActivator setTitle:[NSString stringWithFormat:@"0"] forState:UIControlStateNormal];
        [darkMatterProjectileActivator setTitle:[NSString stringWithFormat:@"0"] forState:UIControlStateNormal];
        
        [self.view addSubview:powerProjectileActivator];
        [self.view addSubview:frequentProjectileActivator];
        [self.view addSubview:lightningProjectileActivator];
        [self.view addSubview:unstoppableProjectileActivator];
        [self.view addSubview:darkMatterProjectileActivator];
        
        self.mvc = [[MenuViewController alloc] init : (GameData *)gameData];
        self.mvc.delegate = self;
        pauseButton.hidden = YES;
        scoreLabel.hidden = YES;
        cannonBarrel.hidden = YES;
        cannonBody.hidden = YES;
        
        powerProjectileActivator.hidden = YES;
        frequentProjectileActivator.hidden = YES;
        lightningProjectileActivator.hidden = YES;
        unstoppableProjectileActivator.hidden = YES;
        darkMatterProjectileActivator.hidden = YES;
        
        self.cannonHealth.hidden = YES;
        [self.view addSubview:self.mvc.view];
        [self.mvc visible];
    }
    return self;
}

- (void)updateActivatorTitle :(int)par_number :(int)par_amount
{
    if(par_number == 0)
    {
        [powerProjectileActivator setTitle:[NSString stringWithFormat:@"%i", par_amount] forState:UIControlStateNormal];
    }else if (par_number == 1)
    {
        [frequentProjectileActivator setTitle:[NSString stringWithFormat:@"%i", par_amount] forState:UIControlStateNormal];
    }else if(par_number == 2)
    {
        [lightningProjectileActivator setTitle:[NSString stringWithFormat:@"%i", par_amount] forState:UIControlStateNormal];
    }else if(par_number == 3)
    {
        [unstoppableProjectileActivator setTitle:[NSString stringWithFormat:@"%i", par_amount] forState:UIControlStateNormal];
    }else if(par_number)
    {
        [darkMatterProjectileActivator setTitle:[NSString stringWithFormat:@"%i", par_amount] forState:UIControlStateNormal];
    }
}

- (BOOL)runningGame
{
    if (playfield) {
        return YES;
    } else {
        return NO;
    }
}

- (void) newGame:(UIImage *)beloved
{
    if (self.playfield) {
        [playfield release];
    }
    if (self.objectButtons) {
        for (int i = 0; i < self.objectButtons.count; i++) {
            UIButton *delete = [self.objectButtons objectAtIndex:i];
            [delete removeFromSuperview];
            [delete release];
        }
        [self.objectButtons removeAllObjects];
    } else {
        self.objectButtons = [[NSMutableArray alloc] init];
    }
    
    
    self.beloved.image = beloved;
    cannonBarrel.hidden = NO;
    cannonBody.hidden = NO;
    self.cannonHealth.hidden = NO;
    self.beloved.hidden = NO;
}

-(void)createPlayfield
{
    NSNumber *tempHealth = [[gameData.gameData objectForKey:@"upgradeHealth"] objectForKey:@"amount"];
    NSNumber *tempFireRate = [[gameData.gameData objectForKey:@"upgradeFireRate"] objectForKey:@"amount"];
    NSNumber *tempMoveSpeed = [[gameData.gameData objectForKey:@"upgradeMoveSpeed"] objectForKey:@"amount"];
    NSNumber *tempPower = [[gameData.gameData objectForKey:@"upgradePower"] objectForKey:@"amount"];
    NSNumber *tempRotSpeed = [[gameData.gameData objectForKey:@"upgradeRotSpeed"] objectForKey:@"amount"];
    NSLog(@"UpgradeWaarde: %i", [tempFireRate intValue]);
    self.playfield = [[Playfield alloc] init : [tempHealth intValue] : [tempFireRate intValue] : [tempMoveSpeed intValue] : [tempPower intValue] : [tempRotSpeed intValue]];
    cannonBody.frame = CGRectMake(playfield.cannon.posX - playfield.cannon.width / 2, playfield.cannon.posY - playfield.cannon.height / 2, playfield.cannon.width, playfield.cannon.height);
}

- (void)saveGame
{
    [gameData saveGame];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)startTimer
{
    if (!timer) {
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0f/30.0f target:self selector:@selector(update:) userInfo:nil repeats:YES];
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
        [gameData.gameData setValue:[NSNumber numberWithInt:playfield.score] forKey:@"Score"];
        [self saveGame];
        self.mvc.upgradeViewButton.hidden = NO;
        [self.view addSubview:self.mvc.view];
        [self.mvc visible];
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
            [self.view insertSubview:new belowSubview:self.pauseButton];
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
        if ([[playfield.cannon.shotProjectiles objectAtIndex:i-currentAmount] isMemberOfClass:[DefaultProjectile class]]) {
            [current setImage:self.defaultProjectileImage];
        } else if ([[playfield.cannon.shotProjectiles objectAtIndex:i-currentAmount] isMemberOfClass:[PowerProjectile class]]) {
            [current setImage:self.powerProjectileImage];
        } else if ([[playfield.cannon.shotProjectiles objectAtIndex:i-currentAmount] isMemberOfClass:[FrequentProjectile class]]) {
            [current setImage:self.frequentProjectileImage];
        } else if ([[playfield.cannon.shotProjectiles objectAtIndex:i-currentAmount] isMemberOfClass:[LightningProjectile class]]) {
            [current setImage:self.lightningProjectileImage];
        } else if ([[playfield.cannon.shotProjectiles objectAtIndex:i-currentAmount] isMemberOfClass:[UnstoppableProjectile class]]) {
            [current setImage:self.unstoppableProjectileImage];
        } else if ([[playfield.cannon.shotProjectiles objectAtIndex:i-currentAmount] isMemberOfClass:[DarkMatterProjectile class]]) {
            [current setImage:self.darkMatterProjectileImage];
        }
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
    [self.playfield dealloc];
    [self.slider dealloc];
    if (self.timer) {
        [self.timer dealloc];
    }
    [self.cannonBody dealloc];
    [self.cannonBarrel dealloc];
    [self.enemyImage dealloc];
    [self.defaultProjectileImage dealloc];
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
