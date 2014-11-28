//
//  LBPositiveFeedbackAlert.m
//  FeedbackMe
//
//  Created by Leonardo Baptista on 11/19/14.
//  Copyright (c) 2014 Leonardo Baptista. All rights reserved.
//

#import "LBPositiveFeedbackAlert.h"

@implementation LBPositiveFeedbackAlert

+(void) show {
    NSString *title = NSLocalizedStringWithDefaultValue(@"Positive Feedback Alert Title", nil, [NSBundle mainBundle], @"That's nice. Thank you", nil);
    NSString *message = NSLocalizedStringWithDefaultValue(@"Positive Feedback Alert Message", nil, [NSBundle mainBundle], @"Since you are liking our app, can you help us by leaving a review on the AppStore?", nil);
    NSString *no = NSLocalizedStringWithDefaultValue(@"Positive Feedback Button No", nil, [NSBundle mainBundle], @"No", nil);
    NSString *yes = NSLocalizedStringWithDefaultValue(@"Positive Feedback Button Yes", nil, [NSBundle mainBundle], @"Sure!", nil);
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle: title
                              message: message
                              delegate:self
                              cancelButtonTitle: no
                              otherButtonTitles: yes, nil];
    [alertView show];
}

#pragma mark - App Store

+(void) openAppStore {;
    NSString *strURL = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/%@", [LBFeedbackMe appStoreId]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strURL]];
}

#pragma mark - UIAlertViewDelegate

+(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) { //NO
        
    }
    else if (buttonIndex == 1) { //YES
        [self openAppStore];
    }
    else if (buttonIndex == 2) { //Not now
        
    }
}

@end
