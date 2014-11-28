//
//  LBFirstFeedbackAlert.m
//  FeedbackMe
//
//  Created by Leonardo Baptista on 11/19/14.
//  Copyright (c) 2014 Leonardo Baptista. All rights reserved.
//

#import "LBFirstFeedbackAlert.h"

@implementation LBFirstFeedbackAlert

+(void) show {
    
    NSString *title = NSLocalizedStringWithDefaultValue(@"First Feedback Alert Title", nil, [NSBundle mainBundle], @"Quick Feedback", nil);
    NSString *message = NSLocalizedStringWithDefaultValue(@"First Feedback Alert Message", nil, [NSBundle mainBundle], @"Are you enjoying this app?", nil);
    NSString *no = NSLocalizedStringWithDefaultValue(@"First Feedback Button No", nil, [NSBundle mainBundle], @"Not actually", nil);
    NSString *confused = NSLocalizedStringWithDefaultValue(@"First Feedback Button Confused", nil, [NSBundle mainBundle], @"I am confused", nil);
    NSString *yes = NSLocalizedStringWithDefaultValue(@"First Feedback Button Yes", nil, [NSBundle mainBundle], @"Yes, very much!", nil);
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle: title
                              message: message
                              delegate:self
                              cancelButtonTitle: no
                              otherButtonTitles: yes, confused, nil];
    [alertView show];
}

#pragma mark - UIAlertViewDelegate

+(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) { //YES
        [LBPositiveFeedbackAlert show];
    }
    else { //I am confused or No
        [LBNegativeFeedbackAlert show];
    }
}

@end
