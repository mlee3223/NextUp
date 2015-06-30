//
//  ProfileDetailViewController.h
//  NextUp
//
//  Created by Michael Lee on 5/14/14.
//  Copyright (c) 2014 Michael Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ProfileDetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;

@property (strong, nonatomic) IBOutlet PFImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) IBOutlet UILabel *currentGymLabel;
@property (nonatomic, strong) NSString *userId;
@property (strong, nonatomic) IBOutlet UILabel *hometownLabel;


@end
