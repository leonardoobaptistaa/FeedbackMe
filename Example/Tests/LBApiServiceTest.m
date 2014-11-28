//
//  LBApiServiceTest.m
//  FeedbackMe
//
//  Created by Leonardo Baptista on 11/26/14.
//  Copyright (c) 2014 Leonardo Baptista. All rights reserved.
//

#import "LBApiService.h"
#import "LBFeedbackMe.h"

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

SpecBegin(LBApiService)

describe(@"#postFeedbackURL", ^{
    it(@"have a NSURL with app api address", ^{
        NSURL *url = [LBApiService postFeedbackURL];
        expect([url absoluteString]).to.equal(@"https://feedbackme.herokuapp.com/feedback");
    });
});

describe(@"#sharedInstance", ^{
    it(@"is the same object", ^{
        id firstCall = [LBApiService sharedInstance];
        id secondCall = [LBApiService sharedInstance];
        
        expect(firstCall).to.beIdenticalTo(secondCall);
    });
});

describe(@"#paramsToDictionary", ^{
    __block NSDictionary *dict = nil;
    NSString *name = @"test_name";
    NSString *email = @"test_email@email.com";
    NSString *text = @"test_text";
    NSString *apiKey = @"TEST API KEY";
    
    beforeEach(^{
        [LBFeedbackMe setupWithAppStoreId:@"ID1" andApiKey:apiKey];
        dict = [LBApiService paramsToDicitonaryName:name email:email text:text];
    });
    
    it(@"have user param on dictionary", ^{
        expect(dict[@"user"]).to.equal(name);
    });
    
    it(@"have email param on dictionary", ^{
        expect(dict[@"email"]).to.equal(email);
    });
    
    it(@"have user param on dictionary", ^{
        expect(dict[@"text"]).to.equal(text);
    });
    
    it(@"have user param on dictionary", ^{
        expect(dict[@"app_secret"]).to.equal(apiKey);
    });
});

SpecEnd