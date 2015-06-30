//
//  SignUpViewController.m
//  NextUp
//
//  Created by Michael Lee on 4/8/14.
//  Copyright (c) 2014 Michael Lee. All rights reserved.
//

#import "SignUpViewController.h"
#import <Parse/Parse.h>


@interface SignUpViewController ()

@end

@implementation SignUpViewController
@synthesize usernameField;
@synthesize passwordField;
@synthesize emailField;
@synthesize hometownField;



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //Title Bar
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     [UIFont fontWithName:@"GillSans-Bold" size:17.0f], UITextAttributeFont,
                                                                     [UIColor colorWithRed:0.047 green:0.965 blue:0.443 alpha:1], UITextAttributeTextColor,
                                                                     [UIColor grayColor], UITextAttributeTextShadowColor,
                                                                     [NSValue valueWithUIOffset:UIOffsetMake(0.0f, 1.0f)],
                                                                     UITextAttributeTextShadowOffset,
                                                                     
                                                                     nil]];
    
    //Background
    self.view.backgroundColor = [UIColor colorWithRed:0.204 green:0.239 blue:0.271 alpha:1];
    
    
	// Do any additional setup after loading the view.
}


- (IBAction)signUP :(id)sender {
    
    NSString *username = [self.usernameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    username =[username lowercaseString];
    NSString *password = [self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *email = [self.emailField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *hometown = [self.hometownField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([username length] ==0 || [password length] ==0 || [email length] ==0 || [hometown length] ==0 )
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Oops" message:@"Make sure you enter a username,password,email address,age and hometown" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];
    }
    
    else
    {
        
        PFUser *newUser = [PFUser user];
        newUser.username = username;
        newUser.password = password;
        newUser.email = email;
        [newUser setObject:hometown forKey:@"hometown"];        
        
        
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
        {
            if (error)
            {
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Sorry" message:[error.userInfo objectForKey:@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
            }
            
            else
            {
                
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            
        }];
    
    }
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    if(touch.phase == UITouchPhaseBegan) {
        
        [passwordField resignFirstResponder];
        [emailField resignFirstResponder];
        [hometownField resignFirstResponder];
        [usernameField resignFirstResponder];
        
    }
}

@end
