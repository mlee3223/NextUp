//
//  GymInfoDetailViewController.h
//  NextUp
//
//  Created by Michael Lee on 4/13/14.
//  Copyright (c) 2014 Michael Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>



@interface GymInfoDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *gymLabel;

@property (strong ,nonatomic) NSString *gymLabelText;
@property (strong ,nonatomic) NSArray *gymUsers;
@property (strong, nonatomic) IBOutlet UILabel *gymCountLabel;
@property (strong,nonatomic) NSString *selectedUserId;
- (IBAction)gymRosterButton:(id)sender;



@property (strong, nonatomic) IBOutlet UITableView *tableView;



















@end
