//
//  PhotoArrayManager.h
//  photoUploader
//
//  Created by Kerry Happle on 1/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoArrayManager : NSObject{
    NSMutableDictionary *photoDict;
}
@property (nonatomic, strong) NSMutableDictionary *photoDict;

+ (id)sharedManager;

@end
