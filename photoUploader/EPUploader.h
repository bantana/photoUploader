//
//  EPUploader.h
//  photoUploader
//
//  Created by Kerry Happle on 1/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EPUploader : NSObject {
    NSURL *serverURL;
    NSData *file;
    id delegate;
    SEL doneSelector;
    SEL errorSelector;
    
    BOOL uploadDidSucceed;
}

-   (id)initWithURL: (NSURL *)serverURL 
               file: (NSData *)file 
           delegate: (id)delegate 
       doneSelector: (SEL)doneSelector 
      errorSelector: (SEL)errorSelector
;

-   (NSData *)file;

@end
