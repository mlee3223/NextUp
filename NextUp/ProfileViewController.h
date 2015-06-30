//
//  ProfileViewController.h
//  NextUp
//
//  Created by Michael Lee on 4/8/14.
//  Copyright (c) 2014 Michael Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ProfileViewController : UIViewController <UITextFieldDelegate>
- (IBAction)logOut:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

@property (strong, nonatomic) IBOutlet PFImageView *imageView;

@property (strong, nonatomic) IBOutlet UITextField *statusTextField;


@property (strong, nonatomic) IBOutlet UILabel *labelPlaceholder;
@property (strong, nonatomic) IBOutlet UILabel *hometownLabel;


- (IBAction)editButton:(id)sender;




@end
