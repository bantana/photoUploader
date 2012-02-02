//
//  PhotoArrayManager.h
//  photoUploader
//
//  Created by Kerry Happle on 1/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoArrayManager : NSObject{
    NSMutableArray *thumbPhotoArray;
    NSMutableDictionary *largePhotoDict;
}
@property (nonatomic, strong) NSMutableArray *thumbPhotoArray;
@property (nonatomic, strong) NSMutableDictionary *largePhotoDict;

+ (id)sharedManager;

@end
