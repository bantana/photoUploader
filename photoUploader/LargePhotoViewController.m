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
    /*float minimumScale = [PhotoScrollView frame].size.width  / [imageView frame].size.width;
    [PhotoScrollView setMinimumZoomScale:minimumScale];
    [PhotoScrollView setZoomScale:minimumScale];
    [PhotoScrollView setMaximumZoomScale:10];
    [PhotoScrollView setContentSize:CGSizeMake(imageView.image.size.width * minimumScale, imageView.image.size.height * minimumScale)];
    // Center the photo. Again we push the center point up by 44 pixels
    // to account for the translucent navigation bar.
    CGPoint scrollCenter = [PhotoScrollView center];
    [imageView setCenter:CGPointMake(scrollCenter.x, scrollCenter.y - 44.0)];

    PhotoScrollView.delegate = self;
    [PhotoScrollView setScrollEnabled:YES];
    [PhotoScrollView setContentSize:imageView.frame.size];*/
    CGSize photoSize = [image size];
    NSLog(@"photosize = %@",NSStringFromCGSize(photoSize));
    // Configure zooming.
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    NSLog(@"screenSize = %@",NSStringFromCGSize(screenSize));
    CGFloat widthRatio = screenSize.width / image.size.width;
    NSLog(@"widthRatio = %f",widthRatio);
    CGFloat heightRatio = screenSize.height / image.size.height;
    NSLog(@"heightRatio = %f",heightRatio);
    CGFloat initialZoom = (widthRatio > heightRatio) ? heightRatio : widthRatio;
    NSLog(@"initialZoom = %f",initialZoom);
    PhotoScrollView.delegate = self;
    [PhotoScrollView setBackgroundColor:[UIColor blackColor]];
    [PhotoScrollView setMaximumZoomScale:3.0];
    [PhotoScrollView setMinimumZoomScale:initialZoom];
    [PhotoScrollView setZoomScale:initialZoom animated:NO];
    NSLog(@"current zoomScale: %f", PhotoScrollView.zoomScale);
    [PhotoScrollView setBouncesZoom:YES];
    [PhotoScrollView setContentSize:CGSizeMake(photoSize.width * initialZoom,
                                          photoSize.height * initialZoom)];
    NSLog(@"PhotoScrollView setContentSize = %@", NSStringFromCGSize(CGSizeMake(photoSize.width * initialZoom,
                                                                photoSize.height * initialZoom)));
    
    // Center the photo. Again we push the center point up by 44 pixels
    // to account for the translucent navigation bar.
    CGPoint scrollCenter = [PhotoScrollView center];
    [imageView setCenter:CGPointMake(scrollCenter.x,
                                     scrollCenter.y-60)];
    NSLog(@"imageView setCenter = %@", NSStringFromCGPoint(CGPointMake(scrollCenter.x,
                                                   scrollCenter.y-60)));
    [PhotoScrollView addSubview:imageView];
    
    
    
    /*UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You touched me!"
                                                    message:[NSString stringWithFormat:@"image: %@",currentImage]
                                                   delegate:self 
                                          cancelButtonTitle:@"Ok" 
                                          otherButtonTitles:nil];
    [alert show];*/
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
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
    [self dismissModalViewControllerAnimated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
