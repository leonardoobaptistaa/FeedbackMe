//
//  FeedbackMeTests.m
//  FeedbackMeTests
//
//  Created by Leonardo Baptista on 11/19/2014.
//  Copyright (c) 2014 Leonardo Baptista. All rights reserved.
//

#import "LBFeedbackMe.h"

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

SpecBegin(LBFeedbackMe)

beforeEach(^{
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
});

afterAll(^{
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
});

describe(@"#setupWithAppStoreId", ^{
    OpenFeedbackViewBlock block = ^{};
    beforeEach(^{
        [LBFeedbackMe setupWithAppStoreId:@"AppId" openFeedbackViewBlock: block];
    });
    
    it(@"stores appId", ^{
        expect([LBFeedbackMe appStoreId]).to.equal(@"AppId");
    });
    
    it(@"stores openBlock", ^{
        expect([LBFeedbackMe openFeedbackViewblock]).to.equal(block);
    });
});

describe(@"#setupWithAppStoreIdAndApiKey", ^{
    beforeEach(^{
        [LBFeedbackMe setupWithAppStoreId:@"appstoreid" andApiKey:@"apikey"];
    });
    
    it(@"stores api key", ^{
        expect([LBFeedbackMe appStoreId]).to.equal(@"appstoreid");
    });
    
    it(@"stores api key", ^{
        expect([LBFeedbackMe apiKey]).to.equal(@"apikey");
    });
});

describe(@"#setup", ^{
    beforeEach(^{
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"FEEDBACKME_REGISTER"];
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"USER_KEY"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    });
    
    context(@"the last opened version is same from current", ^{
        beforeEach(^{
            [[NSUserDefaults standardUserDefaults] setObject:[LBFeedbackMe appVersion] forKey:@"FEEDBACKME_LAST_OPENED_VERSION"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [LBFeedbackMe setup];
        });
        
        it(@"keeps all FEEDBACKME info", ^{
            NSString *registeredValue = [[NSUserDefaults standardUserDefaults] objectForKey:@"FEEDBACKME_REGISTER"];
            expect(registeredValue).to.equal(@"1");
        });
    });
    
    context(@"the last opened version is diferent from current", ^{
        beforeEach(^{
            [[NSUserDefaults standardUserDefaults] setObject:@"0.8237684276" forKey:@"FEEDBACKME_LAST_OPENED_VERSION"];
            [LBFeedbackMe setup];
        });
        
        it(@"cleans old registry from FEEDBACKME", ^{
            NSString *registeredValue = [[NSUserDefaults standardUserDefaults] objectForKey:@"FEEDBACKME_REGISTER"];
            expect(registeredValue).to.beNil();
        });
        
        it(@"updates the lastOpenedVersion value to current", ^{
            expect([LBFeedbackMe lastOpenedVersion]).to.equal([LBFeedbackMe appVersion]);
        });
    });
    
    it(@"keeps other registries", ^{
        [LBFeedbackMe setup];
        NSString *registeredValue = [[NSUserDefaults standardUserDefaults] objectForKey:@"USER_KEY"];
        expect(registeredValue).to.equal(@"1");
    });
});

