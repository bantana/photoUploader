//
//  SecondViewController.h
//  photoUploader
//
//  Created by Kerry Happle on 1/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MyImageView : UIImageView {
}
@end

@interface PhotoViewController : UIViewController {
    IBOutlet UIScrollView *myScrollView;
    NSString *UserID;
    NSMutableDictionary *JSON;
    int i, currentX, currentY, padding, thumbSize;
    CGRect screenBounds;
    UIActivityIndicatorView *myIndicator;
    UILabel *photoCount;
    MyImageView *blockImage;
}

-(void)getPhotos;
-(void)loadImage;
-(void)displayImage:(UIImage *)image;

@end