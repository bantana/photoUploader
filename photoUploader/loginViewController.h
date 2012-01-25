//
//  loginViewController.h
//  loginTest
//
//  Created by Kerry Happle on 1/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMWebRequest.h"

@interface loginViewController : UIViewController {
    NSString *UserID;
    UIActivityIndicatorView *myIndicator;
    NSMutableData *responseData;
}


@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *passWordField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

-(IBAction)login:(id)sender;
-(IBAction)registerButton:(id)sender;
@end
