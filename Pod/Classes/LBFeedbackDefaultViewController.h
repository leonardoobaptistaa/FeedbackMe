//
//  LBFeedbackDefaultViewController.h
//  FeedbackMe
//
//  Created by Leonardo Baptista on 11/25/14.
//  Copyright (c) 2014 Leonardo Baptista. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBApiService.h"

@interface LBFeedbackDefaultViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UITextField *txtName;
@property (nonatomic, strong) IBOutlet UITextField *txtEmail;
@property (nonatomic, strong) IBOutlet UILabel *lblText;
@property (nonatomic, strong) IBOutlet UITextView *txtText;

@end
