//
//  loginViewController.m
//  loginTest
//
//  Created by Kerry Happle on 1/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "loginViewController.h"
#import "LoginModel.h"

@interface loginViewController()
@property (nonatomic, strong) LoginModel *loginModel;
@end

@implementation loginViewController

@synthesize userNameField,passWordField,loginButton,registerButton;
@synthesize loginModel = _loginModel;

-(LoginModel *)loginModel
{
    if (!_loginModel) _loginModel = [[LoginModel alloc] init];
    return _loginModel;
}


-(IBAction)login:(id)sender
{
    if ([userNameField.text length] > 0 && [passWordField.text length] > 0) {   
        [self.loginModel receiveLoginCredentials:userNameField.text:passWordField.text];
        _loginModel.delegate = self;
        [myIndicator startAnimating];
    }
}

- (void)loginSucceeded:(NSMutableArray *)JSON {
    
    [myIndicator stopAnimating];
    
    if ([[JSON valueForKey:@"Connected"] isEqualToString:@"Yes"]){
        [self performSegueWithIdentifier:@"tabBarController" sender:self];
    } else if ([[JSON valueForKey:@"Connected"] isEqualToString:@"No"]) {
        UIAlertView *alertFail = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Username or Password Incorrect"
                                                           delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertFail show];

    }
}

- (void)loginFailed:(NSString *)failedMessage {
    //deal with failure here
    NSLog(@"failure");
}

         

- (IBAction)registerButton:(id)sender
{
    [self performSegueWithIdentifier:@"registerSegue" sender:sender];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField.tag == 1){
        [userNameField resignFirstResponder];
        [passWordField becomeFirstResponder];
    }
    else if (textField.tag == 2){
        [passWordField resignFirstResponder];
        [self login:(id)self];
    }
    return YES;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    userNameField.delegate = (id)self;
    passWordField.delegate = (id)self;
    
    userNameField.tag = 1;
    passWordField.tag = 2;
    
    myIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	myIndicator.center = CGPointMake(198, 173);
	myIndicator.hidesWhenStopped = YES;
    [self.view addSubview:myIndicator];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setUserNameField:nil];
    [self setPassWordField:nil];
    [self setLoginButton:nil];
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
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
