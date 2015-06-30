//
//  EditFriendsViewController.h
//  NextUp
//
//  Created by Michael Lee on 4/10/14.
//  Copyright (c) 2014 Michael Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>


@interface EditFriendsViewController : UITableViewController <UISearchBarDelegate>
@property ( nonatomic,strong) NSArray *allUsers;
@property (nonatomic,strong) PFUser *currentUser;
@property (nonatomic,strong) NSMutableArray *friends;





-(BOOL)isFriend:(PFUser *)user;
@end

