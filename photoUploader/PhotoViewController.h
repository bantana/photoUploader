//
//  SecondViewController.h
//  photoUploader
//
//  Created by Kerry Happle on 1/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoArrayManager.h"


@interface MyImageView : UIImageView {
}
@end

@interface PhotoViewController : UIViewController {
    IBOutlet UIScrollView *myScrollView;
    NSString *UserID;
    PhotoArrayManager *arrayManager;
    //NSMutableDictionary *JSON;
    int i, currentX, currentY, padding, thumbSize;
    CGRect screenBounds;
    UIActivityIndicatorView *myIndicator;
    UILabel *photoCount;
    MyImageView *blockImage;
    id currentImageTag;
}

@property (nonatomic, retain) id currentImageTag;

-(void)getPhotos;
-(void)loadImage;
-(void)displayImage:(UIImage *)image;
-(void)loadLargeImage;

@end