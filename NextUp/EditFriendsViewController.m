//
//  EditFriendsViewController.m
//  NextUp
//
//  Created by Michael Lee on 4/10/14.
//  Copyright (c) 2014 Michael Lee. All rights reserved.
//

#import "EditFriendsViewController.h"
#import <Parse/Parse.h>
#import "GymRosterViewController.h"



@interface EditFriendsViewController ()

@end

@implementation EditFriendsViewController





- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
	
    
    
    
    
    
    
    
    
    
    
    //Title Bar Text
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     [UIFont fontWithName:@"GillSans-Bold" size:17.0f], UITextAttributeFont,
                                                                     [UIColor colorWithRed:0.047 green:0.965 blue:0.443 alpha:1], UITextAttributeTextColor,
                                                                     [UIColor grayColor], UITextAttributeTextShadowColor,
                                                                     [NSValue valueWithUIOffset:UIOffsetMake(0.0f, 1.0f)],
                                                                     UITextAttributeTextShadowOffset,
                                                                     
                                                                     nil]];
    
    //TitleBar Color
   [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:0.118 green:0.133 blue:0.149 alpha:1]];
    //TableView Background
    self.tableView.backgroundColor = [UIColor colorWithRed:0.204 green:0.239 blue:0.271 alpha:1];
    
    //TableViewLine
    self.tableView.separatorColor = [UIColor colorWithRed:0.047 green:0.965 blue:0.443 alpha:1];
    
    
    
    
    
}






-(void)viewWillAppear:(BOOL)animated


{
    
    
    PFQuery *query = [PFUser query];
    [query whereKey:@"username" notEqualTo:[[PFUser currentUser] username]];
    [query orderByAscending:@"username"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         if(error)
         {
             
         }
         
         else
         {
             self.allUsers = objects;
             [self.tableView reloadData];
         }
         
         
     }];
    
    
    self.currentUser= [PFUser currentUser];
        
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
    return [self.allUsers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    PFUser * user = [self.allUsers objectAtIndex:indexPath.row];
    cell.textLabel.text = user.username;
    cell.textLabel.textColor = [UIColor colorWithRed:0.929 green:0.933 blue:0.933 alpha:1];
    
    if([self isFriend:user])
    {     
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
    }
    
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    PFUser * user = [self.allUsers objectAtIndex:indexPath.row];
    PFRelation *friendsRelation = [self.currentUser relationForKey:@"friendsRelation"];
    if([self isFriend:user])
    {
        cell.accessoryType =UITableViewCellAccessoryNone;
        for (PFUser *friend in self.friends)
        {
            if([friend.objectId isEqualToString:user.objectId])
            {
                [self.friends removeObject:friend];
            break;
            }
            
        }
        
       
        [friendsRelation removeObject:user];
        
        
        
        
    }
    
    else
         {
        
             cell.accessoryType = UITableViewCellAccessoryCheckmark;
             
             
             [self.friends addObject:user];
        [friendsRelation addObject:user];
          }
    [self.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
     {
         if (error)
         {
             
         }
         
     }];
    
   
   
}

#pragma mark - Helper Method

- (BOOL)isFriend:(PFUser *)user
{
    for (PFUser *friend in self.friends)
    {
        if([friend.objectId isEqualToString:user.objectId])
            return YES;
            
        
    }
    return NO;
}



@end
