//
//  LBApiService.h
//  FeedbackMe
//
//  Created by Leonardo Baptista on 11/26/14.
//  Copyright (c) 2014 Leonardo Baptista. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBApiService : NSObject<NSURLConnectionDataDelegate>

+(NSURL *) postFeedbackURL;
+(LBApiService *) sharedInstance;
+(NSDictionary *) paramsToDicitonaryName:(NSString *) name email: (NSString *) email text:(NSString *) text;

-(void) sendFeedbackToApiWithData: (NSDictionary *) data onSuccess:(void (^)(void))onSuccess onFailure:(void (^)(void))onFailure;

@end
