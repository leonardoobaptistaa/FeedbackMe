//
//  LBNegativeFeedbackAlert.m
//  FeedbackMe
//
//  Created by Leonardo Baptista on 11/19/14.
//  Copyright (c) 2014 Leonardo Baptista. All rights reserved.
//

#import "LBNegativeFeedbackAlert.h"
#import "LBFeedbackDefaultViewController.h"
#import "LBFeedbackMe.h"

@implementation LBNegativeFeedbackAlert

+(void) show {
    NSString *title = NSLocalizedStringWithDefaultValue(@"Negative Feedback Alert Title", nil, [NSBundle mainBundle], @"How can we improve?", nil);
    NSString *message = NSLocalizedStringWithDefaultValue(@"Negative Feedback Alert Message", nil, [NSBundle mainBundle], @"Do you want to tell us how to improve our app and make you happy? :)", nil);
    NSString *no = NSLocalizedStringWithDefaultValue(@"Negative Feedback Button No", nil, [NSBundle mainBundle], @"No", nil);
    NSString *yes = NSLocalizedStringWithDefaultValue(@"Negative Feedback Button Yes", nil, [NSBundle mainBundle], @"Sure!", nil);
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle: title
                              message: message
                              delegate:self
                              cancelButtonTitle: no
                              otherButtonTitles: yes, nil];
    [alertView show];
}

#pragma mark - App Store

+(UIViewController *) feedbackViewController {
    LBFeedbackDefaultViewController *feedbackController = [[LBFeedbackDefaultViewController new] initWithNibName:@"LBFeedbackDefaultViewController" bundle: [LBFeedbackMe getBundle]];
    
    return feedbackController;
}

+(void) openFeedbackView {
    id<UIApplicationDelegate> delegate = [UIApplication sharedApplication].delegate;
    UIWindow *window = [delegate window];
    
    UIViewController *rootViewController = window.rootViewController;
    UIViewController * feedbackController = [self feedbackViewController];
    UIViewController *actualViewController = rootViewController.presentedViewController;
    if (actualViewController == nil) {
        actualViewController = rootViewController;
    }
    
    [actualViewController presentViewController:feedbackController animated:true completion:nil];
}

#pragma mark - UIAlertViewDelegate

+(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) { //NO
        
    }
    else if (buttonIndex == 1) { //YES
        if ([LBFeedbackMe apiKey]) {
            [self openFeedbackView];
        }
        else {
            [LBFeedbackMe openFeedbackViewblock]();
        }
    }
}

@end
