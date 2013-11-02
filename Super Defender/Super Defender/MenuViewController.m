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

@synthesize projectilePowerCost;
@synthesize projectileFirerateCost;
@synthesize projectileMoveSpeedCost;
@synthesize projectileUnstoppableCost;
@synthesize projectileDarkmMatterCost;

@synthesize upgradeHealthCost;
@synthesize upgradeFirerateCost;
@synthesize upgradeMoveSpeedCost;
@synthesize upgradePowerCost;
@synthesize upgradeRotSpeedCost;

@synthesize projectilePowerAmount;
@synthesize projectileFirerateAmount;
@synthesize projectileMoveSpeedAmount;
@synthesize projectileUnstoppableAmount;
@synthesize projectileDarkmMatterAmount;

@synthesize upgradeHealthAmount;
@synthesize upgradeFirerateAmount;
@synthesize upgradeMoveSpeedAmount;
@synthesize upgradePowerAmount;
@synthesize upgradeRotSpeedAmount;

@synthesize buttons;
@synthesize costLabels;
@synthesize upLabels;

@synthesize gameData;

- (MenuViewController *)init : (NSMutableDictionary *)par_gameData
{
    gameData = par_gameData;
    return [super init];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //curView = menuView;
        [self.view addSubview:menuView];
        self.view.backgroundColor = [UIColor clearColor];
        menuView.backgroundColor = [UIColor clearColor];
        projectileView.backgroundColor = [UIColor clearColor];
        upgradeView.backgroundColor = [UIColor clearColor];
        NSString *imagePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/beloved.png"];
        UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
        if (image) {
            NSLog(@"Yay!");
            [self.selectedImage setImage:image];
            self.selectedImage.hidden = NO;
            self.selectedImageLabel.hidden = NO;
            self.doneSelecting.hidden = NO;
        } else {
            NSLog(@"Boo!");
            self.firstTime = YES;
            //[self.view addSubview:self.pickImageView];
        }
        
//        [buttonUpgradeHealth setBackgroundImage:[UIImage imageNamed:@"health.png"] forState:UIControlStateNormal];
//        [buttonUpgradeFireRate setBackgroundImage:[UIImage imageNamed:@"rateOfFire.png"] forState:UIControlStateNormal];
//        [buttonUpgradeMoveSpeed setBackgroundImage:[UIImage imageNamed:@"moveSpeed.png"] forState:UIControlStateNormal];
//        [buttonUpgradePower setBackgroundImage:[UIImage imageNamed:@"power.png"] forState:UIControlStateNormal];
//        [buttonUpgradeRotSpeed setBackgroundImage:[UIImage imageNamed:@"rotSpeed.png"] forState:UIControlStateNormal];
        
        //[buttonProjectilePower setBackgroundImage:[UIImage imageNamed:@"Ppower.png"] forState:UIControlStateNormal];
//        [buttonProjectileFireRate setBackgroundImage:[UIImage imageNamed:@"PrateOfFire.png"] forState:UIControlStateNormal];
//        [buttonProjectileMoveSpeed setBackgroundImage:[UIImage imageNamed:@"PmoveSpeed.png"] forState:UIControlStateNormal];
//        [buttonProjectileUnstopable setBackgroundImage:[UIImage imageNamed:@"Punstoppable.png"] forState:UIControlStateNormal];
//        [buttonProjectileDarkMatter setBackgroundImage:[UIImage imageNamed:@"PdarkMatter.png"] forState:UIControlStateNormal];
        
        buttons = [[NSMutableArray alloc]init];
        [buttons addObject:buttonProjectilePower];
        [buttons addObject:buttonProjectileFireRate];
        [buttons addObject:buttonProjectileMoveSpeed];
        [buttons addObject:buttonProjectileUnstopable];
        [buttons addObject:buttonProjectileDarkMatter];
        
        costLabels = [[NSMutableArray alloc]init];
        [costLabels addObject:projectilePowerCost];
        [costLabels addObject:projectileFirerateCost];
        [costLabels addObject:projectileMoveSpeedCost];
        [costLabels addObject:projectileUnstoppableCost];
        [costLabels addObject:projectileDarkmMatterCost];
        
        costLabels = [[NSMutableArray alloc]init];
        [costLabels addObject:projectilePowerCost];
        [costLabels addObject:projectileFirerateCost];
        [costLabels addObject:projectileMoveSpeedCost];
        [costLabels addObject:projectileUnstoppableCost];
        [costLabels addObject:projectileDarkmMatterCost];
        
        upLabels = [[NSMutableArray alloc]init];
        [upLabels addObject:projectilePowerAmount];
        [upLabels addObject:projectileFirerateAmount];
        [upLabels addObject:projectileMoveSpeedAmount];
        [upLabels addObject:projectileUnstoppableAmount];
        [upLabels addObject:projectileDarkmMatterAmount];
        
        [self loadData];
    }
    return self;
}

