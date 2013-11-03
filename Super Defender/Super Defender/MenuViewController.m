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

@synthesize projectileButtons;
@synthesize projectileCostLabels;
@synthesize projectileAmountLabels;

@synthesize upgradeButtons;
@synthesize upgradeCostLabels;
@synthesize upgradeAmountLabels;
@synthesize scrap;

@synthesize projectileScoreLabel;
@synthesize upgradeScrapLabel;
@synthesize score;

@synthesize gameData;

- (MenuViewController *)init : (NSMutableDictionary *)par_gameData
{
    //score = 1001;
    gameData = par_gameData;
    scrap = [[NSNumber alloc] init];
    scrap = [gameData objectForKey:@"Scrap"];
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
        
        projectileButtons = [[NSMutableArray alloc]init];
        [projectileButtons addObject:buttonProjectilePower];
        [projectileButtons addObject:buttonProjectileFireRate];
        [projectileButtons addObject:buttonProjectileMoveSpeed];
        [projectileButtons addObject:buttonProjectileUnstopable];
        [projectileButtons addObject:buttonProjectileDarkMatter];
        
        projectileCostLabels = [[NSMutableArray alloc]init];
        [projectileCostLabels addObject:projectilePowerCost];
        [projectileCostLabels addObject:projectileFirerateCost];
        [projectileCostLabels addObject:projectileMoveSpeedCost];
        [projectileCostLabels addObject:projectileUnstoppableCost];
        [projectileCostLabels addObject:projectileDarkmMatterCost];
        
        projectileAmountLabels = [[NSMutableArray alloc]init];
        [projectileAmountLabels addObject:projectilePowerAmount];
        [projectileAmountLabels addObject:projectileFirerateAmount];
        [projectileAmountLabels addObject:projectileMoveSpeedAmount];
        [projectileAmountLabels addObject:projectileUnstoppableAmount];
        [projectileAmountLabels addObject:projectileDarkmMatterAmount];
        
        upgradeButtons = [[NSMutableArray alloc]init];
        [upgradeButtons addObject:buttonUpgradeHealth];
        [upgradeButtons addObject:buttonUpgradeFireRate];
        [upgradeButtons addObject:buttonUpgradeMoveSpeed];
        [upgradeButtons addObject:buttonUpgradePower];
        [upgradeButtons addObject:buttonUpgradeRotSpeed];
        
        upgradeCostLabels = [[NSMutableArray alloc]init];
        [upgradeCostLabels addObject:upgradeHealthCost];
        [upgradeCostLabels addObject:upgradeFirerateCost];
        [upgradeCostLabels addObject:upgradeMoveSpeedCost];
        [upgradeCostLabels addObject:upgradePowerCost];
        [upgradeCostLabels addObject:upgradeRotSpeedCost];
        
        upgradeAmountLabels = [[NSMutableArray alloc]init];
        [upgradeAmountLabels addObject:upgradeHealthAmount];
        [upgradeAmountLabels addObject:upgradeFirerateAmount];
        [upgradeAmountLabels addObject:upgradeMoveSpeedAmount];
        [upgradeAmountLabels addObject:upgradePowerAmount];
        [upgradeAmountLabels addObject:upgradeRotSpeedAmount];
        
        [self loadProjectileViewData];
        [self loadUpgradeViewData];
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

- (void) loadProjectileViewData
{
    //projectileScrapLabel = [gameData objectForKey:@"Scrap"];
    projectileScoreLabel.text = [NSString stringWithFormat:@"SCORE: %i", score];
    for(int i = 0; i<projectileButtons.count; i++)
    {
        UIButton *tempButton = [projectileButtons objectAtIndex:i];
        NSString *tempId = [tempButton restorationIdentifier];
        
        UILabel *tempLabelCost = [projectileCostLabels objectAtIndex:i];
        tempLabelCost.text = [NSString stringWithFormat:@"COST: %@", [[gameData objectForKey:tempId] objectForKey:@"cost"]];
            
        UILabel *tempLabelAmount = [projectileAmountLabels objectAtIndex:i];
        tempLabelAmount.text = [NSString stringWithFormat:@"UP: %@", [[gameData objectForKey:tempId] objectForKey:@"amount"]];
        //[tempId release];
    }
}

- (void) loadUpgradeViewData
{
    upgradeScrapLabel.text = [NSString stringWithFormat:@"SCRAP: %@", scrap];
    for(int i = 0; i<upgradeButtons.count; i++)
    {
        UIButton *tempButton = [upgradeButtons objectAtIndex:i];
        NSString *tempId = [tempButton restorationIdentifier];
        
        UILabel *tempLabelCost = [upgradeCostLabels objectAtIndex:i];
        tempLabelCost.text = [NSString stringWithFormat:@"COST: %@", [[gameData objectForKey:tempId] objectForKey:@"cost"]];
        
        UILabel *tempLabelAmount = [upgradeAmountLabels objectAtIndex:i];
        tempLabelAmount.text = [NSString stringWithFormat:@"UP: %@", [[gameData objectForKey:tempId] objectForKey:@"amount"]];
        //[tempId release];
    }
}

- (IBAction) projectileButtonTapped:(id)sender
{
    NSString *tempId = [sender restorationIdentifier];
    for(int i = 0; i<projectileButtons.count; i++)
    {
        if([projectileButtons objectAtIndex:i] == sender)
        {
            NSNumber *tempCost = [[gameData objectForKey:tempId] objectForKey:@"cost"];
            NSNumber *tempAmount = [[gameData objectForKey:tempId] objectForKey:@"amount"];
            if(score > [tempCost intValue])
            {
                score -= [tempCost intValue];
                projectileScoreLabel.text = [NSString stringWithFormat:@"SCORE: %i", score];
                tempAmount = [NSNumber numberWithInt:[tempAmount intValue]+10];
            
                //[[gameData objectForKey:tempId] setObject:cost forKey:@"cost"];
                [[gameData objectForKey:tempId] setObject:tempAmount forKey:@"amount"];
            
                //UILabel *tempLabelCost = [projectileCostLabels objectAtIndex:i];
                //tempLabelCost.text = [NSString stringWithFormat:@"COST: %@", cost];
            
                UILabel *tempLabelAmount = [projectileAmountLabels objectAtIndex:i];
                tempLabelAmount.text = [NSString stringWithFormat:@"UP: %@", tempAmount];
            }else{
                NSLog(@"Silly guy, you don't have enough money...");
            }
        }
    }
    //[tempId release];
    [self saveGame];
}

- (IBAction) upgradeButtonTapped:(id)sender
{
    NSString *tempId = [sender restorationIdentifier];
    //NSNumber *tempScrap = [gameData objectForKey:@"Scrap"];
    for(int i = 0; i<upgradeButtons.count; i++)
    {
        if([upgradeButtons objectAtIndex:i] == sender)
        {
            NSNumber *tempCost = [[gameData objectForKey:tempId] objectForKey:@"cost"];
            NSNumber *tempAmount = [[gameData objectForKey:tempId] objectForKey:@"amount"];
            if([scrap intValue] > [tempCost intValue])
            {
                scrap = [NSNumber numberWithInt:[scrap intValue] - [tempCost intValue]];
                upgradeScrapLabel.text = [NSString stringWithFormat:@"SCRAP: %@", scrap];
                
                tempCost = [NSNumber numberWithInt:[tempCost intValue]*2];
                tempAmount = [NSNumber numberWithInt:[tempAmount intValue]+1];
            
                [gameData setObject:scrap forKey:@"Scrap"];
                [[gameData objectForKey:tempId] setObject:tempCost forKey:@"cost"];
                [[gameData objectForKey:tempId] setObject:tempAmount forKey:@"amount"];
            
                UILabel *tempLabelCost = [upgradeCostLabels objectAtIndex:i];
                tempLabelCost.text = [NSString stringWithFormat:@"COST: %@", tempCost];
            
                UILabel *tempLabelAmount = [upgradeAmountLabels objectAtIndex:i];
                tempLabelAmount.text = [NSString stringWithFormat:@"UP: %@", tempAmount];
            }else{
                NSLog(@"Silly guy, you don't have enough money...");
            }
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
