//
//  LargePhotoViewController.h
//  photoUploader
//
//  Created by Kerry Happle on 1/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LargePhotoViewController : UIViewController <UIScrollViewDelegate>{
    NSString *currentImage;
    UIImageView *imageView;
}

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NSString *currentImage;
@property (weak, nonatomic) IBOutlet UIScrollView *PhotoScrollView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *dismiss;

-(void)loadImage;
-(IBAction)backButton;
@end