describe(@"#updateLastVersionToCurrent", ^{
    beforeEach(^{
        [[NSUserDefaults standardUserDefaults] setObject:@"0.8237684276" forKey:@"FEEDBACKME_LAST_OPENED_VERSION"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [LBFeedbackMe updateLastOpenedVersionToCurrent];
    });
    
    it(@"update version to current", ^{
        expect([LBFeedbackMe lastOpenedVersion]).to.equal([LBFeedbackMe appVersion]);
    });
    
    it(@"set need ask for update to true", ^{
        expect([LBFeedbackMe needToAskForFeedback]).to.beTruthy();
    });
});

describe(@"#appVersion", ^{
    it(@"get app version from bundle", ^{
        NSString *appVersion = [LBFeedbackMe appVersion];
        expect(appVersion).to.equal(@"1.0");
    });
});

describe(@"#lastOpenedVersion", ^{
    context(@"user never opened the app", ^{
        beforeEach(^{
            [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"FEEDBACKME_LAST_OPENED_VERSION"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        });
        
        it(@"should be nil", ^{
            NSString *lastOpenedVersion = [LBFeedbackMe lastOpenedVersion];
            expect(lastOpenedVersion).to.beNil();
        });
    });
    
    context(@"user already opened the app on version 1.0", ^{
        beforeEach(^{
            [[NSUserDefaults standardUserDefaults] setObject:@"1.0" forKey:@"FEEDBACKME_LAST_OPENED_VERSION"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        });
        
        it(@"should be 1.0", ^{
            NSString *lastOpenedVersion = [LBFeedbackMe lastOpenedVersion];
            expect(lastOpenedVersion).to.equal(@"1.0");
        });
    });
});

describe(@"#eventFullName", ^{
    it(@"concat event name with appversion", ^{
        NSString *eventFullName = [LBFeedbackMe eventFullName:@"REGISTER"];
        expect(eventFullName).to.equal(@"FEEDBACKME_REGISTER");
    });
});

describe(@"#waitForEvent:times", ^{
    NSString *eventName = @"EventTest";
    NSString *eventFullName = [LBFeedbackMe eventFullName:eventName];
    NSNumber *times = @3;
    
    context(@"the event was never set before", ^{
        beforeEach(^{
            [LBFeedbackMe setup];
            [LBFeedbackMe waitForEvent:eventName times:times];
        });
        
        it(@"sets the eventName on userDefaults with times value", ^{
            NSDictionary *times = [[NSUserDefaults standardUserDefaults] objectForKey:eventFullName];
            
            expect(times[@"total"]).to.equal(@3);
            expect(times[@"current"]).to.equal(@0);
        });
    });
    
    context(@"the event was already set", ^{
        beforeEach(^{
            [LBFeedbackMe setup];
            
            [LBFeedbackMe waitForEvent:eventName times:@5];
            [LBFeedbackMe eventFired:eventName];
            
            [LBFeedbackMe waitForEvent:eventName times:times];
        });
        
        it(@"updates the total value and not the current", ^{
            NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:eventFullName];
            
            expect(dict[@"total"]).to.equal(times);
            expect(dict[@"current"]).to.equal(@1);
        });
    });
});

describe(@"#shouldAskForFeedbackNow", ^{
    context(@"have missing events", ^{
        beforeEach(^{
            [LBFeedbackMe setup];
            
            [LBFeedbackMe waitForEvent:@"event1" times:@2];
            [LBFeedbackMe eventFired:@"event1"];
            [LBFeedbackMe eventFired:@"event1"];
            
            [LBFeedbackMe waitForEvent:@"event2" times:@3];
            [LBFeedbackMe eventFired:@"event2"];
        });
        
        it(@"return FALSE", ^{
            expect([LBFeedbackMe shouldAskForFeedbackNow]).to.beFalsy();
        });
    });
    
    context(@"all events are done", ^{
        beforeEach(^{
            [LBFeedbackMe setup];
            
            [LBFeedbackMe waitForEvent:@"event1" times:@2];
            [LBFeedbackMe waitForEvent:@"event2" times:@3];
            
            [LBFeedbackMe eventFired:@"event1"];
            [LBFeedbackMe eventFired:@"event1"];
            
            [LBFeedbackMe eventFired:@"event2"];
            [LBFeedbackMe eventFired:@"event2"];
            [LBFeedbackMe eventFired:@"event2" shouldSkipFeedback:true];
        });
        
        it(@"return TRUE", ^{
            expect([LBFeedbackMe shouldAskForFeedbackNow]).to.beTruthy();
        });
    });
    
    context(@"already asked once", ^{
        beforeEach(^{
            [LBFeedbackMe setup];
            [LBFeedbackMe askForFeedback];
        });
        
        it(@"dont should ask for feedback", ^{
            expect([LBFeedbackMe shouldAskForFeedbackNow]).to.beFalsy();
        });
    });
});

describe(@"#needtoAskForFeedback", ^{
    context(@"already asked once", ^{
        beforeEach(^{
            [LBFeedbackMe setup];
            [LBFeedbackMe askForFeedback];
        });
        
        it(@"dont need to ask for feedback any more", ^{
            expect([LBFeedbackMe needToAskForFeedback]).to.beFalsy();
        });
    });
    
    context(@"never asked for feedback and have all events done", ^{
        beforeEach(^{
            [LBFeedbackMe setup];
            
            [LBFeedbackMe waitForEvent:@"event1" times:@2];
            [LBFeedbackMe eventFired:@"event1"];
            [LBFeedbackMe eventFired:@"event1" shouldSkipFeedback: true];
        });
        
        it(@"needs to ask for feedback", ^{
            expect([LBFeedbackMe needToAskForFeedback]).to.beTruthy();
        });
    });
});

describe(@"#eventFired", ^{
    NSString *eventName = @"EventTest";
    NSString *eventFullName = [LBFeedbackMe eventFullName:eventName];
    
    context(@"event is not registered", ^{
        it(@"throws exception", ^{
            expect(^{
                [LBFeedbackMe eventFired:eventName];
            }).to.raise(@"EventNotRegisteredException");
        });
    });
    
    context(@"event count is less than total", ^{
        beforeEach(^{
            [LBFeedbackMe setup];
            
            [LBFeedbackMe waitForEvent:eventName times:@2];
            [LBFeedbackMe eventFired:eventName];
        });
        
        it(@"increase by one the event count", ^{
            NSDictionary *times = [[NSUserDefaults standardUserDefaults] objectForKey:eventFullName];
            expect(times[@"current"]).to.equal(@1);
        });
    });
});

SpecEnd