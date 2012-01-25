//
//  LoginModel.m
//  photoUploader
//
//  Created by Kerry Happle on 1/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

// Testing 123 ads
#import "LoginModel.h"

@implementation LoginModel

@synthesize delegate;

-(void)receiveLoginCredentials:(NSString *)userName:(NSString *)passWord
{
    responseData = [[NSMutableData data] init];
    
    NSString *params = [[NSString alloc] initWithFormat:@"?userName=%@&passWord=%@",userName, passWord];
    //NSLog(@"%@",params);
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"https://robinsdigital.com/IOSdev/login.php%@",params]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    //[myIndicator startAnimating];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if(!connection) {
 		//NSLog(@"login connection failed :(");
 	} else {
 		//NSLog(@"login connection succeeded  :)");
 	}
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	[responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    if ([delegate respondsToSelector:@selector(loginFailed:)]) {
        [delegate loginFailed:[error localizedDescription]];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSString *serverOutput = [[NSString alloc] initWithData:responseData encoding: NSASCIIStringEncoding];
    
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSArray *JSON = [parser objectWithString:serverOutput error:nil] ;
    
    
    UserID = [[NSString alloc] initWithFormat:[JSON valueForKey:@"userID"]];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:UserID forKey:@"UserID"];
    [defaults synchronize];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(loginSucceeded:)]) {
        [delegate loginSucceeded:JSON];
    }

}

@end
