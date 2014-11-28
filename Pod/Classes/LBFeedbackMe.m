//
//  LBFeedbackMe.m
//  FeedbackMe
//
//  Created by Leonardo Baptista on 11/19/14.
//  Copyright (c) 2014 Leonardo Baptista. All rights reserved.
//

#import "LBFeedbackMe.h"

@implementation LBFeedbackMe

#pragma mark - Properties

static NSString *_appStoreId = @"";
+(NSString *) appStoreId {
    return _appStoreId;
}

static NSString *_apiKey = nil;
+(NSString *) apiKey {
    return _apiKey;
}

static OpenFeedbackViewBlock _openBlock;
+(OpenFeedbackViewBlock) openFeedbackViewblock {
    return _openBlock;
}

#pragma mark - Setup

+(void) setup {
    NSString *currentVersion = [LBFeedbackMe appVersion];
    NSString *lastOpenedVersion = [LBFeedbackMe lastOpenedVersion];
    
    if ([currentVersion isEqualToString:lastOpenedVersion]) {
        return;
    }
    
    [LBFeedbackMe clearAllKeys];
    [LBFeedbackMe updateLastOpenedVersionToCurrent];
}

+(void) setupWithAppStoreId: (NSString *) appStoreId openFeedbackViewBlock:(OpenFeedbackViewBlock) openBlock {
    _appStoreId = appStoreId;
    _openBlock  = openBlock;
    
    [self setup];
}

+(void) setupWithAppStoreId:(NSString *)appStoreId andApiKey:(NSString *) apiKey {
    _apiKey = apiKey;
    _appStoreId = appStoreId;
    
    [self setup];
}

#pragma mark - Ask For Feedback

+(void) askForFeedback {
    [[NSUserDefaults standardUserDefaults] setBool:false forKey:@"FEEDBACKME_NEED_FEEDBACK"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [LBFirstFeedbackAlert show];
}

+(BOOL) shouldAskForFeedbackNow {
    if ([self needToAskForFeedback] == false) {
        return false;
    }
    
    if ([self allEventsAreDone] == false) {
        return false;
    }
    
    return true;
}

#pragma mark - Events

+(BOOL) allEventsAreDone {
    NSArray *allEventKeys = [self getAllKeys];
    for (NSString *eventKey in allEventKeys) {
        if ([self isEventDone:eventKey] == false) {
            return false;
        }
    }
    return true;
}

+(void) waitForEvent:(NSString *) eventName times:(NSNumber *) times {
    NSString *eventFullName = [self eventFullName:eventName];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dict = [userDefaults objectForKey: eventFullName];
    
    if (dict == nil) {
        dict = [NSMutableDictionary new];
        dict[@"total"] = times;
        dict[@"current"] = @0;
    }
    else {
        dict = [[NSMutableDictionary alloc] initWithDictionary:dict];
        dict[@"total"] = times;
    }
    
    [userDefaults setObject:dict forKey: eventFullName];
    [userDefaults synchronize];
}

+(void) eventFired:(NSString *) eventName shouldSkipFeedback: (BOOL) skipFeedback {
    NSString *eventFullName = [self eventFullName:eventName];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dict = [userDefaults objectForKey: eventFullName];
    
    if (dict == nil) {
        NSString *reason = [NSString stringWithFormat:@"You need to register the event %@ using the code:\n [LBFeedbackMe waitForEvent:@\"%@\" times:@1];",eventName, eventName];
        [[[NSException alloc] initWithName:@"EventNotRegisteredException" reason:reason userInfo:nil] raise];
        return;
    }
    
    dict = [[NSMutableDictionary alloc] initWithDictionary:dict];
    NSNumber *total = dict[@"total"];
    NSNumber *current = dict[@"current"];
    
    if ([dict[@"current"] integerValue] < [total integerValue]) {
        dict[@"current"] = [NSNumber numberWithInteger:[current integerValue]+1];
    }
    
    [userDefaults setObject:dict forKey: eventFullName];
    [userDefaults synchronize];
    
    if ([dict[@"current"] integerValue] >= [total integerValue]) {
        if ([self shouldAskForFeedbackNow] && skipFeedback == false) {
            [self askForFeedback];
        }
    }
}

+(void) eventFired:(NSString *) eventName {
    [self eventFired:eventName shouldSkipFeedback:false];
}

+(BOOL) isEventDone:(NSString *) eventName {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dict = [userDefaults objectForKey: eventName];
    
    NSNumber *total = dict[@"total"];
    NSNumber *current = dict[@"current"];
    
    return [current integerValue] >= [total integerValue];
}

#pragma mark - Privates

+(NSArray *) getAllKeys {
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] dictionaryRepresentation];
    NSArray *allkeys = [dict allKeys];
    NSMutableArray *keys = [NSMutableArray new];
    
    for (NSString *key in allkeys) {
        if ([key isKindOfClass:[NSString class]] &&
            [key containsString:@"FEEDBACKME_"] &&
            [key isEqualToString:@"FEEDBACKME_LAST_OPENED_VERSION"] == false &&
            [key isEqualToString:@"FEEDBACKME_NEED_FEEDBACK"] == false) {
                [keys addObject:key];
        }
    }
    
    return keys;
}

+(void) clearAllKeys {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *keys = [self getAllKeys];
    
    for (NSString *key in keys) {
        [userDefaults setObject:nil forKey:key];
    }
    
    [userDefaults synchronize];
}

+(NSString *) appVersion {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

+(NSString *) lastOpenedVersion {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"FEEDBACKME_LAST_OPENED_VERSION"];
}

+(BOOL) needToAskForFeedback {
//    return true;
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"FEEDBACKME_NEED_FEEDBACK"];
}

+(void) updateLastOpenedVersionToCurrent {
    [[NSUserDefaults standardUserDefaults] setObject:[self appVersion] forKey:@"FEEDBACKME_LAST_OPENED_VERSION"];
    [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"FEEDBACKME_NEED_FEEDBACK"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSString *) eventFullName: (NSString *) event {
    return [NSString stringWithFormat:@"FEEDBACKME_%@", event];
}

+(NSBundle *) getBundle {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"FeedbackMe" ofType:@"bundle"];
    return [NSBundle bundleWithPath:bundlePath];
}

@end
