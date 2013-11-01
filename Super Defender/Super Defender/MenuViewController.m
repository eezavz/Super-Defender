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
@synthesize upgradeView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.view addSubview:menuView];
        self.view.backgroundColor = [UIColor clearColor];
        menuView.backgroundColor = [UIColor clearColor];
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
            [self.view addSubview:self.pickImageView];
        }
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

- (IBAction) upgradeButtonTapped:(id) sender {
    NSLog(@"Asdjke");
    //UpgradeViewController *mvc = [[UpgradeViewController alloc] init];
    //mvc.delegate = self;
    //pauseButton.hidden = YES;
    //scoreLabel.hidden = YES;
    //[self.view addSubview:mvc.view];
    //self.view = mvc.view;
    //self.view.hidden = YES;
    [self.view addSubview:upgradeView];
    [menuView removeFromSuperview];
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


@end
