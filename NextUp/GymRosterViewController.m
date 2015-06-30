//
//  GymRosterViewController.m
//  NextUp
//
//  Created by Michael Lee on 6/10/14.
//  Copyright (c) 2014 Michael Lee. All rights reserved.
//

#import "GymRosterViewController.h"
#import <Parse/Parse.h>
#import "ProfileDetailViewController.h"
#import "GymInfoDetailViewController.h"

@interface GymRosterViewController ()

@end

@implementation GymRosterViewController
@synthesize selectedUserId;
@synthesize gymLabelText;
@synthesize timePicker;
@synthesize gymTimes;
@synthesize gymNameLabel;
@synthesize todayDateLabel;
@synthesize gymRoster;




@synthesize selectedTimeLabel;




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    
        
    
            
    

    
    
    
     
    gymNameLabel.text = gymLabelText;
    
    
    
    
    NSDate *date = [NSDate date];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-yyyy "];
    NSString* today = [formatter stringFromDate:date];
    [todayDateLabel setText:today];
    
    timePicker.showsSelectionIndicator = TRUE;
    timePicker.delegate = self;
    timePicker.dataSource = self;
    
    gymTimes = [[NSMutableArray alloc]initWithObjects:@"6:00 AM",@"6:30 AM",@"7:00 AM",@"7:30 AM",@"8:00 AM",@"8:30 AM",@"9:00 AM",@"9:30 AM",@"10:00 AM",@"10:30 AM",@"11:00 AM",@"11:30 AM",@"12:00 PM",@"12:30 PM",@"1:00 PM",@"1:30 PM",@"2:00 PM",@"2:30 PM",@"3:00 PM",@"3:30 PM",@"4:00 PM",@"4:30 PM",@"5:00 PM",@"5:30 PM",@"6:00 PM",@"6:30 PM",@"7:00 PM",@"7:30 PM",@"8:00 PM",@"8:30 PM",@"9:00 PM",@"9:30 PM",@"10:00 PM",@"10:30 PM",@"11:00 PM",@"11:30 PM", nil];
    
    self.tableView.backgroundColor = [UIColor colorWithRed:0.204 green:0.239 blue:0.271 alpha:1];
    
    
    self.tableView.separatorColor = [UIColor colorWithRed:0.047 green:0.965 blue:0.443 alpha:1];
    
   [gymNameLabel setFont:[UIFont fontWithName:@"Avenir-BlackOblique" size:17]];
    
    
    
}



-(void)viewWillAppear:(BOOL)animated

{
    
    
    NSDate *time = [NSDate date];
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc]init];
    [timeFormatter setDateFormat:@"hh:mm a"];
    NSString *systemTime = [timeFormatter stringFromDate:time];
    
    
    if ([systemTime isEqualToString:@"12:00 AM"])
        
    {
        
        
        NSString *none = @"none";
        [[PFUser currentUser] setObject:none forKey:@"selectedTime"];
        [[PFUser currentUser] setObject:none forKey:@"selectedGym"];
        [[PFUser currentUser] saveInBackground];
        
        [self.tableView reloadData];
    }
    
    
    
    
    
    
    
    PFQuery *query = [PFUser query];
    [query whereKey:@"selectedGym" equalTo:gymNameLabel.text];
    [query orderByAscending:@"selectedTime"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     
     {
         
             
         gymRoster = objects;
         
         
                  [self.tableView reloadData];
         
         
     }];
    
   
    
}



//Table View


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [gymRoster count];
    
    
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    // Configure the cell...
    
    //cell.textLabel.text = [[self.gymRoster objectAtIndex:indexPath.row] valueForKey:@"username"];
    PFUser *user = [gymRoster objectAtIndex:indexPath.row];
    cell.textLabel.text = user.username;
    cell.detailTextLabel.text = [[gymRoster objectAtIndex:indexPath.row]valueForKey:@"selectedTime"];
    
    cell.textLabel.textColor = [UIColor colorWithRed:0.929 green:0.933 blue:0.933 alpha:1];
    cell.backgroundColor = [UIColor clearColor];
   // PFFile *thumbnail =[[gymRoster objectAtIndex:indexPath.row]valueForKeyPath:@"profilePic"];
    
    
    
    return cell;
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"showProfileView"])
    {
        ProfileDetailViewController *profileDetailVC =(ProfileDetailViewController *)segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        PFUser * user = [gymRoster objectAtIndex:indexPath.row];
        
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
    }}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    PFUser *user = [gymRoster objectAtIndex:indexPath.row];
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


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    //One column
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    //set number of rows
    return [gymTimes count];
    

}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    //set item per row
    return [gymTimes objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component
{
    
    selectedTimeLabel.text = [gymTimes objectAtIndex:row];
    

}




- (IBAction)addButton:(id)sender

{
    

    if ( [selectedTimeLabel.text length] ==  0)
    
    {
        UIAlertView *alert =  [[UIAlertView alloc]initWithTitle:@"Oops" message:@"Make sure you select the time you will coming to the gym." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        
    }
    else
    {
    
    [[PFUser currentUser] setObject:selectedTimeLabel.text forKey:@"selectedTime"];
    [[PFUser currentUser] setObject:gymNameLabel.text forKey:@"selectedGym"];
    [[PFUser currentUser] saveInBackground];
    
    }
    
    
}

- (IBAction)minusButton:(id)sender {
    
    
    [self.tableView reloadData];
    NSString *none = @"none";
    [[PFUser currentUser] setObject:none forKey:@"selectedTime"];
    [[PFUser currentUser] setObject:none forKey:@"selectedGym"];
    [[PFUser currentUser] saveInBackground];

    

}






@end
