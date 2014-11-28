//
//  LBApiService.m
//  FeedbackMe
//
//  Created by Leonardo Baptista on 11/26/14.
//  Copyright (c) 2014 Leonardo Baptista. All rights reserved.
//

#import "LBApiService.h"
#import "LBFeedbackMe.h"

@interface LBApiService()

@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, copy) void (^onSuccess)(void);
@property (nonatomic, copy) void (^onFailure)(void);

@end

@implementation LBApiService

+(NSURL *) postFeedbackURL {
    NSString *addressString = @"https://feedbackme.herokuapp.com/feedback";
//    NSString *addressString = @"http://localhost:3000/feedback";
    return [NSURL URLWithString:addressString];
}

+(LBApiService *) sharedInstance {
    static dispatch_once_t pred;
    static LBApiService *shared = nil;
    
    dispatch_once(&pred, ^{
        shared = [[LBApiService alloc] init];
    });
    return shared;
}

+(NSDictionary *) paramsToDicitonaryName:(NSString *) name email: (NSString *) email text:(NSString *) text {
    return @{
             @"user": name,
             @"email": email,
             @"text": text,
             @"app_secret": [LBFeedbackMe apiKey]
             };
}

-(void) sendFeedbackToApiWithData: (NSDictionary *) data onSuccess:(void (^)(void))onSuccess onFailure:(void (^)(void))onFailure {
    
    self.onSuccess = onSuccess;
    self.onFailure = onFailure;
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[LBApiService postFeedbackURL]];
    
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:0 error:nil];
    NSString *urlString =  [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSData *requestBodyData = [urlString dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = requestBodyData;

    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if (!theConnection) {
        self.onFailure();
    }

}

#pragma mark NSURLConnection Delegate Methods

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    self.onSuccess();
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    self.onFailure();
}

@end
