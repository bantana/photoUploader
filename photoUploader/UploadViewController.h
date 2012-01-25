//
//  FirstViewController.h
//  photoUploader
//
//  Created by Kerry Happle on 1/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EPUploader.h"

@interface UploadViewController : UIViewController <UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate> {
    IBOutlet UIImageView *imageView;
    BOOL selectedPhoto;
    NSString *UserID;
    IBOutlet UIButton *myButton;
}

@property(nonatomic,retain) UIImageView *imageView;
@property(nonatomic,retain) NSString *UserID;
@property(nonatomic,retain) IBOutlet UIButton *myButton;



-(IBAction)uploadPhotoPressed:(id)sender;
-(void)getCameraPicture;
-(void)selectExitingPicture;
-(void)uploadPhoto;

@end
