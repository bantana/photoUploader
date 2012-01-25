//
//  UploadViewController.m
//  photoUploader
//
//  Created by Kerry Happle on 1/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UploadViewController.h"

@implementation UploadViewController
@synthesize myButton;

@synthesize imageView,UserID;


-(IBAction)uploadPhotoPressed:(id)sender
{    
    if (selectedPhoto) {
        [self uploadPhoto];
    } else {
        UIActionSheet *actionSheet = 
        [[UIActionSheet alloc] initWithTitle:@"Choose Source" 
                                delegate:self
                       cancelButtonTitle:@"Cancel"
                  destructiveButtonTitle:nil 
                       otherButtonTitles:@"Take Photo", @"Choose Photo", nil];
        [actionSheet showFromTabBar:self.tabBarController.tabBar];
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex 
{
    switch (buttonIndex) {
        case 0: {
            [self getCameraPicture];
            break;
        } case 1: {
            [self selectExitingPicture];
            break;
        } case 2: {
            [myButton setTitle:@"Choose Photo" forState:UIControlStateNormal];
           /* NSString *msgStr = [NSString stringWithFormat: @"Got that UserID to the second view! UserID: %@", UserID];        
            
            UIAlertView *alertsuccess = [[UIAlertView alloc] 
                                         initWithTitle:@"Congrats" 
                                         message:msgStr
                                         delegate:self 
                                         cancelButtonTitle:@"OK" 
                                         otherButtonTitles:nil, nil];
            
            [alertsuccess show];*/
            
            break;
        }
    }
}


-(void)getCameraPicture 
{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentModalViewController: picker animated:YES];
}

-(void)selectExitingPicture 
{
    if([UIImagePickerController isSourceTypeAvailable:
        UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController *picker= [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentModalViewController:picker animated:YES];
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker
      didFinishPickingImage : (UIImage *)image
                 editingInfo:(NSDictionary *)editingInfo
{
    [picker dismissModalViewControllerAnimated:YES];
    imageView.image = image;
    selectedPhoto = true;
    [myButton setTitle:@"Upload Photo" forState:UIControlStateNormal];
}

-(void)uploadPhoto{
    NSData *imageData = UIImagePNGRepresentation(imageView.image);
    NSString *pathWithUserID = [[NSString alloc] initWithFormat:@"http://www.robinsdigital.com/IOSdev/uploader.php?userID=%@",UserID];
    NSURL *server = [NSURL URLWithString:pathWithUserID];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    
    (void)[[EPUploader alloc] initWithURL:server
                               file:imageData
                           delegate:self
                       doneSelector:@selector(onUploadDone:)
                      errorSelector:@selector(onUploadError:)];
    selectedPhoto = false;
}

-(void)onUploadDone:(NSString *)UploadStatus
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Upload Status"
                                                    message:@"Upload Successful!" 
                                                   delegate:self 
                                          cancelButtonTitle:@"Ok" 
                                          otherButtonTitles:nil];
    [alert show];
    [myButton setTitle:@"Choose Photo" forState:UIControlStateNormal];
}

-(void)onUploadError 
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Upload Status"
                                                    message:@"Upload Failed" 
                                                   delegate:self 
                                          cancelButtonTitle:@"Ok" 
                                          otherButtonTitles:nil];
    [alert show];
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)  picker
{
    [picker dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    UserID = [[NSString alloc] initWithFormat:@"%i",[defaults integerForKey:@"UserID"]];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setMyButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
