//
//  ImageViewController.m
//  NextUp
//
//  Created by Michael Lee on 5/4/14.
//  Copyright (c) 2014 Michael Lee. All rights reserved.
//

#import "ImageViewController.h"
#import "ProfileViewController.h"
#import <Parse/Parse.h>


@interface ImageViewController ()

@end

@implementation ImageViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        
    }
    
    
	// Do any additional setup after loading the view.
}



    

@end
