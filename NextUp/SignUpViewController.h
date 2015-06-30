//
//  SignUpViewController.h
//  NextUp
//
//  Created by Michael Lee on 4/8/14.
//  Copyright (c) 2014 Michael Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *usernameField;

@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (strong, nonatomic) IBOutlet UITextField *hometownField;



- (IBAction)signUP:(id)sender;

@end
