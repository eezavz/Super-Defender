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

@synthesize projectileViewButton;
@synthesize upgradeViewButton;

@synthesize gameData;

- (MenuViewController *)init : (GameData *)par_gameData
{
    gameData = par_gameData;
    return [super init];
}

- (void)viewDidAppear:(BOOL)animated
{
    upgradeViewButton.hidden = YES;
    if([self.delegate runningGame])
    {
        [projectileViewButton setEnabled:YES];
    }else{
        [projectileViewButton setEnabled:NO];
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //[self.view addSubview:menuView];
        self.view.backgroundColor = [UIColor clearColor];
        projectileView.backgroundColor = [UIColor clearColor];
        upgradeView.backgroundColor = [UIColor clearColor];
        NSString *imagePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/beloved.png"];
        UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
        if (image) {
            [self.selectedImage setImage:image];
            self.selectedImage.hidden = NO;
            self.selectedImageLabel.hidden = NO;
            self.doneSelecting.hidden = NO;
        } else {
            self.firstTime = YES;
            [self.view addSubview:self.pickImageView];
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
    }
    return self;
}

-(IBAction)projectileMenuClosed:(id)sender
{
    //[self.view removeFromSuperview];
    self.view = menuView;
}

-(IBAction)upgradeMenuClosed:(id)sender
{
    [self.view removeFromSuperview];
    self.view = menuView;
    [delegate menuClosed];
    [delegate createPlayfield];
}

- (void)tap:(id)sender
{
    if (sender == self.resumeKnop) {
        [self.view removeFromSuperview];
        [delegate menuClosed];
    }else if(sender == self.projectileBackButton || sender == self.upgradeBackButton)
    {
        [self projectileMenuClosed:nil];
    }else if (sender == self.imageKnop) {
        [self.view addSubview:self.pickImageView];
    } else if (sender == self.newgame) {
        [delegate newGame:self.selectedImage.image];
        upgradeViewButton.hidden = NO;
        self.view = upgradeView;
    } else if (sender == self.useCamera) {
        self.picker = [[UIImagePickerController alloc] init];
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
    [self.selectedImage setImage: [info objectForKey:UIImagePickerControllerEditedImage]];
    [self dismissViewControllerAnimated:YES completion:nil];
    self.selectedImage.hidden = NO;
    self.selectedImageLabel.hidden = NO;
    self.doneSelecting.hidden = NO;
}

//Tells the delegate that the user cancelled the pick operation.
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
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
    projectileScoreLabel.text = [NSString stringWithFormat:@"SCORE: %i", score];
    for(int i = 0; i<projectileButtons.count; i++)
    {
        UIButton *tempButton = [projectileButtons objectAtIndex:i];
        
        NSString *tempId = [tempButton restorationIdentifier];
        
        UILabel *tempLabelCost = [projectileCostLabels objectAtIndex:i];
        tempLabelCost.text = [NSString stringWithFormat:@"COST: %@", [[gameData.gameData objectForKey:tempId] objectForKey:@"cost"]];
            
        UILabel *tempLabelAmount = [projectileAmountLabels objectAtIndex:i];
        tempLabelAmount.text = [NSString stringWithFormat:@"UP: %@", [[gameData.gameData objectForKey:tempId] objectForKey:@"amount"]];
        //[tempId release];
    }
}

- (void) loadUpgradeViewData
{
    scrap = [[gameData.gameData objectForKey:@"Scrap"] intValue];
    upgradeScrapLabel.text = [NSString stringWithFormat:@"SCRAP: %i", scrap];
    for(int i = 0; i<upgradeButtons.count; i++)
    {
        UIButton *tempButton = [upgradeButtons objectAtIndex:i];
        NSString *tempId = [tempButton restorationIdentifier];
        
        UILabel *tempLabelCost = [upgradeCostLabels objectAtIndex:i];
        tempLabelCost.text = [NSString stringWithFormat:@"COST: %@", [[gameData.gameData objectForKey:tempId] objectForKey:@"cost"]];
        
        UILabel *tempLabelAmount = [upgradeAmountLabels objectAtIndex:i];
        tempLabelAmount.text = [NSString stringWithFormat:@"UP: %@", [[gameData.gameData objectForKey:tempId] objectForKey:@"amount"]];
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
            int tempCost = [[[gameData.gameData objectForKey:tempId] objectForKey:@"cost"] intValue];
            int tempAmount = [[[gameData.gameData objectForKey:tempId] objectForKey:@"amount"] intValue];
            if(score >= tempCost)
            {
                score -= tempCost;
                projectileScoreLabel.text = [NSString stringWithFormat:@"SCORE: %i", score];
                if(i == 0)
                {
                    tempAmount = tempAmount + 10;
                    [delegate updateActivatorTitle : i : tempAmount];
                }else if(i == 1)
                {
                    tempAmount = tempAmount + 30;
                    [delegate updateActivatorTitle : i : tempAmount];
                }else if(i == 2)
                {
                    tempAmount = tempAmount + 20;
                    [delegate updateActivatorTitle : i : tempAmount];
                }else if(i == 3)
                {
                    tempAmount = tempAmount + 1;
                    [delegate updateActivatorTitle : i : tempAmount];
                }else if(i == 4)
                {
                    tempAmount = tempAmount + 1;
                    [delegate updateActivatorTitle : i : tempAmount];
                }

                [[gameData.gameData objectForKey:tempId] setObject:[NSNumber numberWithInt:tempAmount] forKey:@"amount"];
            
                UILabel *tempLabelAmount = [projectileAmountLabels objectAtIndex:i];
                tempLabelAmount.text = [NSString stringWithFormat:@"UP: %i", tempAmount];
                [delegate updateScore:score];
            } else {
                NSLog(@"Silly guy, you don't have enough money...");
            }
        }
    }
    [self saveGame];
}

