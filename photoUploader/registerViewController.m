//
//  registerViewController.m
//  photoUploader
//
//  Created by Kerry Happle on 1/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "registerViewController.h"

@implementation registerViewController

@synthesize userNameField,passWordField,registerButton;

- (IBAction)registerUser:(id)sender
{
    NSString *post =[NSString stringWithFormat:@"userName=%@&passWord=%@",userNameField.text, passWordField.text];
    
    if ([userNameField.text length] > 0 && [passWordField.text length] > 0) {
        
        NSString *hostStr =[NSString stringWithFormat:@"https://robinsdigital.com/IOSdev/register.php?"];
        hostStr = [hostStr stringByAppendingString:post];
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
        NSData *dataURL =  [NSData dataWithContentsOfURL: [ NSURL URLWithString: hostStr ]];    
        NSString *serverOutput = [[NSString alloc] initWithData:dataURL encoding: NSASCIIStringEncoding];
        
        NSLog(@"%@",serverOutput);
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if([serverOutput isEqualToString:@"user created"]){
            
            NSString *msgStr = [NSString stringWithFormat: @"User was created successfully!"];        
             
             UIAlertView *alertsuccess = [[UIAlertView alloc] 
             initWithTitle:@"Congrats" 
             message:msgStr
             delegate:self 
             cancelButtonTitle:@"OK" 
             otherButtonTitles:nil, nil];
             
             [alertsuccess show];
            
        } else if ([serverOutput isEqualToString:@"user exists"]) {
            UIAlertView *alertFail = [[UIAlertView alloc] initWithTitle:@"Error" message:@"User already exists."
                                                               delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertFail show];
            
        } else {
            
        }
    }

}

-(IBAction)back:(id)sender
{
    [self performSegueWithIdentifier:@"backToLogin" sender:sender];
}

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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
