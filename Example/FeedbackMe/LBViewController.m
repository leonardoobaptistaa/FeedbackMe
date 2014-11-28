//
//  LBViewController.m
//  FeedbackMe
//
//  Created by Leonardo Baptista on 11/19/2014.
//  Copyright (c) 2014 Leonardo Baptista. All rights reserved.
//

#import "LBViewController.h"
#import <LBFeedbackMe.h>

@interface LBViewController ()

@end

@implementation LBViewController

- (void) setupFeedbackMe {
    [LBFeedbackMe setupWithAppStoreId:@"id928556821" andApiKey:@"YOUR-API-KEY"];
//    [LBFeedbackMe setupWithAppStoreId:@"id928556821" openFeedbackViewBlock:^{
//        UIViewController *actualViewController; //Get current view controller from AppDelegate or other place
//        UIViewController *feedbackViewController = [UIViewController new]; //Instantiate your custom feedback view controller
//        [actualViewController presentViewController:feedbackViewController animated:true completion:nil];
//    }];
    [LBFeedbackMe waitForEvent:@"VIEW_APPEAR" times:@1];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupFeedbackMe];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void) viewDidAppear:(BOOL)animated {
    [LBFeedbackMe eventFired:@"VIEW_APPEAR"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
