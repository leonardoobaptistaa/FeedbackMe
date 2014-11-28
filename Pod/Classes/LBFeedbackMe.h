//
//  LBFeedbackMe.h
//  FeedbackMe
//
//  Created by Leonardo Baptista on 11/19/14.
//  Copyright (c) 2014 Leonardo Baptista. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBFirstFeedbackAlert.h"

@interface LBFeedbackMe : NSObject

typedef void (^OpenFeedbackViewBlock)(void);

+(NSString *) appStoreId;
+(NSString *) apiKey;

+(void) setup;
+(void) setupWithAppStoreId: (NSString *) appStoreId openFeedbackViewBlock:(OpenFeedbackViewBlock) openBlock;
+(void) setupWithAppStoreId:(NSString *)appStoreId andApiKey:(NSString *) apiKey;

+(void) clearAllKeys;
+(void) updateLastOpenedVersionToCurrent;
+(BOOL) needToAskForFeedback;

+(NSString *) appVersion;
+(NSString *) eventFullName: (NSString *) event;
+(NSString *) lastOpenedVersion;
+(OpenFeedbackViewBlock) openFeedbackViewblock;

+(void) waitForEvent:(NSString *) eventName times:(NSNumber *) times;
+(void) eventFired:(NSString *) eventName;
+(void) eventFired:(NSString *) eventName shouldSkipFeedback: (BOOL) skipFeedback;

+(BOOL) allEventsAreDone;
+(BOOL) shouldAskForFeedbackNow;

+(void) askForFeedback;

+(NSBundle *) getBundle;
@end
