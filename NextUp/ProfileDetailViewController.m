//
//  ProfileDetailViewController.m
//  NextUp
//
//  Created by Michael Lee on 5/14/14.
//  Copyright (c) 2014 Michael Lee. All rights reserved.
//

#import "ProfileDetailViewController.h"

@interface ProfileDetailViewController ()

@end

@implementation ProfileDetailViewController
@synthesize usernameLabel;
@synthesize imageView;
@synthesize statusLabel;
@synthesize userId;
@synthesize hometownLabel;





- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
     [usernameLabel setFont:[UIFont fontWithName:@"Avenir-BlackOblique" size:18]];
   // [usernameLabel.text uppercaseString];
     [statusLabel setFont:[UIFont fontWithName:@"Avenir-MediumOblique" size:18]];
    imageView.layer.borderWidth = 3.0f;
    imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    imageView.layer.cornerRadius = imageView.frame.size.width / 2;
    imageView.clipsToBounds = YES;

}



@end