- (void)tap:(id)sender
{
    NSLog(@"Tappy");
    if (sender == self.resumeKnop) {
        [self.view removeFromSuperview];
        [delegate menuClosed];
    } else if (sender == self.imageKnop) {
        [self.view addSubview:self.pickImageView];
    } else if (sender == self.newgame) {
        NSLog(@"EEP");
        [delegate newGame:self.selectedImage.image];
        [self.view removeFromSuperview];
        [delegate menuClosed];
        NSLog(@"MEEP");
    } else if (sender == self.useCamera) {
        self.picker = [[UIImagePickerController alloc] init];
        //self.picker.delegate = self;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            self.picker.allowsEditing = YES;
            self.picker.delegate = self;
            [self presentViewController:self.picker animated:YES completion:nil];
            [self.picker release];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"You have no camera silly!" delegate:nil cancelButtonTitle:@"Ok..." otherButtonTitles: nil];
            [alert show];
            [alert release];
        }
    } else if (sender == self.useLibrary) {
        self.picker = [[UIImagePickerController alloc] init];
        //self.picker.delegate = self;
        self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        self.picker.allowsEditing = YES;
        self.picker.delegate = self;
        [self presentViewController:self.picker animated:YES completion:nil];
        [self.picker release];
    } else if (sender == self.doneSelecting) {
        [self.pickImageView removeFromSuperview];
        NSString  *pngPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/beloved.png"];
        [UIImagePNGRepresentation(self.selectedImage.image) writeToFile:pngPath atomically:YES];
        if (self.firstTime) {
            [delegate newGame:self.selectedImage.image];
            [self.view removeFromSuperview];
            [delegate menuClosed];
        }
    }
}

//Tells the delegate that the user picked a still image or movie.
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"Hey!");
    [self.selectedImage setImage: [info objectForKey:UIImagePickerControllerEditedImage]];
    [self dismissViewControllerAnimated:YES completion:nil];
    self.selectedImage.hidden = NO;
    self.selectedImageLabel.hidden = NO;
    self.doneSelecting.hidden = NO;
}

//Tells the delegate that the user cancelled the pick operation.
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"Hi!");
    [self dismissViewControllerAnimated:YES completion:nil];
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

- (IBAction) upgradeButtonTapped:(id)sender
{
    NSString *tempId = [sender restorationIdentifier];
    NSLog(@"ID: %@", tempId);
}

- (void) loadData
{
    for(int i = 0; i<buttons.count; i++)
    {
        UIButton *tempButton = [buttons objectAtIndex:i];
        NSString *tempId = [tempButton restorationIdentifier];
        
        UILabel *tempLabelCost = [costLabels objectAtIndex:i];
        tempLabelCost.text = [NSString stringWithFormat:@"COST: %@", [[gameData objectForKey:tempId] objectForKey:@"cost"]];
            
        UILabel *tempLabelAmount = [upLabels objectAtIndex:i];
        tempLabelAmount.text = [NSString stringWithFormat:@"UP: %@", [[gameData objectForKey:tempId] objectForKey:@"amount"]];
        //[tempId release];
    }
}

- (IBAction) projectileButtonTapped:(id)sender
{
    NSString *tempId = [sender restorationIdentifier];
    for(int i = 0; i<buttons.count; i++)
    {
        if([buttons objectAtIndex:i] == sender)
        {
            NSNumber *cost = [[gameData objectForKey:tempId] objectForKey:@"cost"];
            cost = [NSNumber numberWithInt:[cost intValue]+10];
            
            NSNumber *amount = [[gameData objectForKey:tempId] objectForKey:@"amount"];
            amount = [NSNumber numberWithInt:[amount intValue]+1];
            
            [[gameData objectForKey:tempId] setObject:cost forKey:@"cost"];
            [[gameData objectForKey:tempId] setObject:amount forKey:@"amount"];
            
            UILabel *tempLabelCost = [costLabels objectAtIndex:i];
            tempLabelCost.text = [NSString stringWithFormat:@"COST: %@", cost];
            
            UILabel *tempLabelAmount = [upLabels objectAtIndex:i];
            tempLabelAmount.text = [NSString stringWithFormat:@"UP: %@", amount];
        }
    }
    //[tempId release];
    [self saveGame];
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

- (IBAction) upgradeViewButtonTapped:(id) sender {
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

- (void) visible
{
    if ([delegate runningGame]) {
        self.resumeKnop.hidden = NO;
    } else {
        self.resumeKnop.hidden = YES;
    }
}

- (IBAction) projectileViewButtonTapped:(id) sender {
    //[self.view addSubview:emptyView];
    [self.view addSubview:projectileView];
    [menuView removeFromSuperview];
    //curView = projectileView;
}


@end
