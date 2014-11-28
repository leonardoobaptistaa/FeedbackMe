//
//  LBFirstFeedbackAlert.h
//  FeedbackMe
//
//  Created by Leonardo Baptista on 11/19/14.
//  Copyright (c) 2014 Leonardo Baptista. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBPositiveFeedbackAlert.h"
#import "LBNegativeFeedbackAlert.h"

@interface LBFirstFeedbackAlert : NSObject<UIAlertViewDelegate>

+(void) show;

@end
