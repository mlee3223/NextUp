//
//  FriendsViewController.m
//  NextUp
//
//  Created by Michael Lee on 4/10/14.
//  Copyright (c) 2014 Michael Lee. All rights reserved.
//

#import "FriendsViewController.h"
#import "EditFriendsViewController.h"
#import "ProfileDetailViewController.h"
#import <Parse/Parse.h>


@interface FriendsViewController ()

@end

@implementation FriendsViewController
@synthesize selectedUserId;


- (void)viewDidLoad
{
    [super viewDidLoad];
    //Colors
    
    //Title Bar Text
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     [UIFont fontWithName:@"GillSans-Bold" size:17.0f], UITextAttributeFont,
                                                                     [UIColor colorWithRed:0.929 green:0.933 blue:0.933 alpha:1], UITextAttributeTextColor,
                                                                     [UIColor grayColor], UITextAttributeTextShadowColor,
                                                                     [NSValue valueWithUIOffset:UIOffsetMake(0.0f, 1.0f)],
                                                                     UITextAttributeTextShadowOffset,
                                                                     
                                                                     nil]];
    
    //TitleBar Color
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:0.118 green:0.133 blue:0.149 alpha:1]];
    
    
    
    //TableView
    self.tableView.backgroundColor = [UIColor colorWithRed:0.204 green:0.239 blue:0.271 alpha:1];
    //TableView Line
    self.tableView.separatorColor = [UIColor colorWithRed:0.047 green:0.965 blue:0.443 alpha:1];
    self.friendsRelation = [[PFUser currentUser]objectForKey:@"friendsRelation"];
   

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    PFQuery *query = [self.friendsRelation query];
    [query orderByAscending:@"username"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         if(error)
         {
            
         }
         
         else
         {
             self.friends = objects;
             [self.tableView reloadData];
         }
         
     } ];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"showEditFriends"])
    {
        EditFriendsViewController *viewController=(EditFriendsViewController *) segue.destinationViewController;
        viewController.friends = [NSMutableArray arrayWithArray:self.friends];
    }
    
 else if ([segue.identifier isEqualToString:@"showProfileView"])
    {
        ProfileDetailViewController *profileDetailVC =(ProfileDetailViewController *)segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        PFUser * user = [self.friends objectAtIndex:indexPath.row];
        
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

}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [self.friends count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    PFUser *user = [self.friends objectAtIndex:indexPath.row];
    cell.textLabel.text = user.username;
    cell.textLabel.textColor = [UIColor colorWithRed:0.929 green:0.933 blue:0.933 alpha:1];
      cell.backgroundColor = [UIColor clearColor];
    
    
    
    //cell pic
    
    
    
    
    

    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    PFUser *user = [self.friends objectAtIndex:indexPath.row];
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

@end
