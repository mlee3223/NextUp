//
//  LoginViewController.h
//  NextUp
//
//  Created by Michael Lee on 4/8/14.
//  Copyright (c) 2014 Michael Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>

@interface LoginViewController : UIViewController 

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

- (IBAction)login:(id)sender;



@end