- (IBAction) upgradeButtonTapped:(id)sender
{
    NSString *tempId = [sender restorationIdentifier];
    for(int i = 0; i<upgradeButtons.count; i++)
    {
        if([upgradeButtons objectAtIndex:i] == sender)
        {
            int tempCost = [[[gameData.gameData objectForKey:tempId] objectForKey:@"cost"] intValue];
            int tempAmount = [[[gameData.gameData objectForKey:tempId] objectForKey:@"amount"] intValue];
            if(scrap >= tempCost && tempAmount < 4)
            {
                scrap = scrap - tempCost;
                upgradeScrapLabel.text = [NSString stringWithFormat:@"SCRAP: %i", scrap];
                
                tempCost = tempCost * 2;
                tempAmount = tempAmount + 1;
            
                [gameData.gameData setObject:[NSNumber numberWithInt:scrap] forKey:@"Scrap"];
                [[gameData.gameData objectForKey:tempId] setObject:[NSNumber numberWithInt:tempCost] forKey:@"cost"];
                [[gameData.gameData objectForKey:tempId] setObject:[NSNumber numberWithInt:tempAmount] forKey:@"amount"];
            
                UILabel *tempLabelCost = [upgradeCostLabels objectAtIndex:i];
                tempLabelCost.text = [NSString stringWithFormat:@"COST: %i", tempCost];
            
                UILabel *tempLabelAmount = [upgradeAmountLabels objectAtIndex:i];
                tempLabelAmount.text = [NSString stringWithFormat:@"UP: %i", tempAmount];
            }else{
                NSLog(@"Silly guy, you don't have enough money...");
            }
        }
    }
    [self saveGame];
}

- (void)saveGame
{
    [gameData saveGame];
}


- (void) visible
{
        [self loadProjectileViewData];
    [self loadUpgradeViewData];
    if ([delegate runningGame]) {
        [self.resumeKnop setEnabled:YES];
    } else {
        [self.resumeKnop setEnabled:NO];
    }
}

- (IBAction) projectileViewButtonTapped:(id) sender {
    //[self.view addSubview:emptyView];
    self.view = projectileView;
    //[menuView removeFromSuperview];
    //curView = projectileView;
}


@end
