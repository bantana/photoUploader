//
//  registerViewController.h
//  photoUploader
//
//  Created by Kerry Happle on 1/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface registerViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *passWordField;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

- (IBAction)registerUser:(id)sender;
-(IBAction)back:(id)sender;

@end
