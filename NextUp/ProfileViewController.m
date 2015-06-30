//
//  ProfileViewController.m
//  NextUp
//
//  Created by Michael Lee on 4/8/14.
//  Copyright (c) 2014 Michael Lee. All rights reserved.
//

#import "ProfileViewController.h"
#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreImage/CoreImage.h>





@interface ProfileViewController ()

@end

@implementation ProfileViewController
@synthesize usernameLabel;
@synthesize imageView;
@synthesize statusTextField;
@synthesize labelPlaceholder;
@synthesize hometownLabel;








- (void)viewDidLoad
{
    [super viewDidLoad];
   statusTextField.delegate = self;
    
    //TitleBar Color
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:0.118 green:0.133 blue:0.149 alpha:1]];
    
      
    //Title Bar Text 
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     [UIFont fontWithName:@"GillSans-Bold" size:17.0f], UITextAttributeFont,
                                                                     [UIColor colorWithRed:0.047 green:0.965 blue:0.443 alpha:1], UITextAttributeTextColor,
                                                                     [UIColor grayColor], UITextAttributeTextShadowColor,
                                                                     [NSValue valueWithUIOffset:UIOffsetMake(0.0f, 1.0f)],
                                                                     UITextAttributeTextShadowOffset,
                                                                     
                                                                     nil]];
    [usernameLabel setFont:[UIFont fontWithName:@"Avenir-BlackOblique" size:18]];
    [statusTextField  setFont:[UIFont fontWithName:@"Avenir-MediumOblique" size:14]];
    
     }



    


-(void)viewWillAppear:(BOOL)animated
{
    
    
    
    PFUser *currentUser = [PFUser currentUser];
    
    if (currentUser) {
        
        usernameLabel.text = [currentUser.username uppercaseString];
        
        PFQuery *query = [PFUser query];
        [query whereKey:@"username" equalTo:currentUser.username];
        [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error)
         {
             
             self.hometownLabel.text = [object objectForKey:@"hometown"];
             self.labelPlaceholder.text = [object objectForKey:@"status"];
             PFFile *file = [object objectForKey:@"profilePic"];
             self.imageView.file =file;
             imageView.layer.borderWidth = 3.0f;
             imageView.layer.borderColor = [UIColor whiteColor].CGColor;
             imageView.layer.cornerRadius = imageView.frame.size.width / 2;
             imageView.clipsToBounds = YES;
             [imageView loadInBackground];
         }
         
         
         ];
    }
    
    else
    {
        [self performSegueWithIdentifier:@"showLogin" sender:self];
    }
    
    
    
    
    
}




 




- (IBAction)logOut:(id)sender {
    
    [PFUser logOut];
    [self performSegueWithIdentifier:@"showLogin" sender:self];
    
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showLogin"]) {
        [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
    }
}
- (IBAction)editButton:(id)sender {
    
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:picker animated:YES completion:NULL];
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    
    NSData *imageData = UIImagePNGRepresentation(chosenImage);
    PFFile *imageFile = [PFFile fileWithName:@"image.png" data:imageData];
    [imageFile saveInBackground];
    
    PFUser *user = [PFUser currentUser];
    [user setObject:imageFile forKey:@"profilePic"];
    [user saveInBackground];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}



- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [statusTextField resignFirstResponder];
    
    labelPlaceholder.text = statusTextField.text;
    
    
    PFUser *user = [PFUser currentUser];
    [user setObject:statusTextField.text forKey:@"status"];
    
    [user saveInBackground];
    return YES;
    
}



- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    [statusTextField setAlpha:1];
    statusTextField.textColor = [UIColor blackColor];
    
    [self animateTextField: textField up: YES];
}




- (void)textFieldDidEndEditing:(UITextField *)textField
{
    labelPlaceholder.text = statusTextField.text;
    
    [statusTextField setAlpha:0.2];
    statusTextField.textColor = [UIColor clearColor];
    
    
    [self animateTextField: textField up: NO];
}




- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 120; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}









- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    if(touch.phase == UITouchPhaseBegan) {
        [statusTextField resignFirstResponder];
        
    }
}




@end
