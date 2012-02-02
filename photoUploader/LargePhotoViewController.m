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
    
    arrayManager = [PhotoArrayManager sharedManager];
    
    PhotoScrollView.delegate = self;
    [PhotoScrollView setBackgroundColor:[UIColor blackColor]];
    
    myIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	myIndicator.center = CGPointMake(160, 220);
	myIndicator.hidesWhenStopped = YES;
    [PhotoScrollView addSubview:myIndicator];
    
    [super viewDidLoad];
    [self queueImage];
}

-(void)queueImage
{
    [myIndicator startAnimating];
    NSOperationQueue *queue = [NSOperationQueue new];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] 
                                        initWithTarget:self
                                        selector:@selector(loadImage) 
                                        object:nil];
    [queue addOperation:operation];
}

-(void)loadImage
{
    if (![arrayManager.largePhotoDict objectForKey:currentImage]) {
        UIImage *serverImage = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:currentImage]]];
        [arrayManager.largePhotoDict setObject:serverImage forKey:currentImage];
    }
    UIImage *image = [[UIImage alloc] init];
    image = [arrayManager.largePhotoDict objectForKey:currentImage];
    [self performSelectorOnMainThread:@selector(displayImage:) withObject:image waitUntilDone:NO];
}

-(void)displayImage:(UIImage *)image
{    
    imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(0, 0, imageView.image.size.width, imageView.image.size.height);
    CGSize photoSize = [image size];
    
    // Configure zooming.
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    
    CGFloat widthRatio = screenSize.width / image.size.width;
    
    CGFloat heightRatio = screenSize.height / image.size.height;
    
    CGFloat initialZoom = (widthRatio > heightRatio) ? heightRatio : widthRatio;
    
    [PhotoScrollView setMaximumZoomScale:3.0];
    [PhotoScrollView setMinimumZoomScale:initialZoom];
    [PhotoScrollView setZoomScale:initialZoom animated:NO];
    
    [PhotoScrollView setBouncesZoom:YES];
    [PhotoScrollView setClipsToBounds:YES];
    [PhotoScrollView setContentSize:CGSizeMake(photoSize.width * initialZoom,photoSize.height * initialZoom)];
    
    CGPoint scrollCenter = [PhotoScrollView center];    
    
    [imageView setCenter:CGPointMake(scrollCenter.x,
                                     scrollCenter.y-10)];
    
    [myIndicator stopAnimating];
    [PhotoScrollView addSubview:imageView];
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
