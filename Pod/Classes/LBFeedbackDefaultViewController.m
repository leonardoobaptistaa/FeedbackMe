//
//  LBFeedbackDefaultViewController.m
//  FeedbackMe
//
//  Created by Leonardo Baptista on 11/25/14.
//  Copyright (c) 2014 Leonardo Baptista. All rights reserved.
//

#import "LBFeedbackDefaultViewController.h"

@interface LBFeedbackDefaultViewController ()

@property (nonatomic, assign) float fullHeight;

@end

@implementation LBFeedbackDefaultViewController

#pragma mark - Touch Event

-(IBAction)cancel:(id)sender {
    [self resignAllTextFields];
    [self dismissViewControllerAnimated:true completion:nil];
}

-(IBAction)send:(id)sender {
    [self resignAllTextFields];
    [self sendFeedback];
    [self dismissViewControllerAnimated:true completion:nil];
}

-(void) sendFeedback {
    NSDictionary *data = [LBApiService paramsToDicitonaryName:self.txtName.text email:self.txtEmail.text text:self.txtText.text];
    [[LBApiService sharedInstance] sendFeedbackToApiWithData:data onSuccess:^{
        
    } onFailure:^{
        
    }];
}

#pragma mark - UIView Appears and Disappears

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self registerKeyboardNotifications];
    
    [self.txtName becomeFirstResponder];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - ViewController Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self localizeControls];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) localizeControls {
    self.txtName.placeholder = NSLocalizedString(@"Name", nil);
    self.txtEmail.placeholder = NSLocalizedString(@"E-mail", nil);
    self.lblText.text = NSLocalizedString(@"How can we improve?", nil);
}

#pragma mark - Keyboard and Screen position

- (void) registerKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:@"UIKeyboardDidShowNotification"
                                               object:nil];
}

- (void) keyboardWillShow:(NSNotification *)note {
    if (self.fullHeight == 0) {
        self.fullHeight = self.view.frame.size.height;
    }
    
    NSDictionary *userInfo = [note userInfo];
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    CGRect frame = self.view.frame;
    frame.size.height = self.fullHeight - keyboardSize.height;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.view.frame = frame;
    }];
}

#pragma mark - UITextFieldDelegate

-(void) resignAllTextFields {
    [self.txtName resignFirstResponder];
    [self.txtEmail resignFirstResponder];
    [self.txtText resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (self.txtName == textField) {
        [self.txtEmail becomeFirstResponder];
        return false;
    }
    
    if (self.txtEmail == textField) {
        [self.txtText becomeFirstResponder];
        return false;
    }
    
    return true;
}

#pragma mark - Status Bar

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
