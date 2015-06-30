//
//  GymInfoDetailViewController.m
//  NextUp
//
//  Created by Michael Lee on 4/13/14.
//  Copyright (c) 2014 Michael Lee. All rights reserved.
//

#import "GymInfoDetailViewController.h"
#import "MapViewController.h"
#import <Parse/Parse.h>
#import "ProfileDetailViewController.h"
#import "GymRosterViewController.h"



@interface GymInfoDetailViewController ()

@end

@implementation GymInfoDetailViewController 
@synthesize gymLabel;
@synthesize gymLabelText;
@synthesize gymUsers;
@synthesize gymCountLabel;
@synthesize selectedUserId;










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
    
    self.tableView.backgroundColor = [UIColor colorWithRed:0.204 green:0.239 blue:0.271 alpha:1];
    //TableView Line
    self.tableView.separatorColor = [UIColor colorWithRed:0.047 green:0.965 blue:0.443 alpha:1];
    
    
    unsigned long int count = gymUsers.count;
    NSString *gymCount = [NSString stringWithFormat:@"%lu",count];
    gymCountLabel.text = gymCount;
    gymLabel.text = gymLabelText;
    [gymLabel setFont:[UIFont fontWithName:@"Avenir-BlackOblique" size:17]];
   
// Do any additional setup after loading the view.
}










- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return self.gymUsers.count;
}






- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    // Configure the cell...
    
    cell.textLabel.text = [[gymUsers objectAtIndex:indexPath.row] valueForKey:@"username"];
    cell.textLabel.textColor = [UIColor colorWithRed:0.929 green:0.933 blue:0.933 alpha:1];
    cell.backgroundColor = [UIColor clearColor];
    
    
    return cell;
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"showProfileView"])
    {
        ProfileDetailViewController *profileDetailVC =(ProfileDetailViewController *)segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        PFUser * user = [self.gymUsers objectAtIndex:indexPath.row];
        
        self.selectedUserId = user.objectId;
        
        PFQuery *query = [PFUser query];
        [query whereKey:@"objectId" equalTo:selectedUserId];
        [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error)
         
         {
             
             profileDetailVC.usernameLabel.text = [object objectForKey:@"username"];
             profileDetailVC.statusLabel.text = [object objectForKey:@"status"];
             profileDetailVC.currentGymLabel.text = [object objectForKey:@"gymName"];
             profileDetailVC.hometownLabel.text =[object objectForKey:@"hometown"];
             PFFile *file = [object objectForKey:@"profilePic"];
             profileDetailVC.imageView.file=file;
             [profileDetailVC.imageView loadInBackground];
             
             
         }
         
         
         
         ];
        
        
    }
    if ([segue.identifier isEqualToString:@"gymRosterView"])
    {
        
       GymRosterViewController *gymRosterVC = (GymRosterViewController *)segue.destinationViewController;
        
        gymRosterVC.gymLabelText=self.gymLabel.text;
        
                
        
    }
 
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    PFUser *user = [self.gymUsers objectAtIndex:indexPath.row];
    self.selectedUserId = user.objectId;
    
    PFQuery *query = [PFUser query];
    [query whereKey:@"objectId" equalTo:selectedUserId];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error)
     
     {
         ProfileDetailViewController *profileDetailVC = [[ProfileDetailViewController alloc]init];
         profileDetailVC.usernameLabel.text = [object objectForKey:@"username"];
         
         
     }
     
     
     
     ];
}






- (IBAction)gymRosterButton:(id)sender

{
 
    
    
    
   
    
}
@end
