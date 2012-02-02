//
//  PhotoViewController.m
//  photoUploader
//
//  Created by Kerry Happle on 1/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PhotoViewController.h"
#import "PhotoArrayManager.h"
#import "LargePhotoViewController.h"
#import "SBJson.h"


@implementation PhotoViewController

@synthesize currentImageTag;

-(void)buttonPressed:(id)sender
{
    
    currentImage = [arrayManager.thumbPhotoArray objectAtIndex:[sender tag]];
    
    currentImage = [currentImage stringByReplacingOccurrencesOfString:@"_thb"
                                                           withString:@""];
    
    
    [self performSegueWithIdentifier:@"displayLargePhoto" sender:currentImage];
    
    /*UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You touched me!"
     message:[NSString stringWithFormat:@"Image: %i",[sender tag]]
     delegate:self 
     cancelButtonTitle:@"Ok" 
     otherButtonTitles:nil];
     [alert show];*/
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"displayLargePhoto"]) {
        LargePhotoViewController *lpvc = (LargePhotoViewController *)segue.destinationViewController;
        NSLog(@"%@",currentImage);
        lpvc.currentImage = currentImage;
    }
}

-(void)getPhotos
{    
    [myIndicator startAnimating];
    
    NSString *post =[NSString stringWithFormat:@"?userID=%@",UserID];
    
    NSString *hostStr =[NSString stringWithFormat:@"https://robinsdigital.com/IOSdev/getPhotos.php"];
    hostStr = [hostStr stringByAppendingString:post];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSData *dataURL =  [NSData dataWithContentsOfURL: [ NSURL URLWithString: hostStr ]];    
    NSString *serverOutput = [[NSString alloc] initWithData:dataURL encoding: NSASCIIStringEncoding];
    
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    //JSON = [parser objectWithString:serverOutput error:nil];
    
    //AppDelegate *dataCenter = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    //dataCenter.PhotoDict = [[NSDictionary alloc] initWithDictionary:JSON];
    
   // NSLog(@"%@",dataCenter.PhotoDict);
    
    arrayManager = [PhotoArrayManager sharedManager];
    arrayManager.thumbPhotoArray = [parser objectWithString:serverOutput error:nil];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    NSOperationQueue *queue = [NSOperationQueue new];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] 
                                        initWithTarget:self
                                        selector:@selector(loadImage) 
                                        object:nil];
    [queue addOperation:operation];
}

- (void)loadImage 
{
    NSEnumerator *enumerator = [arrayManager.thumbPhotoArray objectEnumerator];
    
    id key;

     while ((key = [enumerator nextObject])) {
         UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:key]]];
         blockImage = [UIButton buttonWithType:UIButtonTypeCustom];
         [blockImage setTag:[arrayManager.thumbPhotoArray indexOfObject:key]];
         
         [self performSelectorOnMainThread:@selector(displayImage:) withObject:image waitUntilDone:NO];
     }
}


- (void)displayImage:(UIImage *)image// currentX:(int)curX currentY:(int)curY
{
    CGRect blockFrame;
    blockFrame.size = CGSizeMake(thumbSize,thumbSize);
    blockFrame.origin = CGPointMake(currentX,currentY);
    
    blockImage.frame = blockFrame;
    //blockImage = [[MyImageView alloc] initWithFrame:blockFrame];
    
    //blockImage.userInteractionEnabled = YES;
    [blockImage setImage:image forState:UIButtonTypeCustom];
    
    [blockImage setBackgroundColor:[UIColor blackColor]];
    [blockImage addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [myScrollView insertSubview:blockImage belowSubview:myIndicator]; //UIImageView
    
    currentX = currentX + thumbSize + padding;
    [photoCount setText:[NSString stringWithFormat:@"%i photos",i]];
    
    if ((currentX >= screenBounds.size.width) && i!=[arrayManager.thumbPhotoArray count]) {
        currentX = padding;
        currentY = currentY + padding + thumbSize;
        [myScrollView setContentSize:CGSizeMake(myScrollView.frame.size.width, (currentY + thumbSize + (padding*3) + photoCount.frame.size.height))];
        photoCount.frame = CGRectMake(((screenBounds.size.width/2) - 36), (currentY + thumbSize + padding), 150, 30);
    }else if (i==[arrayManager.thumbPhotoArray count]){
        [myIndicator stopAnimating];
    }
    i++;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    i=1;  //Tracker variable used for dropping down to next row of thumbs and expanding the view.
    padding = 4;
    currentX = padding;
    currentY = padding;
    thumbSize=75;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    UserID = [[NSString alloc] initWithFormat:@"%i",[defaults integerForKey:@"UserID"]];
    
    [myScrollView setScrollEnabled:YES];
    [myScrollView setContentSize:CGSizeMake(screenBounds.size.width, screenBounds.size.height)];
    [myScrollView setClipsToBounds:YES];
        
    screenBounds = [[UIScreen mainScreen] bounds];
    photoCount = [[UILabel alloc] init];
    photoCount.frame = CGRectMake(((screenBounds.size.width/2) - 36), (currentY + thumbSize + padding), 150, 30);
    [photoCount setBackgroundColor:[UIColor clearColor]];
    [photoCount setText:@"0 photos"];
    [myScrollView addSubview:photoCount];
   
    myIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	myIndicator.center = CGPointMake(160, 180);
	myIndicator.hidesWhenStopped = YES;
    [myScrollView addSubview:myIndicator];
    
    [self getPhotos];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{    
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
