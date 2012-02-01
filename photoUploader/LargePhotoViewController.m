//
//  LargePhotoViewController.m
//  photoUploader
//
//  Created by Kerry Happle on 1/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LargePhotoViewController.h"

@implementation LargePhotoViewController
@synthesize dismiss;
@synthesize PhotoScrollView,imageView,currentImage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadImage];
}

-(void)loadImage
{
    UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:currentImage]]];

    imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(0, 0, imageView.image.size.width, imageView.image.size.height);
    float minimumScale = [PhotoScrollView frame].size.width  / [imageView frame].size.width;
    [PhotoScrollView setMinimumZoomScale:minimumScale];
    [PhotoScrollView setZoomScale:minimumScale];
    [PhotoScrollView setMaximumZoomScale:10];
    //[PhotoScrollView setContentMode:UIViewContentModeScaleAspectFit];
    //[imageView sizeToFit];
    PhotoScrollView.delegate = self;
    [PhotoScrollView setScrollEnabled:YES];
    [PhotoScrollView setContentSize:imageView.frame.size];
    [PhotoScrollView addSubview:imageView];
    
    /*UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You touched me!"
                                                    message:[NSString stringWithFormat:@"image: %@",currentImage]
                                                   delegate:self 
                                          cancelButtonTitle:@"Ok" 
                                          otherButtonTitles:nil];
    [alert show];*/
}

- (void)viewDidUnload
{
    [self setPhotoScrollView:nil];
    [self setDismiss:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(IBAction)backButton
{
    NSLog(@"here");
    [self dismissModalViewControllerAnimated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
