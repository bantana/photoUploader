//
//  LoginModel.h
//  photoUploader
//
//  Created by Kerry Happle on 1/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBJson.h"

@protocol loginDelegate

@required
- (void)loginSucceeded:(NSArray *)JSON;
- (void)loginFailed:(NSString *)failedMessage;

@end

@interface LoginModel : NSObject {
    NSString *UserID;
    NSMutableData *responseData;
}

@property (nonatomic, assign) id delegate;

-(void)receiveLoginCredentials:(NSString *)userName:(NSString *)passWord;

@end
